import 'package:flutter/material.dart';

class ExplorerProfessionalSummaryScreen extends StatelessWidget {
  final Function(String, {dynamic data}) onNavigate;
  final Function() onBack;
  final Map<String, dynamic> cvData;

  const ExplorerProfessionalSummaryScreen({
    Key? key,
    required this.onNavigate,
    required this.onBack,
    required this.cvData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      
                      // Title
                      const Text(
                        'Resumen de tu información profesional',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Subtitle
                      const Text(
                        'Revisa que toda la información sea correcta antes de continuar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Profesiones
                      _buildSection(
                        title: 'Profesiones',
                        content: cvData['professions'] != null
                            ? (cvData['professions'] as List<dynamic>).join(', ')
                            : 'No se han ingresado profesiones',
                      ),
                      
                      // Experiencias
                      _buildSection(
                        title: 'Experiencia laboral',
                        content: cvData['experiences'] != null && (cvData['experiences'] as List<dynamic>).isNotEmpty
                            ? _formatListItems(cvData['experiences'] as List<dynamic>)
                            : 'No se ha ingresado experiencia laboral',
                      ),
                      
                      // Cursos
                      _buildSection(
                        title: 'Cursos',
                        content: cvData['courses'] != null && (cvData['courses'] as List<dynamic>).isNotEmpty
                            ? _formatListItems(cvData['courses'] as List<dynamic>)
                            : 'No se han ingresado cursos',
                      ),
                      
                      // Información de contacto
                      _buildSection(
                        title: 'Información de contacto',
                        content: cvData['contactInfo'] != null
                            ? 'Teléfono: ${cvData['contactInfo']['phone'] ?? "No especificado"}\n'
                              'Email: ${cvData['contactInfo']['email'] ?? "No especificado"}\n'
                              'Dirección: ${cvData['contactInfo']['address'] ?? "No especificada"}'
                            : 'No se ha ingresado información de contacto',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Continue button - ESTE VA AL FLUJO GENERATE (CV COMPLETED)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => onNavigate('explorer_cv_completed', data: cvData),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Continuar',
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

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  String _formatListItems(List<dynamic> items) {
    if (items.isEmpty) return '';
    
    return items.map((item) => '• ${item.toString()}').join('\n');
  }
}
