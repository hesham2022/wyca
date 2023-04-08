import 'package:get_it/get_it.dart';
import 'package:wyca/core/api_config/index.dart';
import 'package:wyca/core/local_storage/token_storage.dart';
import 'package:wyca/features/auth/data/datasources/auth_remote.dart';
import 'package:wyca/features/auth/data/datasources/provider_remote.dart';
import 'package:wyca/features/auth/data/datasources/user_remote.dart';
import 'package:wyca/features/auth/data/repositories/auth_respository.dart';
import 'package:wyca/features/auth/data/repositories/provider_repository.dart';
import 'package:wyca/features/auth/data/repositories/user_repository.dart';
import 'package:wyca/features/auth/domain/repositories/i_provider.dart';
import 'package:wyca/features/auth/domain/repositories/i_respository.dart';
import 'package:wyca/features/auth/domain/repositories/i_user.dart';
import 'package:wyca/features/auth/domain/usecases/get_near_providers.dart';
import 'package:wyca/features/auth/domain/usecases/index.dart';
import 'package:wyca/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wyca/features/auth/presentation/bloc/provider_cubit.dart';
import 'package:wyca/features/auth/presentation/bloc/user_cubit.dart';
import 'package:wyca/features/auth/presentation/forget_password_bloc/forget_password_cubit.dart';
import 'package:wyca/features/auth/presentation/login_bloc/login_bloc.dart';
import 'package:wyca/features/chat/data/datasources/chat_data_source.dart';
import 'package:wyca/features/chat/data/repositories/chat_repository.dart';
import 'package:wyca/features/chat/domain/repositories/i_chat_repository.dart';
import 'package:wyca/features/companmy_setting/data/datasources/companu_setting_remote.dart';
import 'package:wyca/features/companmy_setting/data/repositories/company_setting_repo.dart';
import 'package:wyca/features/companmy_setting/domain/repositories/i_company_setting_repo.dart';
import 'package:wyca/features/companmy_setting/presentation/bloc/calling_bloc.dart';
import 'package:wyca/features/companmy_setting/presentation/bloc/comlainment_cubit.dart';
import 'package:wyca/features/provider/branches/presentation/cubit/branches_cubit.dart';
import 'package:wyca/features/request/data/datasources/request_remote.dart';
import 'package:wyca/features/request/data/repositories/request_repository.dart';
import 'package:wyca/features/request/domain/repositories/i_request_reoository.dart';
import 'package:wyca/features/request/presentation/request_cubit.dart';
import 'package:wyca/features/request/presentation/request_provider.dart';
import 'package:wyca/features/user/home/data/datasources/package_remote.dart';
import 'package:wyca/features/user/home/data/repositories/package_respository.dart';
import 'package:wyca/features/user/home/domain/repositories/i._package.repsoitory.dart';
import 'package:wyca/features/user/home/domain/usecases/get_packages.dart';
import 'package:wyca/features/user/home/presentation/packages_bloc/packages_bloc.dart';
import 'package:wyca/features/user/order/data/datasources/order_remote_datasource.dart';
import 'package:wyca/features/user/order/data/repositories/order_repository.dart';
import 'package:wyca/features/user/order/domain/repositories/i_order_respository.dart';
import 'package:wyca/features/user/order/domain/usecases/get_orders_usecase.dart';
import 'package:wyca/features/user/order/presentation/bloc/order_bloc.dart';
// import 'package:traveler/core/api_config/api_client.dart';
// import 'package:traveler/core/core.dart';
// import 'package:traveler/features/login/data/datasources/auth_remote.dart';
// import 'package:traveler/features/login/data/datasources/user_remote.dart';
// import 'package:traveler/features/login/data/repositories/auth_repository.dart';
// import 'package:traveler/features/login/data/repositories/user_repository.dart';
// import 'package:traveler/features/login/domain/repositories/i_repository.dart';
// import 'package:traveler/features/login/domain/repositories/i_user.dart';
// import 'package:traveler/features/login/domain/usecases/get_user.dart';
// import 'package:traveler/features/login/presentation/bloc/auth_bloc/auth_bloc.dart';
// import 'package:traveler/features/login/presentation/bloc/login_bloc/login_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt
//     // Utils
    ..registerLazySingleton<ApiClient>(ApiClient.new)
//     // Data Sources
    ..registerLazySingleton<ITokenStorage>(TokenStorage.new)
    ..registerLazySingleton<IAuthUserRemotDataSource>(
      () => AuthRemotUserDataSource(getIt<ApiClient>()),
    )
    ..registerLazySingleton<IUserRemote>(() => UserRemote(getIt()))
    ..registerLazySingleton<IProviderRemote>(() => ProviderRemote(getIt()))
    ..registerLazySingleton<IPackageRemote>(() => PackageRemote(getIt()))
    ..registerLazySingleton<IOrderRemote>(() => OrderRemote(getIt()))
    ..registerLazySingleton<IChatRemote>(() => ChatRemote(getIt()))
    ..registerLazySingleton<IRequestRemote>(() => RequestRemote(getIt()))
    ..registerLazySingleton<IComapnySettingsRemote>(
      () => ComapnySettingsRemote(getIt<ApiClient>()),
    )
//     /// Repositories
    ..registerLazySingleton<IAuthenticationRepository>(
      () => AuthenticationRepository(
        authenticationLocalDataSource: getIt<ITokenStorage>(),
        authRemotDataSource: getIt<IAuthUserRemotDataSource>(),
        apiConfig: getIt(),
      ),
    )
    ..registerLazySingleton<IUserRepository>(() => UserRepository(getIt()))
    ..registerLazySingleton<IProviderRepository>(
      () => ProviderRepository(getIt()),
    )
    ..registerLazySingleton<IPackageRepository>(
      () => PackageRepository(getIt()),
    )
    ..registerLazySingleton<IComapnySettingsRepository>(
      () => ComapnySettingsRepository(getIt()),
    )
    ..registerLazySingleton<IOrderRespository>(
      () => OrderRepository(getIt()),
    )
    ..registerLazySingleton<IChatRespository>(
      () => ChatRepository(getIt()),
    )
    ..registerLazySingleton<IRequestRespository>(
      () => RequestRepository(getIt()),
    )

    //Use Cases
    ..registerLazySingleton<GetUser>(() => GetUser(getIt()))
    ..registerLazySingleton<GetPackages>(() => GetPackages(getIt()))
    ..registerLazySingleton<GetNearPrviders>(() => GetNearPrviders(getIt()))
    ..registerLazySingleton<GetOrders>(() => GetOrders(getIt()))
    ..registerLazySingleton<CreateOrderUseCase>(
      () => CreateOrderUseCase(getIt()),
    )
    ..registerLazySingleton<UserCubit>(() => UserCubit(getIt()))
    ..registerLazySingleton<ProviderCubit>(ProviderCubit.new)
    ..registerFactory<CallingBloc>(
      () => CallingBloc(repository: getIt()),
    )
    ..registerFactory<ComplaintCubit>(
      () => ComplaintCubit(repository: getIt()),
    )
//     // ..registerLazySingleton<GetBootamps>(() => GetBootamps(getIt()))
//     // ..registerLazySingleton<GetCourses>(() => GetCourses(getIt()))
//     // ..registerLazySingleton<Search>(() π=> Search(repository: getIt()))
    // Blocs
    ..registerFactory<AuthenticationBloc>(
      () => AuthenticationBloc(
        authenticationRepository: getIt(),
        userRepository: getIt(),
        providerRepository: getIt(),
        userCubit: getIt(),
        providerCubit: getIt(),
      ),
    )
    ..registerFactory<LoginBloc>(
      () => LoginBloc(authenticationRepository: getIt()),
    )
    ..registerFactory<ForgetPasswordCubit>(
      () => ForgetPasswordCubit(authenticationRepository: getIt()),
    )

    //RegisterBloc
    ..registerFactory<RegisterBloc>(
      () => RegisterBloc(authenticationRepository: getIt()),
    ) //RegisterBloc
    ..registerFactory<RegisterProviderBloc>(
      () => RegisterProviderBloc(authenticationRepository: getIt()),
    )
    ..registerFactory<BranchesCubit>(() => BranchesCubit(getIt()))
    ..registerFactory<RequestCubit>(
      () => RequestCubit(requestRespository: getIt()),
    )
    ..registerFactory<RequestProviderCubit>(
      () => RequestProviderCubit(requestRespository: getIt()),
    )
    ..registerFactory<PackagesCubit>(
      () => PackagesCubit(getPackagesUse: getIt()),
    )
    ..registerFactory<OrderBloc>(
      () => OrderBloc(getOrders: getIt(), createOrder: getIt()),
    );
//   // ..registerFactory<SearchMovieCubit>(
//   //         () => SearchMovieCubit(search: getIt(),
//   //         loadingCubit: LoadingCubit()))
//   // ..registerFactory<BootcampsBloc>(() =>
//   //     BootcampsBloc(InitialBootcamps(), getBootamps: getIt<GetBootamps>()));
}
