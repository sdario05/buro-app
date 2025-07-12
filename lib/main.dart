import 'package:buro_app/di/injection.dart';
import 'package:buro_app/preferences/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/onboarding_screen.dart';
import 'features/login/presentation/screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'features/welcome/presentation/screens/welcome_screen.dart';
import 'screens/mode_explanation_screen.dart';
import 'screens/already_registered_screen.dart';
import 'screens/home_screen.dart';
import 'screens/job_detail_screen.dart';
import 'screens/explorer_explanation_screen.dart';
import 'screens/explorer_welcome_screen.dart';
import 'screens/explorer_upload_cv_screen.dart';
import 'screens/explorer_cv_success_screen.dart';
import 'screens/explorer_profession_screen.dart';
import 'screens/explorer_confirmation_screen.dart';
import 'screens/explorer_contact_screen.dart';
import 'screens/explorer_success_screen.dart';
import 'screens/explorer_final_screen.dart';
import 'screens/explorer_home_screen.dart';
import 'screens/explorer_generate_cv_welcome_screen.dart';
import 'screens/explorer_generate_cv_info_screen.dart';
import 'screens/explorer_language_screen.dart';
import 'screens/explorer_education_question_screen.dart';
import 'screens/explorer_education_screen.dart';
import 'screens/explorer_personal_info_question_screen.dart';
import 'screens/explorer_personal_info_screen.dart';
import 'screens/explorer_photo_question_screen.dart';
import 'screens/explorer_photo_screen.dart';
import 'screens/explorer_cv_summary_screen.dart';
import 'screens/explorer_professional_welcome_screen.dart';
import 'screens/explorer_profession_input_screen.dart';
import 'screens/explorer_experience_question_screen.dart';
import 'screens/explorer_experience_screen.dart';
import 'screens/explorer_course_question_screen.dart';
import 'screens/explorer_course_screen.dart';
import 'screens/explorer_cv_photo_question_screen.dart';
import 'screens/explorer_cv_photo_screen.dart';
import 'screens/explorer_professional_summary_screen.dart';
import 'screens/explorer_cv_completed_screen.dart';
import 'screens/explorer_activation_screen.dart';
import 'models/user.dart';
import 'screens/explorer_upload_activation_screen.dart';
import 'screens/explorer_upload_success_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buro App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            minimumSize: const Size(44, 44),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          isDense: false,
        ),
      ),
      home: const AppNavigator(),
    );
  }
}

class AppNavigator extends StatefulWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {

  String _currentScreen = 'onboarding';
  User? _user;
  String? _selectedMode;
  bool _isLoading = true;
  dynamic _screenData;

  @override
  void initState() {
    super.initState();
    // Simulate checking for logged in user
    Future.delayed(const Duration(seconds: 1), () async {
      final prefs = AppPreferences.instance;
      final user = await prefs.getUser();
      if (mounted) {
        setState(() {
          if (user != null) {
            _currentScreen = 'welcome';
          }
          _isLoading = false;
        });
      }
    });
  }

  void navigateTo(String screen, {dynamic data}) {
    if (mounted) {
      setState(() {
        _currentScreen = screen;
        _screenData = data;
      });
    }
  }

  void handleLogout() {
    Future.delayed(const Duration(milliseconds: 100), () async {
      final prefs = AppPreferences.instance;
      await prefs.clearUser();
    });
    if (mounted) {
      setState(() {
        _user = null;
        _currentScreen = 'onboarding';
      });
    }
  }

  void handleModeSelection(String mode) {
    if (mounted) {
      setState(() {
        _selectedMode = mode;
        
        // Redirigir a la pantalla de explicación correspondiente según el modo
        if (mode == 'explorador') {
          _currentScreen = 'explorer_explanation';
        } else {
          _currentScreen = 'modeExplanation';
        }
      });
    }
  }

  void handleModeChange(String mode) {
    if (mode == 'logout') {
      handleLogout();
      return;
    }
    
    if (mounted) {
      setState(() {
        _selectedMode = mode;
        
        // Redirigir a la pantalla correspondiente según el modo
        if (mode == 'explorador') {
          _currentScreen = 'explorer_explanation';
        } else {
          _currentScreen = 'home';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    switch (_currentScreen) {
      case 'onboarding':
        return OnboardingScreen(onNavigate: navigateTo);
      case 'login':
        return LoginScreen(onNavigate: navigateTo);
      case 'register':
        return RegisterScreen(onNavigate: navigateTo);
      case 'welcome':
        return WelcomeScreen(
          onLogout: handleLogout,
          onModeSelect: handleModeSelection,
        );
      case 'modeExplanation':
        return ModeExplanationScreen(
          mode: _selectedMode ?? 'visitante',
          onNavigate: (screen) {
            if (screen == 'welcome') {
              // Si el usuario elige "No, prefiero ingresar directo"
              navigateTo('home');
            } else {
              navigateTo(screen);
            }
          },
          onBack: () => navigateTo('welcome'),
        );
      case 'alreadyRegistered':
        return AlreadyRegisteredScreen(onNavigate: navigateTo);
      case 'home':
        return HomeScreen(
          mode: _selectedMode ?? 'visitante',
          onModeChange: handleModeChange,
        );
      // Pantallas para el explorador
      case 'explorer_explanation':
        return ExplorerExplanationScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('welcome'),
        );
      case 'explorer_welcome':
        return ExplorerWelcomeScreen(
          user: _user!,
          onNavigate: navigateTo,
          onBack: () => navigateTo('welcome'),
        );
      case 'explorer_upload_cv':
        return ExplorerUploadCVScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_welcome'),
        );
      case 'explorer_cv_success':
        return ExplorerCVSuccessScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_upload_cv'),
        );
      // Pantallas para completar el flujo de carga de CV (FLUJO UPLOAD)
      case 'explorer_dashboard':
        return ExplorerProfessionScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_cv_success'),
        );
      case 'explorer_confirmation':
        return ExplorerConfirmationScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_dashboard'),
          professions: _screenData ?? ['Cocinero', 'Electricista'], // Usar las profesiones ingresadas
        );
      case 'explorer_contact':
        return ExplorerContactScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_confirmation'),
          cvData: _screenData,
        );
      case 'explorer_success':
        return ExplorerSuccessScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_contact'),
        );
      case 'explorer_final':
        return ExplorerFinalScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_success'),
        );
      case 'explorer_home':
        return ExplorerHomeScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_final'),
        );
      // Pantallas para generar CV (FLUJO GENERATE)
      case 'explorer_generate_cv':
        return ExplorerGenerateCVWelcomeScreen(
          user: _user!,
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_welcome'),
        );
      case 'explorer_generate_cv_info':
        return ExplorerGenerateCVInfoScreen(
          user: _user!,
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_generate_cv'),
        );
      case 'explorer_language':
        return ExplorerLanguageScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_generate_cv_info'),
          cvData: _screenData ?? {},
        );
      case 'explorer_education_question':
        return ExplorerEducationQuestionScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_language'),
          cvData: _screenData ?? {},
        );
      case 'explorer_education':
        return ExplorerEducationScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_education_question'),
          cvData: _screenData ?? {},
        );
      case 'explorer_personal_info_question':
        return ExplorerPersonalInfoQuestionScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_education'),
          cvData: _screenData ?? {},
        );
      case 'explorer_personal_info':
        return ExplorerPersonalInfoScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_personal_info_question'),
          cvData: _screenData ?? {},
        );
      case 'explorer_photo_question':
        return ExplorerPhotoQuestionScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_personal_info'),
          cvData: _screenData ?? {},
        );
      case 'explorer_photo':
        return ExplorerPhotoScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_photo_question'),
          cvData: _screenData ?? {},
        );
      case 'explorer_cv_summary':
        return ExplorerCVSummaryScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_photo'),
          cvData: _screenData ?? {},
        );
      // Pantallas para datos profesionales (FLUJO GENERATE)
      case 'explorer_professional_welcome':
        return ExplorerProfessionalWelcomeScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_cv_summary'),
        );
      case 'explorer_profession_input':
        return ExplorerProfessionInputScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_professional_welcome'),
          cvData: _screenData,
        );
      case 'explorer_experience_question':
        return ExplorerExperienceQuestionScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_profession_input'),
          cvData: _screenData ?? {},
        );
      case 'explorer_experience':
        return ExplorerExperienceScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_experience_question'),
          cvData: _screenData ?? {},
        );
      case 'explorer_course_question':
        return ExplorerCourseQuestionScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_experience_question'),
          cvData: _screenData ?? {},
        );
      case 'explorer_course':
        return ExplorerCourseScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_course_question'),
          cvData: _screenData ?? {},
        );
      case 'explorer_cv_photo_question':
        return ExplorerCVPhotoQuestionScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_course_question'),
          cvData: _screenData ?? {},
        );
      case 'explorer_cv_photo':
        return ExplorerCVPhotoScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_cv_photo_question'),
          cvData: _screenData ?? {},
        );
      // Pantallas para el resumen profesional y activación (FLUJO GENERATE)
      case 'explorer_professional_summary':
        return ExplorerProfessionalSummaryScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_cv_photo'),
          cvData: _screenData ?? {},
        );
      case 'explorer_cv_completed':
        return ExplorerCVCompletedScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_professional_summary'),
          cvData: _screenData ?? {},
        );
      case 'explorer_activation':
        return ExplorerActivationScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_cv_completed'),
          cvData: _screenData ?? {},
        );
      // Pantallas específicas para el flujo de UPLOAD
      case 'explorer_upload_activation':
        return ExplorerUploadActivationScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_contact'),
          cvData: _screenData ?? {},
        );
      case 'explorer_upload_success':
        return ExplorerUploadSuccessScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_upload_activation'),
          cvData: _screenData ?? {},
        );
      default:
        return OnboardingScreen(onNavigate: navigateTo);
    }
  }
}
