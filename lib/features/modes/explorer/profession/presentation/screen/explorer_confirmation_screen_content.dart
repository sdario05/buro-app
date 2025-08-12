import 'package:buro_app/preferences/app_preferences.dart';
import 'package:buro_app/shared/action/getgifanimation/presentation/cubit/gif_animation_cubit.dart';
import 'package:buro_app/shared/action/getgifanimation/presentation/cubit/gif_animation_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ExplorerConfirmationScreenContent extends StatefulWidget {
  final Function(String) onNavigate;
  final Function() onBack;
  final List<String> professions; // Agregar esta línea

  const ExplorerConfirmationScreenContent({
    Key? key,
    required this.onNavigate,
    required this.onBack,
    required this.professions, // Agregar esta línea
  }) : super(key: key);

  @override
  _ExplorerConfirmationScreenContentState createState() => _ExplorerConfirmationScreenContentState();
}

class _ExplorerConfirmationScreenContentState extends State<ExplorerConfirmationScreenContent> {
  bool _notificationsEnabled = false;

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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      
                      // Title
                      Text(
                        'Acabás de mostrar tu disponibilidad como ${widget.professions.join(" y ")}, ¡Te deseamos mucha suerte!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Animation placeholder
                      BlocBuilder<GifAnimationCubit, GifAnimationStates>(
                          builder: (context, state) {
                            switch (state) {
                              case Success(gif: String gif): {
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
                                      imageUrl: gif,
                                      fit: BoxFit.cover,
                                      cacheManager: CacheManager(
                                          Config(
                                            gif,
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
                      
                      const SizedBox(height: 32),
                      
                      // Notification text
                      Text(
                        'Ahora que ya demostraste tu disponibilidad, te recomendamos que actives las notificaciones de Logo.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                          height: 1.4,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Additional text
                      Text(
                        'Al mismo tiempo, recomendamos que si querés generar una búsqueda que se adecúe a tus necesidades específicas, ¡podés lanzar una convocatoria!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                          height: 1.4,
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Notifications checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: _notificationsEnabled,
                            onChanged: (value) {
                              setState(() {
                                _notificationsEnabled = value ?? false;
                                _saveNotificationsPreference(_notificationsEnabled);
                              });
                            },
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.black;
                                }
                                return Colors.transparent;
                              },
                            ),
                          ),
                          const Text(
                            'Activar notificaciones',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '*Recomendado',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
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
                  onPressed: () => widget.onNavigate('explorer_contact'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    foregroundColor: Colors.black,
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
    );
  }

  Future<void> _saveNotificationsPreference(bool value) async {
    final prefs = AppPreferences.instance;
    await prefs.saveNotificationsPreference(value);
  }
}
