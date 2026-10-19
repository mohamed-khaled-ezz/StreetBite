import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasources/firebase_auth_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/sign_up_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/cart/domain/usecases/place_order_usecase.dart';
import '../../features/cart/presentation/cubit/address_cubit.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/favorites/domain/usecases/set_favorite_usecase.dart';
import '../../features/favorites/domain/usecases/watch_favorites_usecase.dart';
import '../../features/favorites/presentation/cubit/favorites_cubit.dart';
import '../../features/home/data/datasources/meal_datasource_factory.dart';
import '../../features/home/data/datasources/meal_local_datasource.dart';
import '../../features/home/data/datasources/meal_remote_datasource.dart';
import '../../features/home/data/repositories/meal_repository_impl.dart';
import '../../features/home/domain/repositories/meal_repository.dart';
import '../../features/home/domain/usecases/get_categories_usecase.dart';
import '../../features/home/domain/usecases/get_meal_by_id_usecase.dart';
import '../../features/home/domain/usecases/get_meals_by_category_usecase.dart';
import '../../features/home/domain/usecases/get_meals_usecase.dart';
import '../../features/home/domain/usecases/search_meals_usecase.dart';
import '../../features/home/domain/usecases/watch_orders_usecase.dart';
import '../../features/home/presentation/cubit/browse_cubit.dart';
import '../../features/home/presentation/cubit/meals_cubit.dart';
import '../../features/home/presentation/cubit/orders_cubit.dart';
import '../../features/profile/data/datasources/device_info_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/update_profile_photo_usecase.dart';
import '../../features/profile/domain/usecases/watch_profile_usecase.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/splash/presentation/cubit/splash_cubit.dart';
import '../network/dio_client.dart';
import '../services/firestore_service.dart';
import '../theme/locale_cubit.dart';
import '../theme/theme_bloc.dart';

final GetIt getIt = GetIt.instance;

/// Dependency injection with GetIt: data sources and repositories are
/// singletons; blocs/cubits are created by the root widget from factories.
Future<void> configureDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  getIt
    ..registerSingleton<SharedPreferences>(prefs)
    ..registerLazySingleton<Dio>(DioClient.create)
    ..registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance)
    ..registerLazySingleton<FirestoreService>(() => FirestoreService())
    ..registerLazySingleton(() => MealRemoteDataSource(getIt()))
    ..registerLazySingleton(() => MealLocalDataSource(getIt()))
    ..registerLazySingleton(() => MealDataSourceFactory(getIt(), getIt()))
    ..registerLazySingleton(() => FirebaseAuthDataSource(getIt()))
    ..registerLazySingleton(DeviceInfoDataSource.new)
    ..registerLazySingleton<MealRepository>(
        () => MealRepositoryImpl(getIt(), getIt(), getIt()))
    ..registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(getIt(), getIt()))
    ..registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(getIt()))
    ..registerLazySingleton(() => GetMealsUseCase(getIt()))
    ..registerLazySingleton(() => SearchMealsUseCase(getIt()))
    ..registerLazySingleton(() => GetCategoriesUseCase(getIt()))
    ..registerLazySingleton(() => GetMealsByCategoryUseCase(getIt()))
    ..registerLazySingleton(() => GetMealByIdUseCase(getIt()))
    ..registerLazySingleton(() => LoginUseCase(getIt()))
    ..registerLazySingleton(() => SignUpUseCase(getIt()))
    ..registerLazySingleton(() => LogoutUseCase(getIt()))
    ..registerLazySingleton(() => WatchProfileUseCase(getIt()))
    ..registerLazySingleton(() => UpdateProfilePhotoUseCase(getIt()))
    ..registerLazySingleton(() => WatchFavoritesUseCase(getIt()))
    ..registerLazySingleton(() => SetFavoriteUseCase(getIt()))
    ..registerLazySingleton(() => PlaceOrderUseCase(getIt()))
    ..registerLazySingleton(() => WatchOrdersUseCase(getIt()))
    ..registerFactory(() => SplashCubit(getIt()))
    ..registerFactory(() => AuthCubit(getIt(), getIt(), getIt(), getIt()))
    ..registerFactory(() => MealsCubit(getIt()))
    ..registerFactory(() => BrowseCubit(getIt(), getIt(), getIt(), getIt()))
    ..registerFactory(() => CartCubit(getIt()))
    ..registerFactory(() => ThemeBloc(getIt()))
    ..registerFactory(() => LocaleCubit(getIt()))
    ..registerFactory(() => FavoritesCubit(getIt(), getIt()))
    ..registerFactory(() => OrdersCubit(getIt()))
    ..registerFactory(() => ProfileCubit(getIt(), getIt(), getIt()))
    ..registerFactory(() => AddressCubit(getIt()));
}
