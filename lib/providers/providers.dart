import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/states/auth_state.dart';
import 'package:final_project/services/storage/auth/auth_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStorageProvider = Provider<AuthStorageService>((ref) {
  return AuthStorageService();
});

final authProvider =
    StateNotifierProvider<CustomAuthProvider, AuthState>((ref) {
  final authStorageService = ref.watch(authStorageProvider);
  final auth = ref.watch(firebaseAuthProvider);
  return CustomAuthProvider(
      auth: auth, authStorageService: authStorageService, ref: ref);
});
