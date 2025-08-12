import 'package:flutter/material.dart';

class ExplorerExperienceScreen extends StatefulWidget {
  final Function(String, {dynamic data}) onNavigate;
  final Function() onBack;
  final Map<String, dynamic> cvData;

  const ExplorerExperienceScreen({
    Key? key,
    required this.onNavigate,
    required this.onBack,
    required this.cvData,
  }) : super(key: key);

  @override
  _ExplorerExperienceScreenState createState() => _ExplorerExperienceScreenState();
}

class _ExplorerExperienceScreenState extends State<ExplorerExperienceScreen> {
  final TextEditingController _experienceController = TextEditingController();
  final List<String> _experiences = [];
  
  bool get _canContinue => true;

  @override
  void initState() {
    super.initState();
    // Cargar experiencias existentes si las hay
    if (widget.cvData['experiences'] != null) {
      _experiences.addAll(List<String>.from(widget.cvData['experiences']));
    }
  }

  @override
  void dispose() {
    _experienceController.dispose();
    super.dispose();
  }

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
                    onPressed: widget.onBack,
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
                    onPressed: widget.onBack,
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
                        '¡Estás en camino a ser un explorador de empleos!',
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
                        'En relación a la pregunta anterior...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Experience input
                      Text(
                        'Ingresá tu experiencia laboral:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 4),
                      
                      // Example text
                      Text(
                        'Te recomendamos sumar: Empresa, cargo, duración, años y una breve descripción de tus tareas realizadas.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Experience input field
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey[400]!),
                        ),
                        child: TextField(
                          controller: _experienceController,
                          maxLines: 5,
                          maxLength: 150,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            border: InputBorder.none,
                            counterText: '',
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Máximo: 150 palabras',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // List of added experiences
                      ..._experiences.map((experience) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  experience,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, size: 16),
                                onPressed: () {
                                  setState(() {
                                    _experiences.remove(experience);
                                  });
                                },
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        ),
                      )).toList(),
                      
                      const SizedBox(height: 16),
                      
                      // Add another experience button
                      InkWell(
                        onTap: () {
                          if (_experienceController.text.isNotEmpty) {
                            setState(() {
                              _experiences.add(_experienceController.text);
                              _experienceController.clear();
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              'Agregar otra experiencia laboral',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.grey[800],
                            ),
                          ],
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
                  onPressed: _canContinue ? () => _continue() : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    foregroundColor: Colors.black,
                    disabledBackgroundColor: Colors.grey[300],
                    disabledForegroundColor: Colors.grey[500],
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

  void _continue() {
  // Si hay texto en el campo pero no se ha agregado a la lista, agregarlo
  if (_experienceController.text.isNotEmpty) {
    setState(() {
      _experiences.add(_experienceController.text);
    });
  }
  
  // Asegurar que los datos se almacenan correctamente
  final Map<String, dynamic> updatedCvData = Map<String, dynamic>.from(widget.cvData);
  
  // Guardar la lista de experiencias
  updatedCvData['experiences'] = List<String>.from(_experiences);
  
  // Navegar a la siguiente pantalla
  widget.onNavigate('explorer_course_question', data: updatedCvData);
}
}
