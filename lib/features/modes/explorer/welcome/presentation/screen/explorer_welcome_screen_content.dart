import 'package:buro_app/features/login/domain/model/user_model.dart';
import 'package:buro_app/features/modes/explorer/welcome/presentation/widget/welcome_text.dart';
import 'package:buro_app/shared/action/getImage/presentation/cubit/image_cubit.dart';
import 'package:buro_app/shared/action/getImage/presentation/cubit/image_states.dart';
import 'package:buro_app/shared/cubit/user_name_cubit.dart';
import 'package:buro_app/shared/cubit/user_name_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ExplorerWelcomeScreenContent extends StatelessWidget {
  final Function(String) onNavigate;
  final Function() onBack;

  const ExplorerWelcomeScreenContent({
    Key? key,
    required this.onNavigate,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return WillPopScope(
      onWillPop: () async {
        onBack();
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
                        const SizedBox(height: 24),

                        // Welcome message
                        BlocBuilder<UserNameCubit, UserNameStates>(
                            builder: (context, state) {
                              switch (state) {
                                case UserNameSuccess(user: UserModel? model): {
                                  return WelcomeText(name: model?.name ?? '');
                                }
                                default: return const WelcomeText();
                              }
                            }
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

                        // CV options text
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              height: 1.4,
                            ),
                            children: [
                              TextSpan(
                                text: 'Para comenzar, ¿Te gustaría ',
                              ),
                              TextSpan(
                                text: 'generar un Curriculum Vitae por medio de Logo',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: ' o preferís cargar en la aplicación un ',
                              ),
                              TextSpan(
                                text: 'curriculum que ya utilices',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '?',
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Upload CV button
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: () => onNavigate('explorer_upload_cv'),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Quiero cargar mi propio CV',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Generate CV button
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: () => onNavigate('explorer_generate_cv'),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Quiero generar un CV en Logo',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
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
