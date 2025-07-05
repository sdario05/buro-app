import 'package:flutter/material.dart';
import 'dart:async';

class OnboardingScreen extends StatefulWidget {
  final Function(String) onNavigate;

  const OnboardingScreen({Key? key, required this.onNavigate}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentSlide = 0;
  late PageController _pageController;
  Timer? _timer;

  final List<Map<String, String>> _slides = [
    {
      'title': '¿Qué es Logo?',
      'description': 'Somos una app destinada a conectar Generadores y Exploradores de empleos, centrada en oficios y todo tipo de trabajos.',
    },
    {
      'title': 'Una aplicación, dos tipos de usuarios.',
      'description': 'Ingresá como "Explorador de empleos" (futuro empleado), "Generador de empleos" (futuro empleador) o ambos.',
    },
    {
      'title': 'Cargá o creá tu CV y generá tu QR',
      'description': 'Aprovechá los beneficios que te ofrece Logo. Como "Explorador" te ayudamos a armar tu CV y como "Generador" un QR con tu convocatoria.',
    },
    {
      'title': 'Una cuenta, distintas convocatorias',
      'description': 'En Logo, seas Explorador, Generador o ambos, podés crear distintas convocatorias para distintos rubros dentro de una misma cuenta. ¡Podés crear un CV o QR para cada una!',
    },
    {
      'title': 'Conexión y comunicación',
      'description': 'Nuestro principal objetivo es poder ayudarlos a encontrarse, luego de eso, los invitamos a seguir adelante con su selección por fuera de Logo.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentSlide < _slides.length - 1) {
        _currentSlide++;
      } else {
        _currentSlide = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentSlide,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Logo
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'Logo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Carousel for animations
            Container(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentSlide = index;
                  });
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Animación ${index + 1}',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Carousel indicators
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentSlide == index ? Colors.black : Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ),

            // Description text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    _slides[_currentSlide]['title']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _slides[_currentSlide]['description']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),

            // Action buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => widget.onNavigate('login'),
                    child: Text('Iniciar sesión'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => widget.onNavigate('register'),
                    child: Text('Registrarme'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
