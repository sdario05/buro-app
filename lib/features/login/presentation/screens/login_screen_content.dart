import 'package:buro_app/features/login/presentation/widgets/login_button.dart';
import 'package:buro_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenContent extends StatefulWidget {
  final Function(String) onNavigate;

  const LoginScreenContent({
    Key? key,
    required this.onNavigate,
  }) : super(key: key);

  @override
  _LoginScreenContentState createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<LoginScreenContent> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginSuccess() {
    widget.onNavigate('welcome');
  }

  void _onLoginError(String msg) {
    setState(() {
        _errorMessage = msg.replaceAll('Exception: ', '');
      });
  }

  Future<void> _onLoginLoading() async {
    setState(() {
        _errorMessage = null;
    });
  }

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
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => widget.onNavigate('onboarding'),
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(),
                              iconSize: 22,
                              splashRadius: 24,
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () => widget.onNavigate('onboarding'),
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(),
                              iconSize: 22,
                              splashRadius: 24,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 16 : 24),

                    // Title and subtitle
                    Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 22 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Introduce tus datos para acceder',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 16 : 24),

                    // Error message
                    if (_errorMessage != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: Colors.red[800],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    if (_errorMessage != null) const SizedBox(height: 16),

                    // Email field
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico',
                        hintText: 'Ingresa tu correo electrónico',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        _onLoginLoading();
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password field with eye icon
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        hintText: 'Ingresa tu contraseña',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showPassword ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                        ),
                      ),
                      obscureText: !_showPassword,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) {
                        context.read<LoginCubit>().login(_emailController.text, _passwordController.text);
                      },
                      onChanged: (value) {
                        _onLoginLoading();
                      },
                    ),
                    const SizedBox(height: 16),

                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(44, 44),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        child: const Text('¿Olvidaste tu contraseña?'),
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    LoginButton(
                      userName: _emailController.text,
                      password: _passwordController.text,
                      onSuccess: () {
                        _onLoginSuccess();
                      },
                      onError: (msg) {
                        _onLoginError(msg);
                      },
                      onLoading: () {
                        _onLoginLoading();
                      }
                    ),
                    const SizedBox(height: 16),

                    // Register link
                    Center(
                      child: TextButton(
                        onPressed: () => widget.onNavigate('register'),
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          minimumSize: const Size(44, 44),
                        ),
                        child: const Text('Regístrate'),
                      ),
                    ),

                    const Spacer(),
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
