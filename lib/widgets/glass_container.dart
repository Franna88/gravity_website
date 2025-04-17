import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Border? border;
  final Color color;
  final List<BoxShadow>? boxShadow;
  final double? width;
  final double? height;
  final Gradient? gradient;

  const GlassContainer({
    Key? key,
    required this.child,
    this.blur = 5,
    this.opacity = 0.2,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    this.margin = EdgeInsets.zero,
    this.border,
    this.color = Colors.white,
    this.boxShadow,
    this.width,
    this.height,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blur,
            sigmaY: blur,
          ),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color.withOpacity(opacity),
              borderRadius: borderRadius,
              border: border,
              gradient: gradient,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class AnimatedGlassContainer extends StatefulWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Border? border;
  final Color color;
  final List<BoxShadow>? boxShadow;
  final double? width;
  final double? height;
  final bool animate;
  final Duration duration;
  final Gradient? gradient;

  const AnimatedGlassContainer({
    Key? key,
    required this.child,
    this.blur = 5,
    this.opacity = 0.2,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    this.margin = EdgeInsets.zero,
    this.border,
    this.color = Colors.white,
    this.boxShadow,
    this.width,
    this.height,
    this.animate = true,
    this.duration = const Duration(milliseconds: 500),
    this.gradient,
  }) : super(key: key);

  @override
  State<AnimatedGlassContainer> createState() => _AnimatedGlassContainerState();
}

class _AnimatedGlassContainerState extends State<AnimatedGlassContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _blurAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _blurAnimation = Tween<double>(
      begin: 0.0,
      end: widget.blur,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: widget.opacity,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
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
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.width,
            height: widget.height,
            margin: widget.margin,
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              boxShadow: widget.boxShadow,
            ),
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: _blurAnimation.value,
                  sigmaY: _blurAnimation.value,
                ),
                child: Container(
                  padding: widget.padding,
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(_opacityAnimation.value),
                    borderRadius: widget.borderRadius,
                    border: widget.border,
                    gradient: widget.gradient,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
} 