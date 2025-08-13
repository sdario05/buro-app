import 'package:buro_app/shared/action/getImage/presentation/cubit/image_cubit.dart';
import 'package:buro_app/shared/action/getImage/presentation/cubit/image_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ExplorerExplanationScreenContent extends StatelessWidget {
  final Function(String) onNavigate;
  final Function() onBack;

  const ExplorerExplanationScreenContent({
    Key? key,
    required this.onNavigate,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenSize.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with logo and back button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              'Logo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: onBack,
                          icon: const Icon(Icons.arrow_back, size: 14),
                          label: const Text('Volver'),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(44, 36),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 16 : 24),

                    // Mode title and description
                    Text(
                      'Ingresaste como Explorador',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 22 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Al ingresar en este modo tu visualidad va a estar destinada a explorar diversos empleos disponibles',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 16 : 24),

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

                    SizedBox(height: isSmallScreen ? 16 : 24),

                    // First time user message
                    Text(
                      'Vemos que es tu primera vez en Buro, te recomendamos recibir la explicación sobre el app para poder aprovechar su potencial',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '¿Te gustaría recibir una explicación?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const Spacer(),

                    // Action buttons
                    Padding(
                      padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => onNavigate('explorer_explanation_detail'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: const Text('Sí, quiero recibir la explicación'),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => onNavigate('explorer_welcome'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: const Text('No, prefiero ingresar directo'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
