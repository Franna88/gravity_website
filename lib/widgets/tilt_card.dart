import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A widget that provides a 3D tilt effect on hover
class TiltCard extends StatefulWidget {
  final Widget child;
  final double tiltFactor;
  final double glowFactor;
  final Color glowColor;
  final Duration duration;
  final BorderRadius? borderRadius;

  const TiltCard({
    Key? key,
    required this.child,
    this.tiltFactor = 0.05,
    this.glowFactor = 0.3,
    this.glowColor = const Color(0xFFF36122),
    this.duration = const Duration(milliseconds: 300),
    this.borderRadius,
  }) : super(key: key);

  @override
  State<TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<TiltCard> {
  double _rotateX = 0;
  double _rotateY = 0;
  double _shadowX = 0;
  double _shadowY = 0;
  double _glowOpacity = 0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _glowOpacity = widget.glowFactor),
      onExit: (_) => setState(() {
        _rotateX = 0;
        _rotateY = 0;
        _shadowX = 0;
        _shadowY = 0;
        _glowOpacity = 0;
      }),
      onHover: (details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final Offset localPosition = box.globalToLocal(details.position);
        final double width = box.size.width;
        final double height = box.size.height;
        
        // Calculate tilt angles based on mouse position
        final double centerX = width / 2;
        final double centerY = height / 2;
        final double offsetX = localPosition.dx - centerX;
        final double offsetY = localPosition.dy - centerY;
        
        setState(() {
          _rotateX = (offsetY / centerY) * widget.tiltFactor;
          _rotateY = -(offsetX / centerX) * widget.tiltFactor;
          
          // Calculate shadow offset
          _shadowX = -_rotateY * 10;
          _shadowY = _rotateX * 10;
        });
      },
      child: AnimatedContainer(
        duration: widget.duration,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          boxShadow: [
            BoxShadow(
              color: widget.glowColor.withOpacity(_glowOpacity * 0.5),
              blurRadius: 30 * _glowOpacity,
              spreadRadius: 10 * _glowOpacity,
              offset: Offset(_shadowX, _shadowY),
            ),
          ],
        ),
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_rotateX)
            ..rotateY(_rotateY),
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }
}

/// A simpler parallax card that works with any device, not just on hover
class ParallaxCard extends StatelessWidget {
  final Widget child;
  final double depth;
  final double angle;
  
  const ParallaxCard({
    Key? key,
    required this.child,
    this.depth = 0.01,
    this.angle = 0.1,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final transform = Matrix4.identity()
      ..setEntry(3, 2, depth)
      ..rotateY(angle);
      
    return Transform(
      transform: transform,
      alignment: FractionalOffset.center,
      child: child,
    );
  }
}

/// A card with a 3D flip animation
class FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  final Duration duration;
  final VoidCallback? onFlip;
  
  const FlipCard({
    Key? key,
    required this.front,
    required this.back,
    this.duration = const Duration(milliseconds: 800),
    this.onFlip,
  }) : super(key: key);
  
  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _frontRotation;
  late Animation<double> _backRotation;
  bool _isFrontVisible = true;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    
    _frontRotation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: math.pi / 2)
          .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(math.pi / 2),
        weight: 50,
      ),
    ]).animate(_controller);
    
    _backRotation = TweenSequence<double>([
      TweenSequenceItem(
        tween: ConstantTween<double>(math.pi / 2),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -math.pi / 2, end: 0.0)
          .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
    ]).animate(_controller);
    
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        _isFrontVisible = !_isFrontVisible;
        if (widget.onFlip != null) {
          widget.onFlip!();
        }
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
    
    if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: SizedBox(
        child: Stack(
          children: [
            // Back card
            AnimatedBuilder(
              animation: _backRotation,
              builder: (context, child) {
                final transform = Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_backRotation.value);
                return Transform(
                  transform: transform,
                  alignment: Alignment.center,
                  child: child,
                );
              },
              child: Visibility(
                visible: !_isFrontVisible,
                child: widget.back,
              ),
            ),
            
            // Front card
            AnimatedBuilder(
              animation: _frontRotation,
              builder: (context, child) {
                final transform = Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_frontRotation.value);
                return Transform(
                  transform: transform,
                  alignment: Alignment.center,
                  child: child,
                );
              },
              child: Visibility(
                visible: _isFrontVisible,
                child: widget.front,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 