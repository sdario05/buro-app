import 'package:buro_app/features/login/presentation/screen/login_screen.dart';
import 'package:buro_app/features/modes/explorer/completed/presentation/screen/explorer_upload_success_screen.dart';
import 'package:buro_app/features/modes/explorer/contact/presentation/screen/explorer_contact_screen.dart';
import 'package:buro_app/features/modes/explorer/explanation/presentation/screen/explorer_explanation_screen.dart';
import 'package:buro_app/features/modes/explorer/home/presentation/screen/explorer_home_screen.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/screen/explorer_confirmation_screen.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/screen/explorer_profession_screen.dart';
import 'package:buro_app/features/modes/explorer/reminder/presentation/screen/explorer_upload_activation_screen.dart';
import 'package:buro_app/features/modes/explorer/uploadcv/presentation/screen/explorer_cv_success_screen.dart';
import 'package:buro_app/features/modes/explorer/uploadcv/presentation/screen/explorer_upload_cv_screen.dart';
import 'package:buro_app/features/modes/explorer/welcome/presentation/screen/explorer_welcome_screen.dart';
import 'package:buro_app/features/welcome/presentation/screen/welcome_screen.dart';
import 'package:buro_app/screen/onboarding_screen.dart';
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
                ]
            ),
          ]
        ),
      ]
    ),
  ]
);