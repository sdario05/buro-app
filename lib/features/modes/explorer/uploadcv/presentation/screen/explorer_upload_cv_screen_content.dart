import 'package:buro_app/features/modes/explorer/uploadcv/presentation/cubit/cv_cubit.dart';
import 'package:buro_app/features/modes/explorer/uploadcv/presentation/cubit/cv_states.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExplorerUploadCVScreenContent extends StatefulWidget {

  const ExplorerUploadCVScreenContent({
    Key? key,
  }) : super(key: key);

  @override
  _ExplorerUploadCVScreenContentState createState() => _ExplorerUploadCVScreenContentState();
}

class _ExplorerUploadCVScreenContentState extends State<ExplorerUploadCVScreenContent> {
  File? _selectedFile;
  bool _isUploading = false;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['doc', 'docx', 'pdf'],
    );
    if (result != null && result.files.isNotEmpty) {
      final platformFile = result.files.first;
      print('Nombre de archivo: ${platformFile.name}');
      print('Ruta de archivo: ${platformFile.path}');
      setState(() {
        _selectedFile = File(platformFile.path!);
      });
    } else {
      print('No se seleccionó ningún archivo');
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFile != null) {
      context.read<CvCubit>().sendCv(_selectedFile!);
      setState(() {
        _isUploading = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print('**********************************');
    print('Pantalla: $runtimeType');
    print('**********************************');
  }

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
                      onPressed: () => context.pop(),
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
                      onPressed: () {
                        SystemNavigator.pop();
                      },
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
                      BlocConsumer<CvCubit, CvStates>(
                        listener: (context, state) {
                          switch (state) {
                            case Success(): {
                              setState(() {
                                _isUploading = false;
                              });
                              context.goNamed('explorer_cv_success');
                            }
                          }
                        },
                        builder: (context, state) => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: // Upload button
        Padding(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedFile != null && !_isUploading ? _uploadFile : null,
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
                    : 'Subir mi CV a Logo',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
