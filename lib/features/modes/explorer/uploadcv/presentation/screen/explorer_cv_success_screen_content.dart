import 'package:buro_app/shared/action/getImage/presentation/cubit/image_cubit.dart';
import 'package:buro_app/shared/action/getImage/presentation/cubit/image_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ExplorerCVSuccessScreenContent extends StatelessWidget {
  final Function(String) onNavigate;
  final Function() onBack;

  const ExplorerCVSuccessScreenContent({
    Key? key,
    required this.onNavigate,
    required this.onBack,
  }) : super(key: key);

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
                    onPressed: onBack,
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
                    onPressed: onBack,
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
                          '¡Estupendo!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Subtitle
                        const Text(
                          '¡Ya pudimos asociar tu CV a tu perfil de Logo!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Animation placeholder
                        BlocBuilder<ImageCubit, ImageStates>(
                            builder: (context, state) {
                              switch (state) {
                                case Success(model: String model): {
                                  return Container(
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
                        
                        const SizedBox(height: 40),
                        
                        // Next steps text
                        Text(
                          'A continuación, te pedimos que completes tan solo dos pasos más para poder comenzar a disfrutar Logo.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    
                    // Start button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: () => onNavigate('explorer_dashboard'),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Comenzar',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
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
