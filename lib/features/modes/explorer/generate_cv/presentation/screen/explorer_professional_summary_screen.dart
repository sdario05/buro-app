import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ExplorerProfessionalSummaryScreen extends StatelessWidget {

  const ExplorerProfessionalSummaryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop();
        return false;
      },
      child: Scaffold(
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
                      onPressed: context.pop,
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
                      onPressed: SystemNavigator.pop,
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
                          content: 'profesiones',
                        ),
                        
                        // Experiencias
                        _buildSection(
                          title: 'Experiencia laboral',
                          content: 'experiencia',
                        ),
                        
                        // Cursos
                        _buildSection(
                          title: 'Cursos',
                          content: 'curso',
                        ),
                        
                        // Información de contacto
                        _buildSection(
                          title: 'Información de contacto',
                          content: 'contacto',
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
                    onPressed: () => context.goNamed('explorer_cv_completed'),
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
