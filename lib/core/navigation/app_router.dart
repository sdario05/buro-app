import 'package:buro_app/features/job_detail/presentation/screen/job_detail_screen.dart';
import 'package:buro_app/features/login/presentation/screen/login_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_activation_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_course_question_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_course_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_cv_completed_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_cv_summary_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_education_question_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_education_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_experience_question_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_experience_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_language_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_personal_info_question_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_personal_info_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_photo_question_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_photo_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_profession_input_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_professional_summary_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_professional_welcome_screen.dart';
import 'package:buro_app/features/modes/mode_explanation/presentation/screen/mode_explanation_screen.dart';
import 'package:buro_app/features/modes/explorer/completed/presentation/screen/explorer_upload_success_screen.dart';
import 'package:buro_app/features/modes/explorer/contact/presentation/screen/explorer_contact_screen.dart';
import 'package:buro_app/features/modes/explorer/explanation/presentation/screen/explorer_explanation_screen.dart';
import 'package:buro_app/features/modes/explorer/home/presentation/screen/explorer_home_screen.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/screen/explorer_confirmation_screen.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/screen/explorer_profession_screen.dart';
import 'package:buro_app/features/modes/explorer/reminder/presentation/screen/explorer_upload_activation_screen.dart';
import 'package:buro_app/features/modes/explorer/upload_cv/presentation/screen/explorer_cv_success_screen.dart';
import 'package:buro_app/features/modes/explorer/upload_cv/presentation/screen/explorer_upload_cv_screen.dart';
import 'package:buro_app/features/modes/explorer/welcome/presentation/screen/explorer_welcome_screen.dart';
import 'package:buro_app/features/registration/register_screen.dart';
import 'package:buro_app/features/welcome/presentation/screen/welcome_screen.dart';
import 'package:buro_app/features/registration/already_registered_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_generate_cv_info_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_generate_cv_welcome_screen.dart';
import 'package:buro_app/features/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:buro_app/features/home/presentation/screen/home_screen.dart';
import 'package:buro_app/features/modes/explorer/generate_cv/presentation/screen/explorer_cv_photo_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      name: 'onboarding',
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      name: 'alreadyRegistered',
      path: '/alreadyRegistered',
      builder: (context, state) => const AlreadyRegisteredScreen(),
    ),
    GoRoute(
      name: 'welcome',
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
      routes: [
        GoRoute(
          name: 'explorer_explanation',
          path: '/explorer_explanation',
          builder: (context, state) => const ExplorerExplanationScreen(),
          routes: [
            GoRoute(
                name: 'explorer_welcome',
                path: '/explorer_welcome',
                builder: (context, state) => const ExplorerWelcomeScreen(),
                routes: [
                  GoRoute(
                      name: 'explorer_upload_cv',
                      path: '/explorer_upload_cv',
                      builder: (context, state) => const ExplorerUploadCvScreen(),
                      routes: [
                        GoRoute(
                            name: 'explorer_cv_success',
                            path: '/explorer_cv_success',
                            builder: (context, state) => const ExplorerCvSuccessScreen(),
                            routes: [
                              GoRoute(
                                  name: 'explorer_dashboard',
                                  path: '/explorer_dashboard',
                                  builder: (context, state) => const ExplorerProfessionScreen(),
                                  routes: [
                                    GoRoute(
                                        name: 'explorer_confirmation',
                                        path: '/explorer_confirmation',
                                        builder: (context, state) {
                                          final professions = state.extra as List<String>? ?? [];
                                          return ExplorerConfirmationScreen(professions: professions);
                                        },
                                        routes: [
                                          GoRoute(
                                              name: 'explorer_contact',
                                              path: '/explorer_contact',
                                              builder: (context, state) => const ExplorerContactScreen(),
                                              routes: [
                                                GoRoute(
                                                    name: 'explorer_upload_success',
                                                    path: '/explorer_upload_success',
                                                    builder: (context, state) => const ExplorerUploadSuccessScreen(),
                                                    routes: [
                                                      GoRoute(
                                                          name: 'explorer_upload_activation',
                                                          path: '/explorer_upload_activation',
                                                          builder: (context, state) => const ExplorerUploadActivationScreen(),
                                                          routes: [
                                                            GoRoute(
                                                                name: 'explorer_home',
                                                                path: '/explorer_home',
                                                                builder: (context, state) => const ExplorerHomeScreen(),
                                                            ),
                                                          ]
                                                      ),
                                                    ]
                                                ),
                                              ]
                                          ),
                                        ]
                                    ),
                                  ]
                              ),
                            ]
                        ),
                      ]
                  ),
                  GoRoute(
                    name: 'explorer_generate_cv',
                    path: '/explorer_generate_cv',
                    builder: (context, state) => const ExplorerGenerateCVWelcomeScreen(),
                    routes: [
                      GoRoute(
                          name: 'explorer_generate_cv_info',
                          path: '/explorer_generate_cv_info',
                          builder: (context, state) => const ExplorerGenerateCVInfoScreen(),
                          routes: [
                            GoRoute(
                                name: 'explorer_language',
                                path: '/explorer_language',
                                builder: (context, state) => const ExplorerLanguageScreen(),
                                routes: [
                                  GoRoute(
                                      name: 'explorer_education_question',
                                      path: '/explorer_education_question',
                                      builder: (context, state) => const ExplorerEducationQuestionScreen(),
                                      routes: [
                                        GoRoute(
                                            name: 'explorer_education',
                                            path: '/explorer_education',
                                            builder: (context, state) => const ExplorerEducationScreen(),
                                            routes: [
                                              GoRoute(
                                                  name: 'explorer_personal_info_question',
                                                  path: '/explorer_personal_info_question',
                                                  builder: (context, state) => const ExplorerPersonalInfoQuestionScreen(),
                                                  routes: [
                                                    GoRoute(
                                                        name: 'explorer_personal_info',
                                                        path: '/explorer_personal_info',
                                                        builder: (context, state) => const ExplorerPersonalInfoScreen(),
                                                        routes: [
                                                          GoRoute(
                                                              name: 'explorer_photo_question',
                                                              path: '/explorer_photo_question',
                                                              builder: (context, state) => const ExplorerPhotoQuestionScreen(),
                                                              routes: [
                                                                GoRoute(
                                                                    name: 'explorer_cv_summary',
                                                                    path: '/explorer_cv_summary',
                                                                    builder: (context, state) => const ExplorerCVSummaryScreen(),
                                                                    routes: [
                                                                      GoRoute(
                                                                          name: 'explorer_professional_welcome',
                                                                          path: '/explorer_professional_welcome',
                                                                          builder: (context, state) => const ExplorerProfessionalWelcomeScreen(),
                                                                          routes: [
                                                                            GoRoute(
                                                                                name: 'explorer_profession_input',
                                                                                path: '/explorer_profession_input',
                                                                                builder: (context, state) => const ExplorerProfessionInputScreen(),
                                                                                routes: [
                                                                                  GoRoute(
                                                                                      name: 'explorer_experience_question',
                                                                                      path: '/explorer_experience_question',
                                                                                      builder: (context, state) => const ExplorerExperienceQuestionScreen(),
                                                                                      routes: [
                                                                                        GoRoute(
                                                                                            name: 'explorer_experience',
                                                                                            path: '/explorer_experience',
                                                                                            builder: (context, state) => const ExplorerExperienceScreen(),
                                                                                            routes: [
                                                                                              GoRoute(
                                                                                                  name: 'explorer_course_question',
                                                                                                  path: '/explorer_course_question',
                                                                                                  builder: (context, state) => const ExplorerCourseQuestionScreen(),
                                                                                                  routes: [
                                                                                                    GoRoute(
                                                                                                        name: 'explorer_course',
                                                                                                        path: '/explorer_course',
                                                                                                        builder: (context, state) => const ExplorerCourseScreen(),
                                                                                                        routes: [
                                                                                                          GoRoute(
                                                                                                              name: 'explorer_contact_from_explorer_course',
                                                                                                              path: '/explorer_contact_from_explorer_course',
                                                                                                              builder: (context, state) => const ExplorerContactScreen(),
                                                                                                          ),

                                                                                                        ]
                                                                                                    ),
                                                                                                    GoRoute(
                                                                                                        name: 'explorer_contact_from_explorer_course_question',
                                                                                                        path: '/explorer_contact_from_explorer_course_question',
                                                                                                        builder: (context, state) => const ExplorerContactScreen(),
                                                                                                    ),
                                                                                                  ]
                                                                                              ),
                                                                                              GoRoute(
                                                                                                  name: 'explorer_course_question_from_explorer_experience_question',
                                                                                                  path: '/explorer_course_question_from_explorer_experience_question',
                                                                                                  builder: (context, state) => const ExplorerCourseQuestionScreen(),
                                                                                              ),
                                                                                            ]
                                                                                        ),
                                                                                      ]
                                                                                  ),
                                                                                ]
                                                                            ),
                                                                            GoRoute(
                                                                                name: 'explorer_profession_input_from_explorer_professional_welcome',
                                                                                path: '/explorer_profession_input_from_explorer_professional_welcome',
                                                                                builder: (context, state) => const ExplorerProfessionInputScreen(),
                                                                            ),
                                                                          ]
                                                                      ),
                                                                      GoRoute(
                                                                         name: 'explorer_profession_input_from_explorer_cv_summary',
                                                                         path: '/explorer_profession_input_from_explorer_cv_summary',
                                                                         builder: (context, state) => const ExplorerProfessionInputScreen(),
                                                                      ),
                                                                      GoRoute(
                                                                         name: 'explorer_experience_from_explorer_cv_summary',
                                                                         path: '/explorer_experience_from_explorer_cv_summary',
                                                                         builder: (context, state) => const ExplorerExperienceScreen(),
                                                                      ),
                                                                      GoRoute(
                                                                         name: 'explorer_language_from_explorer_cv_summary',
                                                                         path: '/explorer_language_from_explorer_cv_summary',
                                                                         builder: (context, state) => const ExplorerLanguageScreen(),
                                                                      ),
                                                                      GoRoute(
                                                                         name: 'explorer_education_from_explorer_cv_summary',
                                                                         path: '/explorer_education_from_explorer_cv_summary',
                                                                         builder: (context, state) => const ExplorerEducationScreen(),
                                                                      ),
                                                                      GoRoute(
                                                                         name: 'explorer_personal_info_from_explorer_cv_summary',
                                                                         path: '/explorer_personal_info_from_explorer_cv_summary',
                                                                         builder: (context, state) => const ExplorerPersonalInfoScreen(),
                                                                      ),
                                                                      GoRoute(
                                                                          name: 'explorer_cv_photo_from_explorer_cv_summary',
                                                                          path: '/explorer_cv_photo_from_explorer_cv_summary',
                                                                          builder: (context, state) => const ExplorerCVPhotoScreen(),
                                                                          routes: [
                                                                            GoRoute(
                                                                                name: 'explorer_professional_summary',
                                                                                path: '/explorer_professional_summary',
                                                                                builder: (context, state) => const ExplorerProfessionalSummaryScreen(),
                                                                                routes: [
                                                                                  GoRoute(
                                                                                    name: 'explorer_cv_completed',
                                                                                    path: '/explorer_cv_completed',
                                                                                    builder: (context, state) => const ExplorerCVCompletedScreen(),
                                                                                    routes: [
                                                                                      GoRoute(
                                                                                        name: 'explorer_activation',
                                                                                        path: '/explorer_activation',
                                                                                        builder: (context, state) => const ExplorerActivationScreen(),
                                                                                        routes: [
                                                                                          GoRoute(
                                                                                            name: 'explorer_home_from_explorer_activation',
                                                                                            path: '/explorer_home_from_explorer_activation',
                                                                                            builder: (context, state) => const ExplorerHomeScreen(),
                                                                                          ),
                                                                                        ]   
                                                                                      ),
                                                                                    ]   
                                                                                  ),
                                                                                ]   
                                                                            ), 
                                                                          ]
                                                                      ),                              
                                                                    ]
                                                                ),
                                                                GoRoute(
                                                                  name: 'explorer_photo',
                                                                  path: '/explorer_photo',
                                                                  builder: (context, state) => const ExplorerPhotoScreen(),
                                                                  routes: [
                                                                    GoRoute(
                                                                      name: 'explorer_cv_summary_from_explorer_photo',
                                                                      path: '/explorer_cv_summary_from_explorer_photo',
                                                                      builder: (context, state) => const ExplorerCVSummaryScreen(),
                                                                    ),
                                                                  ]
                                                                ),
                                                              ]
                                                          ),
                                                        ]
                                                    ),
                                                    GoRoute(
                                                        name: 'explorer_photo_question_from_explorer_personal_info_question',
                                                        path: '/explorer_photo_question_from_explorer_personal_info_question',
                                                        builder: (context, state) => const ExplorerPhotoQuestionScreen(),
                                                    ),
                                                  ]
                                              ),
                                              GoRoute(
                                                  name: 'explorer_personal_info_question_from_explorer_education_question',
                                                  path: '/explorer_personal_info_question_from_explorer_education_question',
                                                  builder: (context, state) => const ExplorerPersonalInfoQuestionScreen(),
                                              ),

                                            ]
                                        ),
                                      ]
                                  ),
                                ]
                            ),
                          ]
                      ),
                    ]
                  ),
                ]
            ),
          ]
        ),
        GoRoute(
          name: 'mode_explanation',
          path: '/mode_explanation',
          builder: (context, state) {
            final mode = state.extra as String? ?? '';
            return ModeExplanationScreen(mode: mode);
          },
          routes: [
            GoRoute(
              name: 'home',
              path: '/home',
              builder: (context, state) => HomeScreen(onModeChange: (value) {}),
            ),
          ]
        ),
      ]
    ),
  ]
);