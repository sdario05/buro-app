import 'package:buro_app/features/login/data/repository/login_repository_impl.dart';
import 'package:buro_app/features/login/data/service/login_service.dart';
import 'package:buro_app/features/login/domain/repository/login_repository.dart';
import 'package:buro_app/features/login/domain/usecase/login_use_case.dart';
import 'package:buro_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:buro_app/features/modes/explorer/contact/data/repository/contact_repository_impl.dart';
import 'package:buro_app/features/modes/explorer/contact/data/service/contact_service.dart';
import 'package:buro_app/features/modes/explorer/contact/domain/repository/contact_repository.dart';
import 'package:buro_app/features/modes/explorer/contact/domain/usecase/send_contact_use_case.dart';
import 'package:buro_app/features/modes/explorer/contact/presentation/cubit/explorer_contact_cubit.dart';
import 'package:buro_app/features/modes/explorer/home/data/repository/job_repository_impl.dart';
import 'package:buro_app/features/modes/explorer/home/data/service/job_service.dart';
import 'package:buro_app/features/modes/explorer/home/domain/repository/job_repository.dart';
import 'package:buro_app/features/modes/explorer/home/domain/usecase/get_job_use_case.dart';
import 'package:buro_app/features/modes/explorer/home/presentation/cubit/explorer_job_cubit.dart';
import 'package:buro_app/features/modes/explorer/profession/data/repository/profession_repository_impl.dart';
import 'package:buro_app/features/modes/explorer/profession/data/service/profession_service.dart';
import 'package:buro_app/features/modes/explorer/profession/domain/repository/profession_repository.dart';
import 'package:buro_app/features/modes/explorer/profession/domain/usecase/send_profession_use_case.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/cubit/explorer_profession_cubit.dart';
import 'package:buro_app/features/modes/explorer/uploadcv/data/repository/cv_repository_impl.dart';
import 'package:buro_app/features/modes/explorer/uploadcv/data/service/cv_service.dart';
import 'package:buro_app/features/modes/explorer/uploadcv/domain/repository/cv_repository.dart';
import 'package:buro_app/features/modes/explorer/uploadcv/domain/usecase/send_cv_use_case.dart';
import 'package:buro_app/features/modes/explorer/uploadcv/presentation/cubit/cv_cubit.dart';
import 'package:buro_app/features/welcome/data/repository/carousel_repository.dart';
import 'package:buro_app/features/welcome/data/service/carousel_service.dart';
import 'package:buro_app/features/welcome/domain/repository/carousel_repository.dart';
import 'package:buro_app/features/welcome/domain/usecase/get_carousel_use_case.dart';
import 'package:buro_app/features/welcome/presentation/cubit/carousel_cubit.dart';
import 'package:buro_app/shared/action/getImage/data/repository/image_repository_impl.dart';
import 'package:buro_app/shared/action/getImage/data/service/image_service.dart';
import 'package:buro_app/shared/action/getImage/domain/repository/image_repository.dart';
import 'package:buro_app/shared/action/getImage/domain/usecase/get_image_use_case.dart';
import 'package:buro_app/shared/action/getImage/presentation/cubit/image_cubit.dart';
import 'package:buro_app/shared/cubit/user_name_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Registrar Dio primero
  getIt.registerLazySingleton<Dio>(() => Dio());
  //========================================================================
  getIt.registerLazySingleton<LoginService>(() => LoginService(getIt<Dio>()));

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
  getIt.registerLazySingleton<ImageService>(() => ImageService());

  getIt.registerLazySingleton<ImageRepository>(
        () => ImageRepositoryImpl(getIt<ImageService>()),
  );

  getIt.registerLazySingleton<GetImageUseCase>(
        () => GetImageUseCase(getIt<ImageRepository>()),
  );

  getIt.registerFactory<ImageCubit>(
        () => ImageCubit(getIt<GetImageUseCase>()),
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
  //========================================================================
  getIt.registerLazySingleton<ContactService>(() => ContactService());

  getIt.registerLazySingleton<ContactRepository>(
        () => ContactRepositoryImpl(getIt<ContactService>()),
  );

  getIt.registerLazySingleton<SendContactUseCase>(
        () => SendContactUseCase(getIt<ContactRepository>()),
  );

  getIt.registerFactory<ExplorerContactCubit>(
        () => ExplorerContactCubit(getIt<SendContactUseCase>()),
  );
  //========================================================================
  getIt.registerLazySingleton<JobService>(() => JobService());

  getIt.registerLazySingleton<JobRepository>(
        () => JobRepositoryImpl(getIt<JobService>()),
  );

  getIt.registerLazySingleton<GetJobUseCase>(
        () => GetJobUseCase(getIt<JobRepository>()),
  );

  getIt.registerFactory<ExplorerJobCubit>(
        () => ExplorerJobCubit(getIt<GetJobUseCase>()),
  );
  //========================================================================
  getIt.registerLazySingleton<CvService>(() => CvService());

  getIt.registerLazySingleton<CvRepository>(
        () => CvRepositoryImpl(getIt<CvService>()),
  );

  getIt.registerLazySingleton<SendCvUseCase>(
        () => SendCvUseCase(getIt<CvRepository>()),
  );

  getIt.registerFactory<CvCubit>(
        () => CvCubit(getIt<SendCvUseCase>()),
  );
}