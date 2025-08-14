import 'package:buro_app/shared/action/getImage/presentation/cubit/image_cubit.dart';
import 'package:buro_app/shared/action/getImage/presentation/cubit/image_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';

class ExplorerUploadActivationScreenContent extends StatelessWidget {

  const ExplorerUploadActivationScreenContent({
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
                      onPressed: () => context.pop,
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Title
                        const Text(
                          '¡Fantástico! ¡Estamos a punto de empezar!\nAntes un breve recordatorio:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // First paragraph
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.4,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Por favor, tené en cuenta que para búsquedas más específicas, Logo funciona por medio de convocatorias, por lo que, ',
                              ),
                              TextSpan(
                                text: 'si ingresaste para buscar un empleo bajo ciertas condiciones, tenés que lanzar una convocatoria con tus especificaciones.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Second paragraph
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.4,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'De no necesitar una búsqueda específica, ',
                              ),
                              TextSpan(
                                text: 'mientras te hayas marcado como "Listo para conseguir trabajo", ya aparecés con una búsqueda activa.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Illustration container
                        BlocBuilder<ImageCubit, ImageStates>(
                            builder: (context, state) {
                              switch (state) {
                                case Success(model: String model): {
                                  return Container(
                                    width: double.infinity,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        style: BorderStyle.solid,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        imageUrl: model,
                                        fit: BoxFit.cover,
                                        cacheManager: CacheManager(
                                            Config(
                                              model,
                                              stalePeriod: const Duration(hours: 24),
                                            )
                                        ),
                                        placeholder: (context, url) =>
                                        const Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                        const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                                      ),
                                    ),
                                  );
                                }
                                default:
                                  return const SizedBox(height: 200,);
                              }
                            }
                        ),

                        const SizedBox(height: 24),

                        // Final message
                        const Text(
                          '¡Vamos a estar con vos en cada paso!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),

              // Main page button
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.goNamed('explorer_home'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Ir a mi página principal',
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

// Clase personalizada para dibujar un borde punteado
class DashedBorderPainter extends CustomPainter {
  final Color color;
  
  DashedBorderPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    
    const double dashWidth = 5;
    const double dashSpace = 5;
    
    // Dibujar línea superior
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
    
    // Dibujar línea derecha
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width, startY),
        Offset(size.width, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
    
    // Dibujar línea inferior
    startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height),
        Offset(startX + dashWidth, size.height),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
    
    // Dibujar línea izquierda
    startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
