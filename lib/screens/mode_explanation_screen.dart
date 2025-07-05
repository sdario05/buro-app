import 'package:flutter/material.dart';

class ModeExplanationScreen extends StatelessWidget {
  final String mode;
  final Function(String) onNavigate;
  final Function() onBack;

  const ModeExplanationScreen({
    Key? key,
    required this.mode,
    required this.onNavigate,
    required this.onBack,
  }) : super(key: key);

  Map<String, String> getModeInfo() {
    switch (mode) {
      case 'visitante':
        return {
          'title': 'Visitante',
          'description': 'Podes hechar un vistazo a las distintas propuestas tanto de generadores como de exploradores de empleo',
        };
      case 'generador':
        return {
          'title': 'Generador',
          'description': 'Al ingresarte en este modo tu visualidad va a estar destinada a explorar empleados disponibles',
        };
      case 'explorador':
        return {
          'title': 'Explorador',
          'description': 'Al ingresarte en este modo tu visualidad va a estar destinada a explorar diversos empleos disponibles',
        };
      default:
        return {
          'title': 'Modo desconocido',
          'description': 'Por favor, selecciona un modo válido.',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final modeInfo = getModeInfo();
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenSize.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with logo and back button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              'Logo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: onBack,
                          icon: const Icon(Icons.arrow_back, size: 14),
                          label: const Text('Volver'),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(44, 36),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 16 : 24),

                    // Mode title and description
                    Text(
                      'Ingresaste como ${modeInfo['title']}',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 22 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      modeInfo['description']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 16 : 24),

                    // Animation placeholder
                    Center(
                      child: Container(
                        height: isSmallScreen ? 150 : 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Animación para ${modeInfo['title']}',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 16 : 24),

                    // First time user message
                    Text(
                      'Vemos que es tu primera vez en Buro, te recomendamos recibir la explicación sobre el app para poder aprovechar su potencial',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '¿Te gustaría recibir una explicación?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const Spacer(),

                    // Action buttons
                    Padding(
                      padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => onNavigate('welcome'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: const Text('Sí, quiero recibir la explicación'),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => onNavigate('home'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: const Text('No, prefiero ingresar directo'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
