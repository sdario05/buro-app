import 'package:buro_app/di/injection.dart';
import 'package:buro_app/features/modes/explorer/explanation/presentation/screen/explorer_explanation_screen.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/screen/explorer_profession_screen.dart';
import 'package:buro_app/features/modes/explorer/uploadcv/presentation/screen/explorer_cv_success_screen.dart';
import 'package:buro_app/preferences/app_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screen/onboarding_screen.dart';
import 'features/login/presentation/screen/login_screen.dart';
import 'screen/register_screen.dart';
import 'features/welcome/presentation/screen/welcome_screen.dart';
import 'screen/mode_explanation_screen.dart';
import 'screen/already_registered_screen.dart';
import 'screen/home_screen.dart';
import 'screen/job_detail_screen.dart';
import 'features/modes/explorer/welcome/presentation/screen/explorer_welcome_screen.dart';
import 'features/modes/explorer/uploadcv/presentation/screen/explorer_upload_cv_screen.dart';
import 'features/modes/explorer/profession/presentation/screen/explorer_confirmation_screen.dart';
import 'features/modes/explorer/contact/presentation/screen/explorer_contact_screen.dart';
import 'screen/explorer_success_screen.dart';
import 'screen/explorer_final_screen.dart';
import 'features/modes/explorer/home/presentation/screen/explorer_home_screen.dart';
import 'screen/explorer_generate_cv_welcome_screen.dart';
import 'screen/explorer_generate_cv_info_screen.dart';
import 'screen/explorer_language_screen.dart';
import 'screen/explorer_education_question_screen.dart';
import 'screen/explorer_education_screen.dart';
import 'screen/explorer_personal_info_question_screen.dart';
import 'screen/explorer_personal_info_screen.dart';
import 'screen/explorer_photo_question_screen.dart';
import 'screen/explorer_photo_screen.dart';
import 'screen/explorer_cv_summary_screen.dart';
import 'screen/explorer_professional_welcome_screen.dart';
import 'screen/explorer_profession_input_screen.dart';
import 'screen/explorer_experience_question_screen.dart';
import 'screen/explorer_experience_screen.dart';
import 'screen/explorer_course_question_screen.dart';
import 'screen/explorer_course_screen.dart';
import 'screen/explorer_cv_photo_question_screen.dart';
import 'screen/explorer_cv_photo_screen.dart';
import 'screen/explorer_professional_summary_screen.dart';
import 'screen/explorer_cv_completed_screen.dart';
import 'screen/explorer_activation_screen.dart';
import 'models/user.dart';
import 'features/modes/explorer/reminder/presentation/screen/explorer_upload_activation_screen.dart';
import 'features/modes/explorer/completed/presentation/screen/explorer_upload_success_screen.dart';

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
        printScreenName('OnboardingScreen');
        return OnboardingScreen(onNavigate: navigateTo);
      case 'login':
        printScreenName('LoginScreen');
        return LoginScreen(onNavigate: navigateTo);
      case 'register':
        printScreenName('RegisterScreen');
        return RegisterScreen(onNavigate: navigateTo);
      case 'welcome':
        printScreenName('WelcomeScreen');
        return WelcomeScreen(
          onLogout: handleLogout,
          onModeSelect: handleModeSelection,
        );
      case 'modeExplanation':
        printScreenName('ModeExplanationScreen');
        return ModeExplanationScreen(
          mode: _selectedMode ?? 'visitante',
          onNavigate: navigateTo,
          onBack: () => navigateTo('welcome'),
        );
      case 'alreadyRegistered':
        printScreenName('AlreadyRegisteredScreen');
        return AlreadyRegisteredScreen(onNavigate: navigateTo);
      case 'home':
        printScreenName('HomeScreen');
        return HomeScreen(
          mode: _selectedMode ?? 'visitante',
          onModeChange: handleModeChange,
        );
      // Pantallas para el explorador
      case 'explorer_explanation':
        printScreenName('ExplorerExplanationScreen');
        return ExplorerExplanationScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('welcome'),
        );
      case 'explorer_welcome':
        printScreenName('ExplorerWelcomeScreen');
        return ExplorerWelcomeScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('welcome'),
        );
      case 'explorer_upload_cv':
        printScreenName('ExplorerUploadCVScreen');
        return ExplorerUploadCVScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_welcome'),
        );
      case 'explorer_cv_success':
        printScreenName('ExplorerCVSuccessScreen');
        return ExplorerCvSuccessScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_upload_cv'),
        );
      // Pantallas para completar el flujo de carga de CV (FLUJO UPLOAD)
      case 'explorer_dashboard':
        printScreenName('ExplorerProfessionScreen');
        return ExplorerProfessionScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_cv_success'),
        );
      case 'explorer_confirmation':
        printScreenName('ExplorerConfirmationScreen');
        return ExplorerConfirmationScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_dashboard'),
          professions: _screenData ?? ['Cocinero', 'Electricista'], // Usar las profesiones ingresadas
        );
      case 'explorer_contact':
        printScreenName('ExplorerContactScreen');
        return ExplorerContactScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_confirmation'),
        );
      case 'explorer_success':
        printScreenName('ExplorerSuccessScreen');
        return ExplorerSuccessScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_contact'),
        );
      case 'explorer_final':
        printScreenName('ExplorerFinalScreen');
        return ExplorerFinalScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_success'),
        );
      case 'explorer_home':
        printScreenName('ExplorerHomeScreen');
        return ExplorerHomeScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_final'),
        );
      // Pantallas para generar CV (FLUJO GENERATE)
      case 'explorer_generate_cv':
        printScreenName('ExplorerGenerateCVWelcomeScreen');
        return ExplorerGenerateCVWelcomeScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_welcome'),
        );
      case 'explorer_generate_cv_info':
        printScreenName('ExplorerGenerateCVInfoScreen');
        return ExplorerGenerateCVInfoScreen(
          user: _user!,
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_generate_cv'),
        );
      case 'explorer_language':
        printScreenName('ExplorerLanguageScreen');
        return ExplorerLanguageScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_generate_cv_info'),
          cvData: _screenData ?? {},
        );
      case 'explorer_education_question':
        printScreenName('ExplorerEducationQuestionScreen');
        return ExplorerEducationQuestionScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_language'),
          cvData: _screenData ?? {},
        );
      case 'explorer_education':
        printScreenName('ExplorerEducationScreen');
        return ExplorerEducationScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_education_question'),
          cvData: _screenData ?? {},
        );
      case 'explorer_personal_info_question':
        printScreenName('ExplorerPersonalInfoQuestionScreen');
        return ExplorerPersonalInfoQuestionScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_education'),
          cvData: _screenData ?? {},
        );
      case 'explorer_personal_info':
        printScreenName('ExplorerPersonalInfoScreen');
        return ExplorerPersonalInfoScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_personal_info_question'),
          cvData: _screenData ?? {},
        );
      case 'explorer_photo_question':
        printScreenName('ExplorerPhotoQuestionScreen');
        return ExplorerPhotoQuestionScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_personal_info'),
          cvData: _screenData ?? {},
        );
      case 'explorer_photo':
        printScreenName('ExplorerPhotoScreen');
        return ExplorerPhotoScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_photo_question'),
          cvData: _screenData ?? {},
        );
      case 'explorer_cv_summary':
        printScreenName('ExplorerCVSummaryScreen');
        return ExplorerCVSummaryScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_photo'),
          cvData: _screenData ?? {},
        );
      // Pantallas para datos profesionales (FLUJO GENERATE)
      case 'explorer_professional_welcome':
        printScreenName('ExplorerProfessionalWelcomeScreen');
        return ExplorerProfessionalWelcomeScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_cv_summary'),
        );
      case 'explorer_profession_input':
        printScreenName('ExplorerProfessionInputScreen');
        return ExplorerProfessionInputScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_professional_welcome'),
          cvData: _screenData,
        );
      case 'explorer_experience_question':
        printScreenName('ExplorerExperienceQuestionScreen');
        return ExplorerExperienceQuestionScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_profession_input'),
          cvData: _screenData ?? {},
        );
      case 'explorer_experience':
        printScreenName('ExplorerExperienceScreen');
        return ExplorerExperienceScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_experience_question'),
          cvData: _screenData ?? {},
        );
      case 'explorer_course_question':
        printScreenName('ExplorerCourseQuestionScreen');
        return ExplorerCourseQuestionScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_experience_question'),
          cvData: _screenData ?? {},
        );
      case 'explorer_course':
        printScreenName('ExplorerCourseScreen');
        return ExplorerCourseScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_course_question'),
          cvData: _screenData ?? {},
        );
      case 'explorer_cv_photo_question':
        printScreenName('ExplorerCVPhotoQuestionScreen');
        return ExplorerCVPhotoQuestionScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_course_question'),
          cvData: _screenData ?? {},
        );
      case 'explorer_cv_photo':
        printScreenName('ExplorerCVPhotoScreen');
        return ExplorerCVPhotoScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_cv_photo_question'),
          cvData: _screenData ?? {},
        );
      // Pantallas para el resumen profesional y activación (FLUJO GENERATE)
      case 'explorer_professional_summary':
        printScreenName('ExplorerProfessionalSummaryScreen');
        return ExplorerProfessionalSummaryScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_cv_photo'),
          cvData: _screenData ?? {},
        );
      case 'explorer_cv_completed':
        printScreenName('ExplorerCVCompletedScreen');
        return ExplorerCVCompletedScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_professional_summary'),
          cvData: _screenData ?? {},
        );
      case 'explorer_activation':
        printScreenName('ExplorerActivationScreen');
        return ExplorerActivationScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_cv_completed'),
          cvData: _screenData ?? {},
        );
      // Pantallas específicas para el flujo de UPLOAD
      case 'explorer_upload_activation':
        printScreenName('ExplorerUploadActivationScreen');
        return ExplorerUploadActivationScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_upload_success'),
        );
      case 'explorer_upload_success':
        printScreenName('ExplorerUploadSuccessScreen');
        return ExplorerUploadSuccessScreen(
          onNavigate: navigateTo,
          onBack: () => navigateTo('explorer_contact'),
        );
      default:
        printScreenName('OnboardingScreen');
        return OnboardingScreen(onNavigate: navigateTo);
    }
  }

  void printScreenName(String screenName) {
    if (kDebugMode) {
      print('******************************** Screen: $screenName ********************************');
    }
  }
}
