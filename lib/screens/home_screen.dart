import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math' as math;
import 'package:lottie/lottie.dart';

import '../widgets/page_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  double _parallaxOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final heroContext = _heroKey.currentContext;
    if (heroContext != null) {
      final heroBox = heroContext.findRenderObject() as RenderBox;
      final heroHeight = heroBox.size.height;
      final offset = _scrollController.offset;
      if (offset <= heroHeight) {
        setState(() {
          _parallaxOffset = offset * 0.4;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);

    return PageLayout(
      currentPath: '/',
      scrollController: _scrollController,
      child: Column(
        children: [
          _buildHeroSection(isMobile),
          _buildActivitiesSection(isMobile),
          _buildPartySection(isMobile),
          _buildTestimonialsSection(isMobile),
          _buildBookJumpSection(isMobile),
        ],
      ),
    );
  }

  Widget _buildHeroSection(bool isMobile) {
    return Container(
      key: _heroKey,
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      color: Colors.black,
      child: Stack(
        children: [
          // Parallax background
          Positioned.fill(
            child: Transform.translate(
              offset: Offset(0, -_parallaxOffset),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
                child: Image.asset(
                  'images/Kid-Jump.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          // Animated dots
          _buildHeroAnimatedDots(),
          
          // Animation Overlay
          
          // Main Content
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 48,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFF36122),
                      ),
                      child: _buildAnimatedHeadline(isMobile),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Gravity Indoor Trampoline Park in Port Elizabeth \nhas over 2000m² of pure adventure waiting for you!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 18 : 24,
                      height: 1.4,
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 400.ms)
                  .moveY(begin: 30, duration: 500.ms),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => context.go('/booking'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF36122),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 30.0 : 50.0,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'BOOK NOW',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(duration: 1200.ms, delay: 700.ms)
                      .then()
                      .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05))
                      .then()
                      .scale(begin: const Offset(1.05, 1.05), end: const Offset(1, 1)),
                      if (!isMobile) ...[
                        const SizedBox(width: 20),
                        OutlinedButton(
                          onPressed: () => context.go('/activities'),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'DISCOVER MORE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 600.ms)
                        .moveX(begin: 30, end: 0, duration: 600.ms),
                      ]
                    ],
                  ),
                  if (isMobile) ...[
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () => context.go('/activities'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'DISCOVER MORE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 600.ms)
                    .moveX(begin: 30, end: 0, duration: 600.ms),
                  ],
                ],
              ),
            ),
          ),
          
          // Scroll indicator
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Scroll to explore',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 28,
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .moveY(begin: 0, end: 10, duration: 800.ms)
                  .then()
                  .moveY(begin: 10, end: 0, duration: 800.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods to create animated particles
  Widget _buildHeroAnimatedDots() {
    return Positioned.fill(
      child: Stack(
        children: _generateAnimatedDots(
          count: 30, 
          height: MediaQuery.of(context).size.height * 0.9,
          colors: [
            Colors.orange.withOpacity(0.3),
            Colors.white.withOpacity(0.2),
            const Color(0xFF87C540).withOpacity(0.3),
          ],
          isCircle: true
        ),
      ),
    );
  }

  List<Widget> _generateAnimatedDots({
    required int count,
    required double height,
    required List<Color> colors,
    bool isCircle = true,
  }) {
    final random = math.Random();
    final dots = <Widget>[];
    
    for (int i = 0; i < count; i++) {
      final size = random.nextDouble() * 6 + 2;
      final x = random.nextDouble() * MediaQuery.of(context).size.width;
      final y = random.nextDouble() * height;
      final color = colors[random.nextInt(colors.length)];
      
      dots.add(
        Positioned(
          left: x,
          top: y,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: isCircle ? null : BorderRadius.circular(2),
            ),
          ).animate(onPlay: (controller) => controller.repeat())
            .scale(
              begin: const Offset(0.5, 0.5),
              end: const Offset(1.5, 1.5),
              duration: Duration(milliseconds: 1000 + random.nextInt(2000)),
            )
            .then()
            .scale(
              begin: const Offset(1.5, 1.5),
              end: const Offset(0.5, 0.5),
              duration: Duration(milliseconds: 1000 + random.nextInt(2000)),
            ),
        ),
      );
    }
    
    return dots;
  }

  Widget _buildActivitiesSection(bool isMobile) {
    final activities = [
      {
        'title': 'Open Jump',
        'icon': Icons.adjust,
        'color': const Color(0xFFF36122),
      },
      {
        'title': 'Foam Pit',
        'icon': Icons.waves,
        'color': const Color(0xFF87C540),
      },
      {
        'title': 'Basketball',
        'icon': Icons.sports_basketball,
        'color': Colors.deepOrange,
      },
      {
        'title': 'Ninja Course',
        'icon': Icons.fitness_center,
        'color': Colors.purple,
      },
      {
        'title': 'Devil Slide',
        'icon': Icons.height,
        'color': Colors.red,
      },
      {
        'title': 'Rope Course',
        'icon': Icons.cable,
        'color': Colors.blue,
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            'EXPLORE OUR ACTIVITIES',
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          )
          .animate()
          .fadeIn(duration: 600.ms)
          .moveY(begin: 30, end: 0),
          const SizedBox(height: 20),
          const Text(
            'From trampolines to ninja courses, we have it all!',
            style: TextStyle(
              color: Color(0xFFF36122),
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          )
          .animate()
          .fadeIn(delay: 200.ms, duration: 600.ms),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              if (isMobile) {
                // Mobile layout: vertical list with smaller cards
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: _buildActivityCard(
                        activities[index]['title'].toString(),
                        activities[index]['icon'] as IconData,
                        activities[index]['color'] as Color,
                        index,
                      ),
                    );
                  },
                );
              } else {
                // Desktop layout: grid arrangement
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                  ),
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    return _buildActivityCard(
                      activities[index]['title'].toString(),
                      activities[index]['icon'] as IconData,
                      activities[index]['color'] as Color,
                      index,
                    );
                  },
                );
              }
            },
          ),
          const SizedBox(height: 50),
          OutlinedButton.icon(
            onPressed: () => context.go('/activities'),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('VIEW ALL ACTIVITIES'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFF36122),
              side: const BorderSide(color: Color(0xFFF36122)),
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
            ),
          )
          .animate()
          .fadeIn(delay: 600.ms)
          .moveY(begin: 20, end: 0),
        ],
      ),
    );
  }

  Widget _buildActivityCard(String title, IconData icon, Color color, int index) {
    return InkWell(
      onTap: () => context.go('/activities'),
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: MouseRegion(
        onEnter: (_) {
          // Could trigger animations here with a state change
        },
        onExit: (_) {
          // Could reset animations here with a state change
        },
        child: Card(
          elevation: 8,
          shadowColor: color.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  color.withOpacity(0.1),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Experience the thrill',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 100 * index))
        .moveY(begin: 30, end: 0, delay: Duration(milliseconds: 100 * index), duration: 500.ms)
        .then()
        .shimmer(delay: 200.ms, duration: 1800.ms),
      ),
    );
  }

  Widget _buildBookJumpSection(bool isMobile) {
    return Container(
      height: 500,
      width: double.infinity,
      color: Colors.black,
      child: Stack(
        children: [
          // Background with parallax effect
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7),
                BlendMode.srcOver,
              ),
              child: Image.asset(
                'images/Kid-Slide.jpg',
                fit: BoxFit.cover,
                alignment: Alignment(0, -0.3 - _parallaxOffset * 0.0005),
              ),
            ),
          ),
          
          // Simple animated dots for rectangle particles
          Positioned.fill(
            child: Stack(
              children: _generateAnimatedDots(
                count: 20, 
                height: 500,
                colors: [
                  const Color(0xFFF36122).withOpacity(0.2),
                  const Color(0xFF87C540).withOpacity(0.2),
                  Colors.white.withOpacity(0.1),
                ],
                isCircle: false
              ),
            ),
          ),
          
          // Content
          Positioned.fill(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(40),
                margin: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.4),
                  border: Border.all(
                    color: const Color(0xFFF36122).withOpacity(0.5),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF36122).withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'READY TO JUMP IN?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .moveY(begin: -30, end: 0),
                    const SizedBox(height: 20),
                    Container(
                      width: 100,
                      height: 3,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF36122), Color(0xFF87C540)],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 300.ms)
                    .scale(
                      begin: const Offset(0, 1),
                      end: const Offset(1, 1),
                      alignment: Alignment.centerLeft,
                      duration: 600.ms,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Experience the thrill of defying gravity today!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 16 : 20,
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 600.ms)
                    .moveY(begin: 20, end: 0),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () => context.go('/booking'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF36122),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 30.0 : 50.0,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 15,
                        shadowColor: const Color(0xFFF36122).withOpacity(0.5),
                      ),
                      child: const Text(
                        'BOOK NOW',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.05, 1.05),
                      duration: 1500.ms,
                    )
                    .then()
                    .shimmer(duration: 1800.ms),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 1000.ms),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartySection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      color: const Color(0xFFF8F8F8),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Background circles animation
              Container(
                width: isMobile ? 300 : 500,
                height: isMobile ? 300 : 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF87C540).withOpacity(0.1),
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.1, 1.1),
                duration: 3000.ms,
              )
              .then()
              .scale(
                begin: const Offset(1.1, 1.1),
                end: const Offset(1, 1),
                duration: 3000.ms,
              ),
              
              Container(
                width: isMobile ? 200 : 350,
                height: isMobile ? 200 : 350,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF36122).withOpacity(0.1),
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.2, 1.2),
                duration: 4000.ms,
              )
              .then()
              .scale(
                begin: const Offset(1.2, 1.2),
                end: const Offset(1, 1),
                duration: 4000.ms,
              ),
              
              // Content with 3D-like effect
              Row(
                children: [
                  if (!isMobile)
                    Expanded(
                      flex: 5,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(-0.1),
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'images/family.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .moveX(begin: -50, end: 0, duration: 800.ms),
                    ),
                  if (!isMobile) const SizedBox(width: 50),
                  Expanded(
                    flex: isMobile ? 12 : 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PARTIES & EVENTS',
                          style: TextStyle(
                            color: Color(0xFFF36122),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .moveY(begin: 20, end: 0),
                        const SizedBox(height: 15),
                        Text(
                          'Host Your Ultimate Party',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: isMobile ? 24 : 32,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 100.ms, duration: 400.ms)
                        .moveY(begin: 20, end: 0),
                        const SizedBox(height: 20),
                        const Text(
                          'Our three air-conditioned private party rooms can accommodate up to 50 people per room, making us the perfect venue for birthday parties, team building events, school outings, and more!',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            height: 1.6,
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 400.ms)
                        .moveY(begin: 20, end: 0),
                        const SizedBox(height: 30),
                        if (isMobile)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'images/family.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 300.ms, duration: 800.ms)
                          .shimmer(delay: 800.ms, duration: 1800.ms),
                        if (isMobile)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFeatureItem('Private Rooms')
                                .animate()
                                .fadeIn(delay: 400.ms)
                                .moveX(begin: -20, end: 0),
                              const SizedBox(height: 10),
                              _buildFeatureItem('Catering Options')
                                .animate()
                                .fadeIn(delay: 500.ms)
                                .moveX(begin: -20, end: 0),
                              const SizedBox(height: 10),
                              _buildFeatureItem('Dedicated Host')
                                .animate()
                                .fadeIn(delay: 600.ms)
                                .moveX(begin: -20, end: 0),
                              const SizedBox(height: 10),
                              _buildFeatureItem('All Ages Welcome')
                                .animate()
                                .fadeIn(delay: 700.ms)
                                .moveX(begin: -20, end: 0),
                            ],
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildFeatureItem('Private Rooms')
                                      .animate()
                                      .fadeIn(delay: 300.ms)
                                      .moveX(begin: -20, end: 0),
                                  ),
                                  const SizedBox(width: 30),
                                  Expanded(
                                    child: _buildFeatureItem('Catering Options')
                                      .animate()
                                      .fadeIn(delay: 400.ms)
                                      .moveX(begin: -20, end: 0),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildFeatureItem('Dedicated Host')
                                      .animate()
                                      .fadeIn(delay: 500.ms)
                                      .moveX(begin: -20, end: 0),
                                  ),
                                  const SizedBox(width: 30),
                                  Expanded(
                                    child: _buildFeatureItem('All Ages Welcome')
                                      .animate()
                                      .fadeIn(delay: 600.ms)
                                      .moveX(begin: -20, end: 0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () => context.go('/parties'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF36122),
                            foregroundColor: Colors.white,
                            elevation: 8,
                            shadowColor: const Color(0xFFF36122).withOpacity(0.5),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'BOOK A PARTY',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 700.ms)
                        .shimmer(delay: 1200.ms, duration: 1800.ms),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Color(0xFF87C540)),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }

  Widget _buildTestimonialsSection(bool isMobile) {
    final testimonials = [
      {
        'quote': "Our son's birthday party was amazing! The staff was helpful and everything was well-organized.",
        'name': 'Sarah T.',
        'title': 'Parent',
        'image': 'images/testimonial1.jpg',
      },
      {
        'quote': 'The escape rooms are challenging and so much fun! Great team building activity for our office.',
        'name': 'Michael K.',
        'title': 'Business Manager',
        'image': 'images/testimonial2.jpg',
      },
      {
        'quote': 'My kids absolutely love the play parks! They can bounce around for hours and always leave happy.',
        'name': 'Jessica R.',
        'title': 'Parent',
        'image': 'images/testimonial3.jpg',
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'WHAT OUR CUSTOMERS SAY',
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          )
          .animate()
          .fadeIn(duration: 600.ms)
          .moveY(begin: 20, end: 0),
          const SizedBox(height: 20),
          Container(
            width: 100,
            height: 5,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF36122), Color(0xFF87C540)],
              ),
              borderRadius: BorderRadius.circular(3),
            ),
          )
          .animate()
          .fadeIn(delay: 200.ms)
          .scale(begin: const Offset(0, 1), end: const Offset(1, 1), alignment: Alignment.centerLeft),
          const SizedBox(height: 50),

          // Use Lottie animation as decoration
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 40,
                    color: const Color(0xFFF36122),
                  ),
                  Icon(
                    Icons.star,
                    size: 40,
                    color: const Color(0xFFF36122),
                  ),
                  Icon(
                    Icons.star,
                    size: 40,
                    color: const Color(0xFFF36122),
                  ),
                  Icon(
                    Icons.star,
                    size: 40,
                    color: const Color(0xFFF36122),
                  ),
                  Icon(
                    Icons.star,
                    size: 40,
                    color: const Color(0xFFF36122),
                  ),
                ],
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.1, 1.1),
                duration: 1500.ms, 
              ),
            ),
          ),

          // Testimonial cards
          Container(
            height: 350,
            child: isMobile 
              ? _buildTestimonialSlider(testimonials)
              : Row(
                  children: [
                    for (int i = 0; i < testimonials.length; i++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: _buildTestimonialCard(
                            testimonials[i]['quote'] as String,
                            testimonials[i]['name'] as String,
                            testimonials[i]['title'] as String,
                            i,
                          ),
                        ),
                      ),
                  ],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialSlider(List<Map<String, dynamic>> testimonials) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: testimonials.length,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.8,
          margin: const EdgeInsets.only(right: 20),
          child: _buildTestimonialCard(
            testimonials[index]['quote'] as String,
            testimonials[index]['name'] as String,
            testimonials[index]['title'] as String,
            index,
          ),
        );
      },
    );
  }

  Widget _buildTestimonialCard(String quote, String name, String title, int index) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.grey.shade50,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.format_quote,
                  color: const Color(0xFFF36122),
                  size: 40,
                )
                .animate(onPlay: (controller) => controller.repeat())
                .fadeOut(delay: 2000.ms, duration: 2000.ms)
                .then()
                .fadeIn(delay: 2000.ms, duration: 2000.ms),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Text(
                quote,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF87C540),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      name[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    )
    .animate()
    .fadeIn(delay: Duration(milliseconds: 300 * index))
    .moveY(begin: 50, end: 0, delay: Duration(milliseconds: 300 * index), duration: 500.ms)
    .then()
    .shimmer(delay: 500.ms, duration: 1800.ms);
  }

  Widget _buildAnimatedHeadline(bool isMobile) {
    return AnimatedTextKit(
      animatedTexts: [
        FadeAnimatedText(
          'THE ULTIMATE PLAYGROUND',
          textStyle: TextStyle(
            fontSize: isMobile ? 24 : 48,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF36122),
          ),
          duration: const Duration(milliseconds: 3000),
          fadeOutBegin: 0.8,
          fadeInEnd: 0.2,
        ),
        FadeAnimatedText(
          'JUMP, FLIP & FLY',
          textStyle: TextStyle(
            fontSize: isMobile ? 24 : 48,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF36122),
          ),
          duration: const Duration(milliseconds: 3000),
          fadeOutBegin: 0.8,
          fadeInEnd: 0.2,
        ),
        FadeAnimatedText(
          'DEFY GRAVITY',
          textStyle: TextStyle(
            fontSize: isMobile ? 24 : 48,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF36122),
          ),
          duration: const Duration(milliseconds: 3000),
          fadeOutBegin: 0.8,
          fadeInEnd: 0.2,
        ),
      ],
      repeatForever: true,
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
    );
  }
}

