import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedParticleBackground extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final Color particleColor;
  final int numberOfParticles;
  final double particleSize;
  final Duration duration;

  const AnimatedParticleBackground({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.black,
    this.particleColor = const Color(0xFFF36122),
    this.numberOfParticles = 50,
    this.particleSize = 4.0,
    this.duration = const Duration(seconds: 10),
  }) : super(key: key);

  @override
  State<AnimatedParticleBackground> createState() => _AnimatedParticleBackgroundState();
}

class _AnimatedParticleBackgroundState extends State<AnimatedParticleBackground>
    with TickerProviderStateMixin {
  late List<ParticleModel> particles;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    particles = List.generate(
      widget.numberOfParticles,
      (index) => ParticleModel(
        id: index,
        random: random,
        particleColor: widget.particleColor,
        particleSize: widget.particleSize,
        vsync: this,
        duration: widget.duration,
      ),
    );
  }

  @override
  void dispose() {
    for (var particle in particles) {
      particle.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background
        Container(
          color: widget.backgroundColor,
        ),
        
        // Particles
        ...particles.map((particle) => AnimatedBuilder(
          animation: particle.controller,
          builder: (context, child) {
            return Positioned(
              left: particle.position.dx,
              top: particle.position.dy,
              child: Opacity(
                opacity: particle.opacity.value,
                child: Container(
                  width: particle.size,
                  height: particle.size,
                  decoration: BoxDecoration(
                    color: particle.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: particle.color.withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )),
        
        // Content
        widget.child,
      ],
    );
  }
}

class ParticleModel {
  final int id;
  final Random random;
  final Color particleColor;
  late final AnimationController controller;
  late final Animation<double> position1;
  late final Animation<double> position2;
  late final Animation<double> opacity;
  late final Color color;
  late final double size;
  late final Offset initialPosition;
  late final Offset targetPosition;
  late final Duration duration;

  ParticleModel({
    required this.id,
    required this.random,
    required this.particleColor,
    required TickerProvider vsync,
    required this.duration,
    double particleSize = 4.0,
  }) {
    // Randomize particle properties
    final hue = HSLColor.fromColor(particleColor).withHue(
      (HSLColor.fromColor(particleColor).hue + random.nextDouble() * 20 - 10) % 360,
    );
    color = hue.withLightness(
      (hue.lightness + random.nextDouble() * 0.2).clamp(0.0, 1.0),
    ).toColor();
    
    size = particleSize * (0.5 + random.nextDouble());
    
    // Animation controller
    controller = AnimationController(
      duration: Duration(
        milliseconds: duration.inMilliseconds + random.nextInt(5000),
      ),
      vsync: vsync,
    );
    
    // Randomize start position within screen
    initialPosition = Offset(
      random.nextDouble() * 500,
      random.nextDouble() * 800,
    );
    
    // Randomize target position
    targetPosition = Offset(
      random.nextDouble() * 500,
      random.nextDouble() * 800,
    );
    
    // Animations
    final curve = Curves.easeInOut;
    position1 = Tween<double>(
      begin: initialPosition.dx,
      end: targetPosition.dx,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
    
    position2 = Tween<double>(
      begin: initialPosition.dy,
      end: targetPosition.dy,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
    
    opacity = Tween<double>(
      begin: 0.0,
      end: 0.8,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );
    
    // Start animation
    controller.forward();
    
    // Loop animation
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Reset for next animation
        final newTarget = Offset(
          random.nextDouble() * 500,
          random.nextDouble() * 800,
        );
        
        position1 = Tween<double>(
          begin: targetPosition.dx,
          end: newTarget.dx,
        ).animate(CurvedAnimation(parent: controller, curve: curve));
        
        position2 = Tween<double>(
          begin: targetPosition.dy,
          end: newTarget.dy,
        ).animate(CurvedAnimation(parent: controller, curve: curve));
        
        // Save new target
        targetPosition = newTarget;
        
        // Restart animation
        controller.reset();
        controller.forward();
      }
    });
  }

  Offset get position => Offset(position1.value, position2.value);
}

// A gradient animated background
class GradientAnimatedBackground extends StatefulWidget {
  final Widget child;
  final List<Color> colors;
  final Duration duration;

  const GradientAnimatedBackground({
    Key? key,
    required this.child,
    required this.colors,
    this.duration = const Duration(seconds: 10),
  }) : super(key: key);

  @override
  State<GradientAnimatedBackground> createState() => _GradientAnimatedBackgroundState();
}

class _GradientAnimatedBackgroundState extends State<GradientAnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _alignmentAnimation1;
  late Animation<Alignment> _alignmentAnimation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _alignmentAnimation1 = Tween<Alignment>(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _alignmentAnimation2 = Tween<Alignment>(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.colors,
              begin: _alignmentAnimation1.value,
              end: _alignmentAnimation2.value,
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
} 