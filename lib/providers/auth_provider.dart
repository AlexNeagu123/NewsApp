import 'package:final_project/providers/states/auth_state.dart';
import 'package:final_project/services/storage/auth/auth_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomAuthProvider extends StateNotifier<AuthState> {
  late User? _currentUser;
  final FirebaseAuth _auth;
  final AuthStorageService _authStorageService;

  CustomAuthProvider({
    required FirebaseAuth auth,
    required AuthStorageService authStorageService,
    required Ref ref,
  })  : _authStorageService = authStorageService,
        _auth = auth,
        super(const AuthState.unauthenticated()) {
    init();
  }

  void init() async {
    final authenticated = _authStorageService.state;
    _currentUser = _authStorageService.user;
    if (!authenticated || _currentUser == null) {
      logout();
    } else {
      state = AuthState.authenticated(email: _currentUser!.email!);
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthState.authenticating();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _currentUser = userCredential.user;
      _authStorageService.saveUser(_currentUser!);
      String token = await _extractToken();
      _authStorageService.saveToken(token);
      state = AuthState.authenticated(email: _currentUser!.email!);
      _authStorageService.saveState(state);
    } on Exception {
      state = const AuthState.failed(reason: "Login failed");
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    state = const AuthState.authenticating();
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _currentUser = userCredential.user;
      String token = await _extractToken();
      _authStorageService.saveToken(token);
      _authStorageService.saveUser(_currentUser!);
      state = AuthState.authenticated(email: _currentUser!.email!);
      _authStorageService.saveState(state);
    } on Exception {
      state = const AuthState.failed(reason: "Registration failed");
    }
  }

  void logout() {
    _currentUser = null;
    state = const AuthState.unauthenticated();
    _authStorageService.resetKeys();
  }

  Future<String> _extractToken() async {
    String? idToken = await _currentUser!.getIdToken();
    if (idToken == null) {
      throw Exception("Token generation failed");
    }
    return idToken;
  }
}
