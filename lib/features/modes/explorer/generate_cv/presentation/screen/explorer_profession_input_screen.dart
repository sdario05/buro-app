import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ExplorerProfessionInputScreen extends StatefulWidget {

  const ExplorerProfessionInputScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ExplorerProfessionInputScreenState createState() => _ExplorerProfessionInputScreenState();
}

class _ExplorerProfessionInputScreenState extends State<ExplorerProfessionInputScreen> {
  final TextEditingController _professionController = TextEditingController();
  final List<String> _professions = [];
  
  bool get _canContinue => true;

  @override
  void initState() {
    super.initState();
    // Cargar profesiones existentes si las hay
    /*if (widget.cvData != null && widget.cvData!['professions'] != null) {
      _professions.addAll(List<String>.from(widget.cvData!['professions']));
    }*/
  }

  @override
  void dispose() {
    _professionController.dispose();
    super.dispose();
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
                          'Nos gustaría saber a qué te dedicas:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Profession input
                        Text(
                          'Ingresá tu profesión o rubro profesional:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Example text
                        Text(
                          'Ej: Electricista, verdulero, peluquero, etc...',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Profession input field
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey[400]!),
                          ),
                          child: TextField(
                            controller: _professionController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // List of added professions
                        ..._professions.map((profession) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  profession,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close, size: 16),
                                  onPressed: () {
                                    setState(() {
                                      _professions.remove(profession);
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

                        // Add another profession button
                        InkWell(
                          onTap: () {
                            if (_professionController.text.isNotEmpty) {
                              setState(() {
                                _professions.add(_professionController.text);
                                _professionController.clear();
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                'Quiero agregar otra profesión más',
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
      ),
    );
  }

  void _continue() {
    // Si hay texto en el campo pero no se ha agregado a la lista, agregarlo
    if (_professionController.text.isNotEmpty) {
      setState(() {
        _professions.add(_professionController.text);
      });
    }

    // Asegurar que los datos se almacenan correctamente
    //final Map<String, dynamic> updatedCvData = Map<String, dynamic>.from(widget.cvData ?? {});

    // Guardar la lista de profesiones
    //updatedCvData['professions'] = List<String>.from(_professions);

    // Navegar a la siguiente pantalla
    context.goNamed('explorer_experience_question');
  }
}
