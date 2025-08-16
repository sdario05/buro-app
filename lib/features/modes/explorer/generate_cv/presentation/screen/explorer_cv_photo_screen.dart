import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ExplorerCVPhotoScreen extends StatefulWidget {

  const ExplorerCVPhotoScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ExplorerCVPhotoScreenState createState() => _ExplorerCVPhotoScreenState();
}

class _ExplorerCVPhotoScreenState extends State<ExplorerCVPhotoScreen> {
  String? _photoPath;
  final ImagePicker _picker = ImagePicker();
  
  bool get _canContinue => _photoPath != null;

  @override
  void initState() {
    super.initState();
    // Cargar foto existente si la hay
    /*if (widget.cvData['cvPhoto'] != null) {
      _photoPath = widget.cvData['cvPhoto'];
    }*/
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _photoPath = image.path;
        });
      }
    } catch (e) {
      print('Error al seleccionar imagen: $e');
    }
  }

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
                          '¡Estás a punto de ser un explorador de empleos!',
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
                        
                        // Photo label
                        const Text(
                          'Foto ingresada:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Photo upload area
                        Center(
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 1,
                                ),
                              ),
                              child: _photoPath != null
                                  ? ClipOval(
                                      child: Image.file(
                                        File(_photoPath!),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'AGREGAR UNA FOTO\nDE MI GALERÍA',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ),
                            ),
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
      ),
    );
  }

  void _continue() {
    /*// Actualizar los datos del CV
    final Map<String, dynamic> updatedCvData = {
      ...widget.cvData,
      'cvPhoto': _photoPath,
    };*/
    
    // Navegar a la pantalla de resumen profesional
    context.goNamed('explorer_professional_summary');
  }
}
