import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ExplorerCVCompletedScreen extends StatelessWidget {

  const ExplorerCVCompletedScreen({
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
                      children: [
                        const SizedBox(height: 20),
                        
                        // Title
                        const Text(
                          '¡Ya completaste tu primer Curriculum Vitae (CV)!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Subtitle
                        const Text(
                          'Si bien lo vas a tener dentro de la app, ¡podés descargarlo o compartirlo con quien quieras!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: Colors.black87,
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // CV Preview Container
                        Container(
                          width: double.infinity,
                          height: 280,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey[400]!,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'CV',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w200,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Download and Share buttons
                        Row(
                          children: [
                            // Download Button
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  // Download functionality would go here
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Descargando CV...'))
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                                child: const Text('Descargar CV'),
                              ),
                            ),
                            
                            // Share Button
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  // Share functionality would go here
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Compartiendo CV...'))
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                                child: const Text('Compartir CV'),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Activate button
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.goNamed('explorer_activation'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Activarme como Explorador de empleos',
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
}
