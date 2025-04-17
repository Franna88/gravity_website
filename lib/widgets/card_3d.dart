import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';

class Card3D extends StatefulWidget {
  final Widget frontContent;
  final Widget backContent;
  final double depth;
  final Duration duration;
  final Color shadowColor;
  final BorderRadius borderRadius;
  final double height;
  final double width;

  const Card3D({
    Key? key,
    required this.frontContent,
    required this.backContent,
    this.depth = 10,
    this.duration = const Duration(milliseconds: 800),
    this.shadowColor = const Color(0xFFF36122),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.height = 250,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  State<Card3D> createState() => _Card3DState();
}

class _Card3DState extends State<Card3D> with SingleTickerProviderStateMixin {
  bool _showFront = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.addListener(() {
      if (_controller.value >= 0.5 && _showFront) {
        setState(() {
          _showFront = false;
        });
      } else if (_controller.value <= 0.5 && !_showFront) {
        setState(() {
          _showFront = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCard() {
    if (_controller.isAnimating) return;
    
    if (_controller.value == 0) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * math.pi;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle);
          
          return Container(
            height: widget.height,
            width: widget.width,
            child: Transform(
              transform: transform,
              alignment: Alignment.center,
              child: _showFront
                  ? _buildCardSide(widget.frontContent, widget.shadowColor)
                  : Transform(
                      transform: Matrix4.identity()..rotateY(math.pi),
                      alignment: Alignment.center,
                      child: _buildCardSide(widget.backContent, widget.shadowColor),
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardSide(Widget content, Color shadowColor) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, widget.depth),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: content,
    );
  }
}

class ActivityCard3D extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Color color;
  final IconData icon;
  final VoidCallback? onTap;

  const ActivityCard3D({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.color,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card3D(
      height: 350,
      shadowColor: color,
      frontContent: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with gradient overlay
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Icon(
                  icon,
                  color: color,
                  size: 36,
                ).animate(onPlay: (controller) => controller.repeat())
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.2, 1.2),
                    duration: 1500.ms,
                  )
                  .then()
                  .scale(
                    begin: const Offset(1.2, 1.2),
                    end: const Offset(1, 1),
                    duration: 1500.ms,
                  ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 50,
                  height: 3,
                  color: color,
                ),
                const SizedBox(height: 20),
                Text(
                  'Tap to learn more',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backContent: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: 50,
              height: 3,
              color: color,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  description,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('BOOK NOW'),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 