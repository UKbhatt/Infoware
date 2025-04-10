import 'package:flutter/material.dart';
import 'dart:async';

import 'package:form/Api+Bloc/homescreen.dart';

class Charachtersplash extends StatefulWidget {
  const Charachtersplash({Key? key}) : super(key: key);

  @override
  State<Charachtersplash> createState() => _CharachtersplashState();
}

class _CharachtersplashState extends State<Charachtersplash> {
  late Timer _timer;
  int _gradientIndex = 0;
  final List<List<Color>> gradients = [
    [Colors.green.shade900, Colors.teal.shade700],
    [Colors.teal.shade700, Colors.green.shade700],
    [Colors.green.shade800, Colors.lightGreen.shade600],
  ];

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const CharacterScreen()),
      );
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _gradientIndex = (_gradientIndex + 1) % gradients.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradients[_gradientIndex],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                ),
                child: const Center(
                  child: Icon(
                    Icons.science_sharp,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Rick & Morty',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
