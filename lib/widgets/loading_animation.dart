import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingAnimation extends StatelessWidget {
  final String message;
  
  const LoadingAnimation({
    Key? key,
    this.message = 'Loading...',
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
            'https://assets4.lottiefiles.com/packages/lf20_szlepvdh.json',
            width: 200,
            height: 200,
            errorBuilder: (context, error, stackTrace) {
              return SizedBox(
                width: 200,
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(
                    color: const Color(0xFFF36122),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF36122),
            ),
          ),
        ],
      ),
    );
  }
}

class GravityLoadingIndicator extends StatefulWidget {
  final double size;
  final Color color;

  const GravityLoadingIndicator({
    Key? key,
    this.size = 50.0,
    this.color = const Color(0xFFF36122),
  }) : super(key: key);

  @override
  State<GravityLoadingIndicator> createState() => _GravityLoadingIndicatorState();
}

class _GravityLoadingIndicatorState extends State<GravityLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: widget.size * 2.5,
            width: widget.size,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Shadow
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: widget.size * 0.8,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    
                    // Bouncing ball
                    Positioned(
                      bottom: Tween<double>(
                        begin: widget.size * 1.5,
                        end: 10.0,
                      ).evaluate(_animation),
                      child: Container(
                        width: widget.size,
                        height: widget.size,
                        decoration: BoxDecoration(
                          color: widget.color,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: widget.color.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'G',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: widget.size * 0.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Loading...',
            style: TextStyle(
              color: widget.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
} 