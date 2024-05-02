import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/news_providers_provider.dart';
import 'package:final_project/providers/states/auth_state.dart';
import 'package:final_project/services/repositories/news_providers_repository.dart';
import 'package:final_project/services/storage/auth/auth_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final newsProvidersRepositoryProvider =
    Provider<NewsProvidersRepository>((ref) {
  return NewsProvidersRepository.instance;
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

final newsProvidersProvider = Provider<NewsProvidersProvider>((ref) {
  final newsProvidersRepository = ref.watch(newsProvidersRepositoryProvider);
  return NewsProvidersProvider(
      newsProvidersRepository: newsProvidersRepository);
});

final newsCategoriesProvider = FutureProvider<List<String>>((ref) {
  final newsProviders = ref.watch(newsProvidersProvider);
  return newsProviders.getNewsCategories();
});
