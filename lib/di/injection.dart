import 'package:buro_app/features/login/data/repository/login_repository_impl.dart';
import 'package:buro_app/features/login/data/service/login_service.dart';
import 'package:buro_app/features/login/domain/repository/login_repository.dart';
import 'package:buro_app/features/login/domain/usecase/login_use_case.dart';
import 'package:buro_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:buro_app/features/welcome/data/repository/carousel_repository.dart';
import 'package:buro_app/features/welcome/data/service/carousel_service.dart';
import 'package:buro_app/features/welcome/domain/repository/carousel_repository.dart';
import 'package:buro_app/features/welcome/domain/usecase/get_carousel_use_case.dart';
import 'package:buro_app/features/welcome/presentation/cubit/carousel_cubit.dart';
import 'package:buro_app/features/welcome/presentation/cubit/user_name_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {

  getIt.registerLazySingleton<LoginService>(() => LoginService());

  getIt.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(getIt<LoginService>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(getIt<LoginRepository>()),
  );

  getIt.registerFactory<LoginCubit>(
        () => LoginCubit(getIt<LoginUseCase>()),
  );



  getIt.registerLazySingleton<CarouselService>(() => CarouselService());

  getIt.registerLazySingleton<CarouselRepository>(
        () => CarouselRepositoryImpl(getIt<CarouselService>()),
  );

  getIt.registerLazySingleton<GetCarouselUseCase>(
        () => GetCarouselUseCase(getIt<CarouselRepository>()),
  );

  getIt.registerFactory<CarouselCubit>(
        () => CarouselCubit(getIt<GetCarouselUseCase>()),
  );

  getIt.registerFactory<UserNameCubit>(
        () => UserNameCubit(),
  );
}