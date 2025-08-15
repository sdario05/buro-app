import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:go_router/go_router.dart';

class ExplorerCVSummaryScreen extends StatefulWidget {

  const ExplorerCVSummaryScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ExplorerCVSummaryScreenState createState() => _ExplorerCVSummaryScreenState();
}

class _ExplorerCVSummaryScreenState extends State<ExplorerCVSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop();
        return false;
      },
      child: Scaffold(
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
                          'Profesión:', 'Profesion',
                          onEdit: () => widget.onNavigate('explorer_profession_input', data: widget.cvData),
                        ),

                        _buildSummaryItem(
                          'Experiencia laboral:', 'experiencia',
                          onEdit: () => widget.onNavigate('explorer_experience', data: widget.cvData),
                          isMultiline: true,
                        ),


                          _buildSummaryItem(
                            '',
                            'experiencia',
                            onEdit: () => widget.onNavigate('explorer_experience', data: widget.cvData),
                            isMultiline: true,
                          ),

                        _buildSummaryItem(
                          'Idioma nativo:', 'idioma',
                          onEdit: () => widget.onNavigate('explorer_language', data: widget.cvData),
                        ),

                        _buildSummaryItem(
                          'Máx. nivel educativo:', 'educacion',
                          onEdit: () => widget.onNavigate('explorer_education', data: widget.cvData),
                        ),

                        _buildSummaryItem(
                          'Descripción personal:', 'descripcion',
                          onEdit: () => widget.onNavigate('explorer_personal_info', data: widget.cvData),
                          isMultiline: true,
                        ),

                        _buildSummaryItem(
                          'Características propias:', 'caracteristica',
                          onEdit: () => widget.onNavigate('explorer_personal_info', data: widget.cvData),
                        ),

                        _buildSummaryItem(
                          'Foto de perfil:', 'foto',
                          onEdit: () => widget.onNavigate('explorer_cv_photo', data: widget.cvData),
                          hasPhoto: true,
                          photoPath: 'ruta foto',
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
                    onPressed: () => context.goNamed('explorer_professional_welcome'),
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
