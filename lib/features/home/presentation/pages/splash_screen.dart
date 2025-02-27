import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplasScreen extends StatelessWidget {
  const SplasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  'assets/splash/Logo_bk-SVG.png',
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const AnimatedProgressBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedProgressBar extends StatefulWidget {
  const AnimatedProgressBar({super.key});

  @override
  AnimatedProgressBarState createState() => AnimatedProgressBarState();
}

class AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
        if (_animation.value == 1) {
          Modular.to.pushReplacementNamed(
            '/Home',
          );
        }
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          ' Loading...',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFF525659), // Color del borde
              width: 2, // Ancho del borde
            ),
          ),
          height: 30,
          width: 220,
          child: SizedBox(
            height: 20,
            width: 200,
            child: LinearProgressIndicator(
              value: _animation.value,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${(_animation.value * 100).toInt()}%',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
