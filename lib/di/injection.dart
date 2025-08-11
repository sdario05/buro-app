import 'package:buro_app/features/login/data/repository/login_repository_impl.dart';
import 'package:buro_app/features/login/data/service/login_service.dart';
import 'package:buro_app/features/login/domain/repository/login_repository.dart';
import 'package:buro_app/features/login/domain/usecase/login_use_case.dart';
import 'package:buro_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:buro_app/features/modes/explorer/profession/data/repository/profession_repository_impl.dart';
import 'package:buro_app/features/modes/explorer/profession/data/service/profession_service.dart';
import 'package:buro_app/features/modes/explorer/profession/domain/repository/profession_repository.dart';
import 'package:buro_app/features/modes/explorer/profession/domain/usecase/send_profession_use_case.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/cubit/explorer_profession_cubit.dart';
import 'package:buro_app/features/welcome/data/repository/carousel_repository.dart';
import 'package:buro_app/features/welcome/data/service/carousel_service.dart';
import 'package:buro_app/features/welcome/domain/repository/carousel_repository.dart';
import 'package:buro_app/features/welcome/domain/usecase/get_carousel_use_case.dart';
import 'package:buro_app/features/welcome/presentation/cubit/carousel_cubit.dart';
import 'package:buro_app/shared/action/getgifanimation/data/repository/gif_animation_repository_impl.dart';
import 'package:buro_app/shared/action/getgifanimation/data/service/gif_animation_service.dart';
import 'package:buro_app/shared/action/getgifanimation/domain/repository/gif_animation_repository.dart';
import 'package:buro_app/shared/action/getgifanimation/domain/usecase/get_gif_animation_use_case.dart';
import 'package:buro_app/shared/action/getgifanimation/presentation/cubit/gif_animation_cubit.dart';
import 'package:buro_app/shared/cubit/user_name_cubit.dart';
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
  //========================================================================
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
  //========================================================================
  getIt.registerFactory<UserNameCubit>(
        () => UserNameCubit(),
  );
  //========================================================================
  getIt.registerLazySingleton<GifAnimationService>(() => GifAnimationService());

  getIt.registerLazySingleton<GifAnimationRepository>(
        () => GifAnimationRepositoryImpl(getIt<GifAnimationService>()),
  );

  getIt.registerLazySingleton<GetGifAnimationUseCase>(
        () => GetGifAnimationUseCase(getIt<GifAnimationRepository>()),
  );

  getIt.registerFactory<GifAnimationCubit>(
        () => GifAnimationCubit(getIt<GetGifAnimationUseCase>()),
  );
  //========================================================================
  getIt.registerLazySingleton<ProfessionService>(() => ProfessionService());

  getIt.registerLazySingleton<ProfessionRepository>(
        () => ProfessionRepositoryImpl(getIt<ProfessionService>()),
  );

  getIt.registerLazySingleton<SendProfessionUseCase>(
        () => SendProfessionUseCase(getIt<ProfessionRepository>()),
  );

  getIt.registerFactory<ExplorerProfessionCubit>(
        () => ExplorerProfessionCubit(getIt<SendProfessionUseCase>()),
  );
}