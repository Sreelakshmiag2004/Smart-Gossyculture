import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7FC16A), Color(0xFF4ED9E7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TODO: Replace with your actual logo asset if available
              Icon(
                Icons.ac_unit, // Placeholder for logo
                size: 64,
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              const Text(
                'BollBot',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Enhancing Cotton\nFarming with AI.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}