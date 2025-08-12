import 'package:flutter/material.dart';
import '../utils/app_styles.dart';

class RegistrationPopup extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onExplorerSelected;
  final VoidCallback onGeneratorSelected;

  const RegistrationPopup({
    Key? key,
    required this.onClose,
    required this.onExplorerSelected,
    required this.onGeneratorSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.5),
        child: Stack(
          children: [
            // Contenido principal
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF666666),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Título
                    const Text(
                      'Hola! Vemos que querés empezar a interactuar en Logo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Descripción
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(text: 'Para hacerlo, '),
                          TextSpan(
                            text: 'necesitamos que te registres',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' como Explorador de empleos (si estás en una búsqueda activa de empleo), Generador de empleos (si estás ofreciendo empleo) ¡o ambos!',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Botón de Explorador
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onExplorerSelected,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text(
                          'Quiero ser Explorador de empleos',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Botón de Generador
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onGeneratorSelected,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text(
                          'Quiero ser Generador de empleos',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Botón de cerrar
            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: onClose,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
