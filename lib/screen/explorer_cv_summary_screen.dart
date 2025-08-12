import 'package:flutter/material.dart';
import 'dart:io';

class ExplorerCVSummaryScreen extends StatefulWidget {
  final Function(String, {dynamic data}) onNavigate;
  final Function() onBack;
  final Map<String, dynamic> cvData;

  const ExplorerCVSummaryScreen({
    Key? key,
    required this.onNavigate,
    required this.onBack,
    required this.cvData,
  }) : super(key: key);

  @override
  _ExplorerCVSummaryScreenState createState() => _ExplorerCVSummaryScreenState();
}

class _ExplorerCVSummaryScreenState extends State<ExplorerCVSummaryScreen> {
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
                        '¡Ya casi sos un explorador de empleos con tu primer CV!',
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
                        'Antes de continuar, te recomendamos revisar si ingresaste tus datos correctamente:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Summary of CV data
                      _buildSummaryItem(
                        'Profesión:', 
                        widget.cvData['professions'] != null 
                            ? (widget.cvData['professions'] as List<dynamic>).join(', ') 
                            : 'No especificado',
                        onEdit: () => widget.onNavigate('explorer_profession_input', data: widget.cvData),
                      ),
                      
                      _buildSummaryItem(
                        'Experiencia laboral:', 
                        widget.cvData['experiences'] != null && (widget.cvData['experiences'] as List<dynamic>).isNotEmpty
                            ? (widget.cvData['experiences'] as List<dynamic>).first.toString()
                            : 'No especificado',
                        onEdit: () => widget.onNavigate('explorer_experience', data: widget.cvData),
                        isMultiline: true,
                      ),
                      
                      if (widget.cvData['experiences'] != null && (widget.cvData['experiences'] as List<dynamic>).length > 1)
                        _buildSummaryItem(
                          '', 
                          (widget.cvData['experiences'] as List<dynamic>)[1].toString(),
                          onEdit: () => widget.onNavigate('explorer_experience', data: widget.cvData),
                          isMultiline: true,
                        ),
                      
                      _buildSummaryItem(
                        'Idioma nativo:', 
                        widget.cvData['languages'] != null 
                            ? (widget.cvData['languages'] as List<dynamic>).join(', ') 
                            : 'No especificado',
                        onEdit: () => widget.onNavigate('explorer_language', data: widget.cvData),
                      ),
                      
                      _buildSummaryItem(
                        'Máx. nivel educativo:', 
                        widget.cvData['education'] != null 
                            ? (widget.cvData['education'] as List<dynamic>).join(', ') 
                            : 'No especificado',
                        onEdit: () => widget.onNavigate('explorer_education', data: widget.cvData),
                      ),
                      
                      _buildSummaryItem(
                        'Descripción personal:', 
                        widget.cvData['personalDescription'] ?? 'No especificado',
                        onEdit: () => widget.onNavigate('explorer_personal_info', data: widget.cvData),
                        isMultiline: true,
                      ),
                      
                      _buildSummaryItem(
                        'Características propias:', 
                        widget.cvData['personalTraits'] ?? 'No especificado',
                        onEdit: () => widget.onNavigate('explorer_personal_info', data: widget.cvData),
                      ),
                      
                      _buildSummaryItem(
                        'Foto de perfil:', 
                        widget.cvData['cvPhoto'] != null ? 'Cargada' : 'No cargada',
                        onEdit: () => widget.onNavigate('explorer_cv_photo', data: widget.cvData),
                        hasPhoto: widget.cvData['cvPhoto'] != null,
                        photoPath: widget.cvData['cvPhoto'],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Confirm button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => widget.onNavigate('explorer_professional_welcome', data: widget.cvData),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Confirmar datos personales',
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
  
  Widget _buildSummaryItem(String label, String value, {
    required Function() onEdit, 
    bool isMultiline = false,
    bool hasPhoto = false,
    String? photoPath,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          // Label
          if (label.isNotEmpty)
            SizedBox(
              width: 120,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          
          // Value
          Expanded(
            child: hasPhoto && photoPath != null
                ? ClipOval(
                    child: Image.file(
                      File(photoPath),
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  )
                : Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
          ),
          
          // Edit button
          TextButton(
            onPressed: onEdit,
            child: const Text(
              'Editar',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
