import 'package:final_project/models/auth/user/user_model.dart';
import 'package:final_project/providers/providers.dart';
import 'package:final_project/providers/states/auth_state.dart';
import 'package:final_project/services/repositories/user_subscribed_feed_repository.dart';
import 'package:final_project/services/storage/auth/auth_storage_service.dart';
import 'package:final_project/services/storage/subscriptions/user_subscriptions_storage_service.dart';
import 'package:final_project/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomAuthProvider extends StateNotifier<AuthState> {
  late UserModel? _currentUser;
  final FirebaseAuth _auth;
  final AuthStorageService _authStorageService;
  final UserSubscriptionsStorageService _userSubscriptionsStorageService;
  final UserSubscribedFeedRepository _userSubscribedFeedRepository;
  final Ref _ref;

  CustomAuthProvider({
    required FirebaseAuth auth,
    required AuthStorageService authStorageService,
    required UserSubscriptionsStorageService userSubscriptionsStorageService,
    required UserSubscribedFeedRepository userSubscribedFeedRepository,
    required Ref ref,
  })  : _authStorageService = authStorageService,
        _userSubscriptionsStorageService = userSubscriptionsStorageService,
        _userSubscribedFeedRepository = userSubscribedFeedRepository,
        _auth = auth,
        _ref = ref,
        super(const AuthState.unauthenticated()) {
    init();
  }

  void init() {
    final authenticated = _authStorageService.isAuthenticated;
    _currentUser = _authStorageService.user;
    if (!authenticated || _currentUser == null) {
      state = const AuthState.unauthenticated();
    } else {
      state = AuthState.authenticated(email: _currentUser!.email);
    }
  }

  UserModel get currentUser => _currentUser!;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthState.authenticating();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _parseUserCredsAndStore(userCredential, email);
    } on FirebaseAuthException {
      state = const AuthState.failed(reason: ErrorMessages.invalidCredentials);
    } on Exception {
      state = const AuthState.failed(reason: ErrorMessages.unknownError);
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
      _parseUserCredsAndStore(userCredential, email);
    } on FirebaseAuthException catch (e) {
      state = AuthState.failed(reason: e.message!);
    } on Exception {
      state = const AuthState.failed(reason: ErrorMessages.unknownError);
    }
  }

  void logout() {
    _currentUser = null;
    _authStorageService.resetKeys();
    _userSubscriptionsStorageService.resetKeys();
    _ref.read(userSubscribedFeedProvider.notifier).clearState();
    state = const AuthState.unauthenticated();
  }

  Future<String> _extractToken(User? userCredential) async {
    String? idToken = await userCredential!.getIdToken();
    if (idToken == null) {
      throw Exception("Token generation failed");
    }
    return idToken;
  }

  Future<void> _parseUserCredsAndStore(
      UserCredential userCredential, String email) async {
    _currentUser = UserModel(userId: userCredential.user!.uid, email: email);
    _authStorageService.saveUser(_currentUser!);

    String token = await _extractToken(userCredential.user);
    _authStorageService.saveToken(token);

    state = AuthState.authenticated(email: _currentUser!.email);
    _authStorageService.saveState(state);

    final subscriptions = await _userSubscribedFeedRepository
        .fetchAllByUserId(_currentUser!.userId);

    _userSubscriptionsStorageService.saveSubscriptions(
        subscriptions.map((e) => e.subscribedProviderId).toList());

    _ref.read(userSubscribedFeedProvider.notifier).syncStateWithStorage();
  }
}
