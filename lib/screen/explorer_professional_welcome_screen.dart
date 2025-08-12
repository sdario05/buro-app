import 'package:flutter/material.dart';

class ExplorerProfessionalWelcomeScreen extends StatelessWidget {
  final Function(String) onNavigate;
  final Function() onBack;

  const ExplorerProfessionalWelcomeScreen({
    Key? key,
    required this.onNavigate,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE), // Fondo gris claro
      body: SafeArea(
        child: Column(
          children: [
            // Header with logo and navigation buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: onBack,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  
                  // Logo
                  const Text(
                    'Logo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  // Close button
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: onBack,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            
            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      
                      // Title
                      const Text(
                        '¡Terminamos con tus datos personales!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Animation placeholder
                      Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade400,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'ANIMACIÓN\nFESTEJO\n(ESTÉTICA E.D.E)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Description text
                      Text(
                        'Ya completaste todos tus datos personales, pero ahora te vamos a pedir, que ingreses información más específica para sumar a tu primer Curriculum Vitae (CV).',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                          height: 1.4,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Additional text
                      Text(
                        'Al mismo tiempo, recordá que una vez ingresado vas a poder crear distintos CVs para distintas búsquedas de empleo.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                          height: 1.4,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Final text
                      Text(
                        'Por lo que te recomendamos que ingreses los datos relevantes que te sirvan para la búsqueda específica por la cual te gustaría empezar.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Continue button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => onNavigate('explorer_profession_input'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Comenzar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
