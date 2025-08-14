import 'package:buro_app/features/login/domain/model/user_model.dart';
import 'package:buro_app/features/welcome/domain/model/carousel_model.dart';
import 'package:buro_app/features/welcome/presentation/cubit/carousel_cubit.dart';
import 'package:buro_app/features/welcome/presentation/cubit/carousel_states.dart';
import 'package:buro_app/preferences/app_preferences.dart';
import 'package:buro_app/shared/cubit/user_name_cubit.dart';
import 'package:buro_app/shared/cubit/user_name_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'package:go_router/go_router.dart';

class WelcomeScreenContent extends StatefulWidget {

  const WelcomeScreenContent({
    Key? key,
  }) : super(key: key);

  @override
  _WelcomeScreenContentState createState() => _WelcomeScreenContentState();
}

class _WelcomeScreenContentState extends State<WelcomeScreenContent> {
  int _currentSlide = 0;
  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoSlide(int length) {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentSlide < length - 1) {
        _currentSlide++;
      } else {
        _currentSlide = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentSlide,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with logo and logout button
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
                    onPressed: () {
                      _handleLogout();
                    },
                    icon: Icon(Icons.logout, size: 14),
                    label: Text('Salir'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Welcome message
              BlocBuilder<UserNameCubit, UserNameStates>(
                  builder: (context, state) {
                    switch (state) {
                      case UserNameSuccess(user: UserModel? model): {
                        return Text(
                            'Bienvenido ${model?.name}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                        );
                      }
                      default: return const Text('Bienvenido');
                    }
                  }
              ),
              const SizedBox(height: 8),
              Text(
                '¿Con qué modo quieres ingresar hoy?',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),

              // Carousel for illustrations
              BlocConsumer<CarouselCubit, CarouselStates>(
                listener: (context, state) {
                  switch (state) {
                    case CarouselSuccess(model: List<CarouselModel> list): {
                      _startAutoSlide(list.length);
                    }
                  }
                },
                  builder: (context, state) {
                    switch (state) {
                      case CarouselSuccess(model: List<CarouselModel> list): {
                        return Column(
                          children: [
                            Container(
                              height: 200,
                              child: PageView.builder(
                                controller: _pageController,
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentSlide = index;
                                  });
                                },
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.network(
                                      list[index].imageUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return const Center(child: CircularProgressIndicator());
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Center(child: Icon(Icons.broken_image, color: Colors.grey));
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),

                            // Carousel indicators
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  list.length,
                                      (index) => Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentSlide == index ? Colors.black : Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Description text
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  Text(
                                    list[_currentSlide].title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    list[_currentSlide].description,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      default:
                        return const SizedBox(height: 200,);
                    }
                  }
              ),

              Spacer(),

              // Mode selection buttons
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.goNamed('modeExplanation');
                    },
                    child: Text('Visitante'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context.goNamed('modeExplanation');
                    },
                    child: Text('Generador de empleos'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context.goNamed('explorer_explanation');
                    },
                    child: Text('Explorador de empleos'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogout() {
    Future.delayed(const Duration(milliseconds: 100), () async {
      final prefs = AppPreferences.instance;
      await prefs.clearUser();
      context.goNamed('onboarding');
    });
  }
}
