import 'package:flutter/material.dart';
import 'dart:io';
import '../../../../../../utils/app_styles.dart';

class ExplorerUploadCVScreen extends StatefulWidget {
  final Function(String) onNavigate;
  final Function() onBack;

  const ExplorerUploadCVScreen({
    Key? key,
    required this.onNavigate,
    required this.onBack,
  }) : super(key: key);

  @override
  _ExplorerUploadCVScreenState createState() => _ExplorerUploadCVScreenState();
}

class _ExplorerUploadCVScreenState extends State<ExplorerUploadCVScreen> {
  File? _selectedFile;
  bool _isUploading = false;

  Future<void> _pickFile() async {
    // Simulamos la selección de un archivo
    setState(() {
      _isUploading = true;
    });

    // Simulamos un retraso para la carga
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isUploading = false;
      _selectedFile = File('dummy_path.pdf'); // Archivo simulado
    });
  }

  Future<void> _uploadFile() async {
    if (_selectedFile == null) {
      // Si no hay archivo seleccionado, abrimos el selector
      await _pickFile();
      return;
    }

    // Si ya hay un archivo seleccionado, procedemos con la carga
    setState(() {
      _isUploading = true;
    });

    // Simulamos un retraso para la carga
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isUploading = false;
    });

    // Navegamos a la pantalla de éxito
    widget.onNavigate('explorer_cv_success');
  }

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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 24),
                        
                        // Title
                        const Text(
                          '¡Ya podés subir tu Curriculum Vitae (CV)!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Subtitle
                        Text(
                          'Tené en cuenta que si necesitás actualizarlo en algún momento, podés resubirlo o realizar uno por medio de Logo.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            height: 1.4,
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Upload area
                        GestureDetector(
                          onTap: _pickFile,
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade400,
                                style: BorderStyle.solid,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_isUploading)
                                  const CircularProgressIndicator()
                                else if (_selectedFile != null)
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.description,
                                        size: 48,
                                        color: Colors.grey[600],
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'CV seleccionado',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        _selectedFile!.path.split('/').last,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.upload_file,
                                        size: 48,
                                        color: Colors.grey[600],
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'SUBIR MI CV',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Upload button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isUploading ? null : _uploadFile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            disabledBackgroundColor: Colors.grey,
                          ),
                          child: Text(
                            _isUploading 
                                ? 'Subiendo...' 
                                : (_selectedFile == null 
                                    ? 'Subir mi CV a Logo' 
                                    : 'Continuar'),
                            style: const TextStyle(
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
          ],
        ),
      ),
    );
  }
}
