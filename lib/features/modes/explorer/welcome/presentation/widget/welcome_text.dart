import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {

  final String? name;

  const WelcomeText({
    super.key,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1.3,
        ),
        children: [
          TextSpan(
            text: 'Bienvenido ${name ?? ''},\n',
          ),
          const TextSpan(
            text: '¡Nos alegra que quieras ser un ',
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
          const TextSpan(
            text: 'explorador de empleos',
          ),
          const TextSpan(
            text: '!',
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}