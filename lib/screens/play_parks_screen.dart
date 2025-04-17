import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:math' as math;

import '../widgets/page_layout.dart';

class PlayParksScreen extends StatefulWidget {
  const PlayParksScreen({super.key});

  @override
  State<PlayParksScreen> createState() => _PlayParksScreenState();
}

class _PlayParksScreenState extends State<PlayParksScreen> {
  final ScrollController _scrollController = ScrollController();
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    
    return PageLayout(
      currentPath: '/play-parks',
      scrollController: _scrollController,
      child: Column(
        children: [
          _buildHeroSection(isMobile),
          _buildIntroSection(isMobile),
          _buildLocationSection(isMobile, 'Baywest Play Park', true),
          _buildLocationSection(isMobile, 'Walmer Park Play Park', false),
          _buildFeaturesSection(isMobile),
          _buildCallToActionSection(isMobile),
        ],
      ),
    );
  }

  Widget _buildHeroSection(bool isMobile) {
    return Container(
      height: isMobile ? 300 : 400,
      width: double.infinity,
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.srcOver,
              ),
              child: Opacity(
                opacity: 0.7,
                child: Image.asset(
                  'images/foam.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          // Animated particles
          _buildPlayfulParticles(),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PLAY PARKS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: const Color(0xFFF36122).withOpacity(0.7),
                        offset: const Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 500.ms)
                .shimmer(delay: 500.ms, duration: 1800.ms),
                const SizedBox(height: 20),
                Container(
                  width: isMobile ? 80 : 100,
                  height: 5,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF36122), Color(0xFF87C540)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
                .animate()
                .fadeIn(duration: 500.ms, delay: 200.ms)
                .scale(
                  begin: const Offset(0, 1),
                  end: const Offset(1, 1),
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: const Color(0xFFF36122), width: 2),
                  ),
                  child: Text(
                    'Fun for Kids of All Ages',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 16 : 18,
                    ),
                  ),
                )
                .animate()
                .fadeIn(duration: 500.ms, delay: 400.ms)
                .slideY(begin: 0.3, end: 0)
                .animate(onPlay: (controller) => controller.repeat(reverse: true))
                .shimmer(delay: 800.ms, duration: 1800.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayfulParticles() {
    return Stack(
      children: List.generate(30, (index) {
        final random = math.Random();
        final size = random.nextDouble() * 12 + 8;
        final x = random.nextDouble() * MediaQuery.of(context).size.width;
        final y = random.nextDouble() * (ResponsiveBreakpoints.of(context).smallerThan(TABLET) ? 300 : 400);
        final isBall = random.nextBool();
        
        return Positioned(
          left: x,
          top: y,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: [
                const Color(0xFFF36122),
                const Color(0xFF87C540),
                Colors.yellow,
                Colors.pink,
                Colors.blue,
                Colors.purple,
              ][random.nextInt(6)].withOpacity(0.7),
              shape: isBall ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: !isBall ? BorderRadius.circular(size / 4) : null,
            ),
          )
          .animate(onPlay: (controller) => controller.repeat())
          .scale(
            begin: const Offset(0.1, 0.1),
            end: const Offset(1.2, 1.2),
            duration: Duration(milliseconds: 500 + random.nextInt(1000)),
          )
          .then()
          .rotate(
            begin: 0,
            end: random.nextDouble() * 2 * math.pi,
            duration: Duration(milliseconds: 500 + random.nextInt(1000)),
          )
          .then()
          .move(
            begin: const Offset(0, 0),
            end: Offset(random.nextDouble() * 100 - 50, 100 + random.nextDouble() * 100),
            duration: Duration(milliseconds: 1000 + random.nextInt(2000)),
            curve: Curves.easeOutQuad,
          )
          .then()
          .fadeOut(duration: 500.ms),
        );
      }),
    );
  }

  Widget _buildIntroSection(bool isMobile) {
    return VisibilityDetector(
      key: const Key('intro-section'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.2) {
          setState(() {});
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 80,
          vertical: 80,
        ),
        child: Column(
          children: [
            Text(
              'GRAVITY PLAY PARKS',
              style: TextStyle(
                color: Colors.black,
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms)
            .moveY(begin: 30, end: 0),
            const SizedBox(height: 20),
            const Text(
              'Perfect for children of all ages, our Play Parks offer a safe, supervised environment where kids can have fun and parents can relax.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFF36122),
              ),
            )
            .animate()
            .fadeIn(delay: 200.ms, duration: 800.ms),
            const SizedBox(height: 50),
            LayoutBuilder(
              builder: (context, constraints) {
                if (isMobile) {
                  return Column(
                    children: [
                      _buildIntroFeature(
                        'Safe Environment',
                        'Our play parks are designed with safety as the top priority, with soft surfaces and rounded edges throughout.',
                        Icons.security,
                        0,
                      ),
                      const SizedBox(height: 30),
                      _buildIntroFeature(
                        'Multiple Locations',
                        'With locations at both Baywest Mall and Walmer Park Shopping Centre, we\'re always nearby.',
                        Icons.location_on,
                        1,
                      ),
                      const SizedBox(height: 30),
                      _buildIntroFeature(
                        'Affordable Fun',
                        'Great value entertainment for children of all ages, with party packages available.',
                        Icons.attach_money,
                        2,
                      ),
                    ],
                  );
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildIntroFeature(
                          'Safe Environment',
                          'Our play parks are designed with safety as the top priority, with soft surfaces and rounded edges throughout.',
                          Icons.security,
                          0,
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: _buildIntroFeature(
                          'Multiple Locations',
                          'With locations at both Baywest Mall and Walmer Park Shopping Centre, we\'re always nearby.',
                          Icons.location_on,
                          1,
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: _buildIntroFeature(
                          'Affordable Fun',
                          'Great value entertainment for children of all ages, with party packages available.',
                          Icons.attach_money,
                          2,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroFeature(String title, String description, IconData icon, int index) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFF36122).withOpacity(0.1),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(
            icon,
            color: const Color(0xFFF36122),
            size: 40,
          ),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 300 * index))
        .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1))
        .shimmer(delay: Duration(milliseconds: 300 * index + 500), duration: 1800.ms),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 300 * index + 200)),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.5,
            color: Colors.grey[600],
          ),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 300 * index + 400))
        .slideY(begin: 0.2, end: 0, delay: Duration(milliseconds: 300 * index + 400)),
      ],
    );
  }

  Widget _buildLocationCard(String title, int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: StatefulBuilder(
        builder: (context, setState) {
          bool isHovered = false;
          
          return MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: isHovered ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(),
              child: Card(
                elevation: isHovered ? 12 : 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.orange.withOpacity(0.3),
                  highlightColor: Colors.orange.withOpacity(0.1),
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(index == 0 ? 'images/baywest.jpg' : 'images/walmer-hero.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(isHovered ? 0.5 : 0.6),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          transform: isHovered ? (Matrix4.identity()..scale(1.1)) : Matrix4.identity(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isHovered 
                              ? const Color(0xFF87C540) 
                              : const Color(0xFFF36122),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: isHovered 
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFFF36122).withOpacity(0.5),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  )
                                ] 
                              : [],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'VIEW DETAILS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: isHovered ? 10 : 0,
                              ),
                              AnimatedOpacity(
                                opacity: isHovered ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 300),
                                child: const Icon(
                                  Icons.arrow_forward, 
                                  color: Colors.white, 
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    )
    .animate()
    .fadeIn(delay: Duration(milliseconds: 300 * index))
    .slideX(begin: index == 0 ? -0.3 : 0.3, end: 0, duration: 800.ms);
  }

  Widget _buildLocationSection(bool isMobile, String title, bool isFirst) {
    return VisibilityDetector(
      key: Key('location-section-${title.replaceAll(" ", "-")}'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.2) {
          setState(() {});
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 80,
          vertical: 50,
        ),
        color: isFirst ? Colors.white : const Color(0xFFF8F8F8),
        child: Column(
          children: [
            Text(
              title.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms)
            .moveY(begin: 30, end: 0),
            const SizedBox(height: 10),
            const Text(
              'Fun & Adventure for Kids',
              style: TextStyle(
                color: Color(0xFFF36122),
                fontSize: 18,
              ),
            )
            .animate()
            .fadeIn(delay: 200.ms)
            .moveY(begin: 20, end: 0),
            const SizedBox(height: 40),
            isMobile
                ? Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          title.contains('Baywest') ? 'images/baywest.jpg' : 'images/walmer.jpg',
                          fit: BoxFit.cover,
                          height: 300,
                          width: double.infinity,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 300.ms)
                      .slideY(begin: 0.3, end: 0),
                      const SizedBox(height: 30),
                      _buildLocationInfo(title),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            title.contains('Baywest') ? 'images/baywest.jpg' : 'images/walmer.jpg',
                            fit: BoxFit.cover,
                            height: 400,
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 300.ms)
                        .slideX(begin: isFirst ? -0.3 : 0.3, end: 0),
                      ),
                      const SizedBox(width: 50),
                      Expanded(
                        flex: 7,
                        child: _buildLocationInfo(title),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationInfo(String title) {
    final features = title == 'Baywest Play Park'
        ? [
            'Multi-level play structure',
            'Soft play areas for toddlers',
            'Ball pits and slides',
            'Birthday party packages',
            'Café with refreshments',
          ]
        : [
            'Interactive play zones',
            'Climbing wall for kids',
            'Dedicated toddler area',
            'Party rooms available',
            'Parent seating area',
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About This Location',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms)
        .slideX(begin: 0.3, end: 0),
        const SizedBox(height: 15),
        Text(
          title == 'Baywest Play Park'
              ? 'Our flagship play park located in Baywest Mall offers a spacious and modern play environment for children of all ages. The facility includes multiple play zones designed to encourage physical activity, imagination, and social interaction.'
              : 'The Walmer Park Shopping Centre location provides a convenient and fun play option for families. This play park features innovative play equipment in a compact but well-designed space that children love to explore.',
          style: const TextStyle(
            height: 1.6,
            fontSize: 16,
          ),
        )
        .animate()
        .fadeIn(delay: 500.ms)
        .slideX(begin: 0.3, end: 0),
        const SizedBox(height: 30),
        const Text(
          'Features',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )
        .animate()
        .fadeIn(delay: 600.ms)
        .slideX(begin: 0.3, end: 0),
        const SizedBox(height: 15),
        ...features.asMap().entries.map((entry) {
          final index = entry.key;
          final feature = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Color(0xFF87C540),
                )
                .animate(delay: Duration(milliseconds: 700 + (index * 100)))
                .scale(
                  begin: const Offset(0, 0),
                  end: const Offset(1, 1),
                  duration: 500.ms,
                  curve: Curves.elasticOut,
                ),
                const SizedBox(width: 10),
                Text(
                  feature,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 30),
        ResponsiveBreakpoints.of(context).smallerThan(TABLET)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Opening Hours',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Monday - Sunday: 9:00 AM - 6:00 PM',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              )
              .animate()
              .fadeIn(delay: 800.ms)
              .slideX(begin: 0.3, end: 0),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title == 'Baywest Play Park' ? '+27 41 000 0001' : '+27 41 000 0002',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              )
              .animate()
              .fadeIn(delay: 900.ms)
              .slideX(begin: 0.3, end: 0),
            ],
          )
        : Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Opening Hours',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Monday - Sunday: 9:00 AM - 6:00 PM',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            )
            .animate()
            .fadeIn(delay: 800.ms)
            .slideX(begin: 0.3, end: 0),
            const SizedBox(width: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Contact',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title == 'Baywest Play Park' ? '+27 41 000 0001' : '+27 41 000 0002',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            )
            .animate()
            .fadeIn(delay: 900.ms)
            .slideX(begin: 0.3, end: 0),
          ],
        ),
        const SizedBox(height: 30),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: StatefulBuilder(
            builder: (context, setState) {
              bool isHovered = false;
              
              return MouseRegion(
                onEnter: (_) => setState(() => isHovered = true),
                onExit: (_) => setState(() => isHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: isHovered ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(),
                  child: ElevatedButton.icon(
                    onPressed: () => context.go('/book-jump'),
                    icon: Icon(Icons.play_arrow),
                    label: Text(
                      'BOOK A JUMP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isHovered ? const Color(0xFF87C540) : const Color(0xFFF36122),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      elevation: isHovered ? 8 : 4,
                      shadowColor: isHovered 
                        ? const Color(0xFFF36122).withOpacity(0.6) 
                        : const Color(0xFFF36122).withOpacity(0.3),
                    ),
                  ),
                ),
              );
            },
          ),
        )
        .animate()
        .fadeIn(delay: 1000.ms)
        .slideY(begin: 0.5, end: 0),
      ],
    );
  }

  Widget _buildFeaturesSection(bool isMobile) {
    final features = [
      {
        'title': 'Ball Pits',
        'description': 'Dive into our colorful ball pits for safe and fun play.',
        'icon': Icons.circle,
      },
      {
        'title': 'Slides',
        'description': 'Multiple slides of different heights and speeds.',
        'icon': Icons.slideshow,
      },
      {
        'title': 'Climbing Structures',
        'description': 'Fun climbing structures to develop balance and coordination.',
        'icon': Icons.terrain,
      },
      {
        'title': 'Soft Play Areas',
        'description': 'Specially designed soft play areas for toddlers.',
        'icon': Icons.child_care,
      },
      {
        'title': 'Party Rooms',
        'description': 'Private party rooms available for birthdays and special events.',
        'icon': Icons.cake,
      },
      {
        'title': 'Café Seating',
        'description': 'Comfortable seating area for parents with café service.',
        'icon': Icons.local_cafe,
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      color: Colors.grey[100],
      child: Column(
        children: [
          Text(
            'PLAY PARK FEATURES',
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          )
          .animate()
          .fadeIn(duration: 800.ms)
          .moveY(begin: 30, end: 0),
          const SizedBox(height: 20),
          const Text(
            'Everything You Need for a Fun Day Out',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFF36122),
            ),
          )
          .animate()
          .fadeIn(delay: 200.ms, duration: 800.ms),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              if (isMobile) {
                return Column(
                  children: features.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: _buildFeatureItem(
                        entry.value['title']! as String,
                        entry.value['description']! as String,
                        entry.value['icon'] as IconData,
                        entry.key,
                      ),
                    );
                  }).toList(),
                );
              } else {
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                  ),
                  itemCount: features.length,
                  itemBuilder: (context, index) {
                    return VisibilityDetector(
                      key: Key('feature-item-$index'),
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction > 0.2) {
                          setState(() {});
                        }
                      },
                      child: _buildFeatureItem(
                        features[index]['title']! as String,
                        features[index]['description']! as String,
                        features[index]['icon'] as IconData,
                        index,
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description, IconData icon, int index) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFFF36122),
              size: 40,
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.5,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    )
    .animate()
    .fadeIn(delay: Duration(milliseconds: 200 * index))
    .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad, duration: 800.ms);
  }

  Widget _buildCallToActionSection(bool isMobile) {
    return VisibilityDetector(
      key: const Key('cta-section'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.2) {
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 80,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: const AssetImage('images/foam.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8),
              BlendMode.darken,
            ),
          ),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 80,
          ),
          child: Column(
            children: [
              Text(
                'READY FOR SOME FUN?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.bold,
                ),
              )
              .animate()
              .fadeIn(duration: 800.ms)
              .shimmer(delay: 800.ms, duration: 1800.ms, color: const Color(0xFFF36122)),
              const SizedBox(height: 20),
              const Text(
                'Visit one of our play parks today or contact us for birthday party bookings!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              )
              .animate()
              .fadeIn(delay: 400.ms),
              const SizedBox(height: 40),
              isMobile 
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildAnimatedButton(
                      'VISIT NOW',
                      const Color(0xFFF36122),
                      Colors.white,
                      () => context.go('/book-jump'),
                      Icons.directions_run,
                    ),
                    const SizedBox(height: 15),
                    _buildAnimatedButton(
                      'CONTACT US',
                      Colors.transparent,
                      Colors.white,
                      () => context.go('/contact'),
                      Icons.email,
                      hasBorder: true,
                    ),
                  ],
                )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAnimatedButton(
                    'VISIT NOW',
                    const Color(0xFFF36122),
                    Colors.white,
                    () => context.go('/book-jump'),
                    Icons.directions_run,
                  ),
                  const SizedBox(width: 20),
                  _buildAnimatedButton(
                    'CONTACT US',
                    Colors.transparent,
                    Colors.white,
                    () => context.go('/contact'),
                    Icons.email,
                    hasBorder: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildAnimatedButton(
    String text,
    Color backgroundColor,
    Color textColor,
    VoidCallback onPressed,
    IconData icon, {
    bool hasBorder = false,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: StatefulBuilder(
        builder: (context, setState) {
          bool isHovered = false;
          
          return MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: isHovered ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(),
              child: ElevatedButton.icon(
                onPressed: onPressed,
                icon: Icon(icon),
                label: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  foregroundColor: textColor,
                  side: hasBorder ? BorderSide(color: Colors.white) : null,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30, 
                    vertical: 15,
                  ),
                  elevation: isHovered ? 12 : 4,
                  shadowColor: isHovered ? backgroundColor.withOpacity(0.8) : backgroundColor.withOpacity(0.3),
                ),
              ),
            ),
          );
        },
      ),
    )
    .animate()
    .fadeIn(delay: hasBorder ? 800.ms : 600.ms)
    .slideY(begin: 0.3, end: 0);
  }
} 