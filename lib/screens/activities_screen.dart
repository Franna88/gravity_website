import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import 'package:visibility_detector/visibility_detector.dart';

import '../widgets/page_layout.dart';
import '../widgets/tilt_card.dart';
import '../widgets/card_3d.dart';
import '../widgets/glass_container.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final ScrollController _scrollController = ScrollController();
  
  // Add a map to track visibility state
  final Map<int, bool> _visibleItems = {};
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    
    return PageLayout(
      currentPath: '/activities',
      scrollController: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSimpleHero(isMobile),
          _buildSimpleActivities(isMobile),
          _buildSimplePricing(isMobile),
          _buildSimpleFitness(isMobile),
        ],
      ),
    );
  }

  Widget _buildSimpleHero(bool isMobile) {
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
                  'images/Kid-Slide.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          // Animated particles
          Positioned.fill(
            child: _buildAnimatedParticles(),
          ),
          
          // Enhanced hero content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ACTIVITIES',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.bold,
                  ),
                )
                .animate()
                .fadeIn(duration: 800.ms)
                .shimmer(delay: 800.ms, duration: 1800.ms),
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
                .fadeIn(delay: 300.ms)
                .scale(
                  begin: const Offset(0, 1),
                  end: const Offset(1, 1),
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 20),
                GlassContainer(
                  width: isMobile ? 280 : 400,
                  blur: 8,
                  opacity: 0.15,
                  child: Text(
                    'Explore our range of fun activities for all ages',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 16 : 18,
                    ),
                  ),
                )
                .animate()
                .fadeIn(delay: 500.ms)
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAnimatedParticles() {
    return Stack(
      children: List.generate(40, (index) {
        final random = math.Random();
        final size = random.nextDouble() * 6 + 2;
        final x = random.nextDouble() * MediaQuery.of(context).size.width;
        final y = random.nextDouble() * (ResponsiveBreakpoints.of(context).smallerThan(TABLET) ? 300 : 400);
        
        return Positioned(
          left: x,
          top: y,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: index % 2 == 0 
                ? const Color(0xFFF36122).withOpacity(0.6)
                : const Color(0xFF87C540).withOpacity(0.6),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: index % 2 == 0 
                    ? const Color(0xFFF36122).withOpacity(0.3)
                    : const Color(0xFF87C540).withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 3,
                ),
              ],
            ),
          )
          .animate(onPlay: (controller) => controller.repeat())
          .scale(
            begin: const Offset(0.1, 0.1),
            end: const Offset(2.0, 2.0),
            duration: Duration(milliseconds: 2000 + random.nextInt(2000)),
          )
          .then(delay: Duration(milliseconds: random.nextInt(1000)))
          .fadeOut(duration: 500.ms),
        );
      }),
    );
  }

  Widget _buildSimpleActivities(bool isMobile) {
    final List<Map<String, dynamic>> activities = [
      {
        'title': 'Open Jump Arena',
        'description': 'Our interconnected trampolines allow you to bounce freely across the arena. Perfect for freestyle jumping, practicing tricks, or just having fun with friends.',
        'image': 'images/Open-Jump.jpg',
        'icon': Icons.sports,
      },
      {
        'title': 'Foam Pit',
        'description': 'Practice your flips and tricks with a soft landing guaranteed in our foam pit. Great for beginners learning new moves or experienced jumpers perfecting their technique.',
        'image': 'images/foam.jpg',
        'icon': Icons.pool,
      },
      {
        'title': 'Basketball',
        'description': 'Take your basketball skills to new heights! Our trampoline basketball court lets you soar through the air for slam dunks that would make any pro jealous.',
        'image': 'images/basket.jpg',
        'icon': Icons.sports_basketball,
      },
      {
        'title': 'Rope Course & Climbing Walls',
        'description': 'Test your balance, strength and courage on our elevated rope course and challenging climbing walls. A great way to build confidence and overcome fears.',
        'image': 'images/Children-Climb.jpg',
        'icon': Icons.terrain,
      },
      {
        'title': 'Ninja Course',
        'description': 'Channel your inner ninja warrior as you navigate obstacles, balance challenges, and agility tests that will push your limits and build your skills.',
        'image': 'images/ninja.jpg',
        'icon': Icons.directions_run,
      },
      {
        'title': 'Devil Slide',
        'description': 'Feel the adrenaline rush as you plunge down our devil slide. This thrilling attraction will have you coming back for more every time!',
        'image': 'images/slide.jpg',
        'icon': Icons.height,
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'EXPLORE OUR ACTIVITIES',
              style: TextStyle(
                color: Colors.black,
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          )
          .animate()
          .fadeIn(duration: 600.ms)
          .moveY(begin: 30, end: 0),
          const SizedBox(height: 10),
          Center(
            child: Text(
              'Something for Everyone',
              style: TextStyle(
                color: Color(0xFFF36122),
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          )
          .animate()
          .fadeIn(delay: 200.ms, duration: 600.ms),
          const SizedBox(height: 50),
          
          // Enhanced activity cards
          if (isMobile)
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return VisibilityDetector(
                  key: Key('mobile-activity-$index'),
                  onVisibilityChanged: (visibilityInfo) {
                    if (visibilityInfo.visibleFraction > 0.2 && !(_visibleItems[index] ?? false)) {
                      setState(() {
                        _visibleItems[index] = true;
                      });
                    }
                  },
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: _visibleItems[index] ?? false ? 1.0 : 0.0,
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 800),
                      offset: _visibleItems[index] ?? false 
                        ? Offset.zero 
                        : Offset(index.isEven ? -0.5 : 0.5, 0),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: _buildEnhancedMobileActivityCard(
                          activity['title'] as String,
                          activity['description'] as String,
                          activity['image'] as String,
                          activity['icon'] as IconData,
                          index,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          else
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 30,
                mainAxisSpacing: 50,
              ),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                final rowIndex = index ~/ 2; // Calculate row index (0, 0, 1, 1, 2, 2)
                final isEvenRow = rowIndex.isEven;
                
                return VisibilityDetector(
                  key: Key('activity-$index'),
                  onVisibilityChanged: (visibilityInfo) {
                    if (visibilityInfo.visibleFraction > 0.2 && !(_visibleItems[rowIndex] ?? false)) {
                      setState(() {
                        _visibleItems[rowIndex] = true;
                      });
                    }
                  },
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: _visibleItems[rowIndex] ?? false ? 1.0 : 0.0,
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 800),
                      offset: _visibleItems[rowIndex] ?? false 
                        ? Offset.zero 
                        : Offset(isEvenRow ? -0.5 : 0.5, 0),
                      child: _buildEnhancedActivityCard(
                        activity['title'] as String,
                        activity['description'] as String,
                        activity['image'] as String,
                        activity['icon'] as IconData,
                        index,
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
  
  Widget _buildEnhancedActivityCard(
    String title,
    String description,
    String imagePath,
    IconData icon,
    int index,
  ) {
    return ActivityCard3D(
      title: title,
      description: description,
      imagePath: imagePath,
      icon: icon,
      color: index % 3 == 0 ? const Color(0xFFF36122) : 
             index % 3 == 1 ? const Color(0xFF87C540) : 
             Colors.deepPurple,
      onTap: () => context.go('/booking'),
    )
    .animate()
    .fadeIn(delay: Duration(milliseconds: 200 * index))
    .slideY(begin: 0.3, end: 0, curve: Curves.easeOutQuad, duration: 800.ms);
  }
  
  Widget _buildEnhancedMobileActivityCard(
    String title,
    String description,
    String imagePath,
    IconData icon,
    int index,
  ) {
    return TiltCard(
      tiltFactor: 0.05,
      glowFactor: 0.3,
      glowColor: index % 3 == 0 ? const Color(0xFFF36122) : 
                index % 3 == 1 ? const Color(0xFF87C540) : 
                Colors.deepPurple,
      child: Card(
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () => context.go('/booking'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16/9,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {},
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    top: 16,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Icon(
                        icon,
                        color: index % 3 == 0 ? const Color(0xFFF36122) : 
                               index % 3 == 1 ? const Color(0xFF87C540) : 
                               Colors.deepPurple,
                        size: 30,
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .rotate(
                      duration: 2.seconds,
                      begin: -0.05,
                      end: 0.05,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF36122),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => context.go('/booking'),
                        icon: const Icon(Icons.star),
                        label: const Text("TRY IT OUT"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: index % 3 == 0 ? const Color(0xFFF36122) : 
                                         index % 3 == 1 ? const Color(0xFF87C540) : 
                                         Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
    .animate()
    .fadeIn(delay: Duration(milliseconds: 200 * index))
    .slideY(begin: 0.3, end: 0, curve: Curves.easeOutQuad, duration: 800.ms);
  }

  Widget _buildSimplePricing(bool isMobile) {
    final pricingOptions = [
      {
        'title': 'Standard Jump',
        'duration': '1 Hour',
        'price': 'R120',
        'features': [
          'Access to Jump Arena',
          'Access to Foam Pit',
          'Access to Basketball Courts',
        ],
        'color': const Color(0xFFF36122),
      },
      {
        'title': 'Premium Jump',
        'duration': '2 Hours',
        'price': 'R200',
        'features': [
          'All Standard Jump features',
          'Access to Ninja Course',
          'Access to Devil Slide',
          'Free Gravity Socks',
        ],
        'color': const Color(0xFF87C540),
        'popular': true,
      },
      {
        'title': 'Ultimate Adventure',
        'duration': '3 Hours',
        'price': 'R280',
        'features': [
          'All Premium Jump features',
          'Access to Rope Course',
          'Access to Climbing Walls',
          'Bottle of Water',
        ],
        'color': Colors.black,
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        image: DecorationImage(
          image: const AssetImage('images/pattern.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.9),
            BlendMode.dstATop,
          ),
          opacity: 0.05,
        ),
      ),
      child: Column(
        children: [
          Text(
            'PRICING OPTIONS',
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
          .animate()
          .fadeIn(duration: 800.ms)
          .moveY(begin: 30, end: 0),
          const SizedBox(height: 10),
          const Text(
            'Choose Your Adventure',
            style: TextStyle(
              color: Color(0xFFF36122),
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          )
          .animate()
          .fadeIn(delay: 200.ms)
          .shimmer(delay: 1200.ms, duration: 1800.ms),
          const SizedBox(height: 50),
          if (isMobile)
            SizedBox(
              height: 520,
              child: Swiper(
                itemCount: pricingOptions.length,
                itemBuilder: (context, index) {
                  final option = pricingOptions[index];
                  return _build3DPricingCard(
                    option['title'].toString(),
                    option['duration'].toString(),
                    option['price'].toString(),
                    (option['features'] as List<dynamic>).cast<String>(),
                    option['color'] as Color,
                    option.containsKey('popular'),
                    index,
                  );
                },
                pagination: const SwiperPagination(),
                viewportFraction: 0.85,
                scale: 0.9,
                autoplay: true,
                autoplayDelay: 5000,
              ),
            )
          else
            SizedBox(
              height: 520,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: pricingOptions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: _build3DPricingCard(
                        option['title'].toString(),
                        option['duration'].toString(),
                        option['price'].toString(),
                        (option['features'] as List<dynamic>).cast<String>(),
                        option['color'] as Color,
                        option.containsKey('popular'),
                        index,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          const SizedBox(height: 50),
          GlassContainer(
            width: isMobile ? null : 600,
            blur: 3,
            opacity: 0.1,
            color: Colors.black,
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Special rates available for groups, schools, and events. Contact us for more information.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          )
          .animate()
          .fadeIn(delay: 800.ms)
          .moveY(begin: 30, end: 0),
        ],
      ),
    );
  }

  Widget _build3DPricingCard(
    String title,
    String duration,
    String price,
    List<String> features,
    Color color,
    bool isPopular,
    int index,
  ) {
    return TiltCard(
      tiltFactor: 0.03,
      glowFactor: isPopular ? 0.3 : 0.1,
      glowColor: color,
      child: Card(
        elevation: 15,
        shadowColor: color.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isPopular ? BorderSide(color: color, width: 2) : BorderSide.none,
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                  .animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .moveY(begin: 0, end: -5, duration: 2.seconds),
                  const SizedBox(height: 20),
                  Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  )
                  .animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .shimmer(delay: 1500.ms, duration: 1800.ms),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: features.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: color,
                                size: 20,
                              )
                              .animate(delay: Duration(milliseconds: 200 * index))
                              .scale(
                                begin: const Offset(0, 0),
                                end: const Offset(1, 1),
                                duration: 500.ms,
                                curve: Curves.elasticOut,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  features[index],
                                  style: const TextStyle(
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/booking');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        elevation: 10,
                        shadowColor: color.withOpacity(0.5),
                      ),
                      child: const Text(
                        'BOOK NOW',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                  .animate()
                  .shimmer(delay: 800.ms, duration: 1800.ms),
                ],
              ),
            ),
            if (isPopular)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'POPULAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
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

  Widget _buildSimpleFitness(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isMobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: TiltCard(
                    tiltFactor: 0.1,
                    glowFactor: 0.2,
                    glowColor: const Color(0xFF87C540),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AspectRatio(
                        aspectRatio: 4/3,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                image: const DecorationImage(
                                  image: AssetImage('images/fit.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Gradient overlay
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.6),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF87C540),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.fitness_center,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'FITNESS CLASSES',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .animate()
                              .fadeIn(delay: 700.ms)
                              .slideX(begin: -0.5, end: 0, curve: Curves.easeOutQuad),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .slideX(begin: -0.3, end: 0),
                ),
                const SizedBox(width: 50),
                Expanded(
                  flex: 7,
                  child: _buildFitnessContent(isMobile),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFitnessContent(isMobile),
                const SizedBox(height: 30),
                TiltCard(
                  tiltFactor: 0.05,
                  glowFactor: 0.2,
                  glowColor: const Color(0xFF87C540),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AspectRatio(
                      aspectRatio: 16/9,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              image: const DecorationImage(
                                image: AssetImage('images/fit.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Gradient overlay
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.6),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF87C540),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.fitness_center,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'FITNESS CLASSES',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildFitnessContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'FITNESS & EXERCISE',
          style: TextStyle(
            color: Color(0xFFF36122),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
        .animate()
        .fadeIn()
        .slideX(begin: -0.2, end: 0),
        const SizedBox(height: 15),
        Text(
          'Get Fit While Having Fun',
          style: TextStyle(
            color: Colors.black,
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms)
        .slideX(begin: -0.2, end: 0),
        const SizedBox(height: 20),
        const Text(
          'Did you know that jumping on a trampoline can burn up to 1,000 calories an hour while being easier on your joints than running or high-impact aerobics? Our fitness classes combine the fun of trampolining with effective workout routines.',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            height: 1.6,
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms)
        .slideX(begin: -0.2, end: 0),
        const SizedBox(height: 20),
        const Text(
          'Benefits include:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        )
        .animate()
        .fadeIn(delay: 600.ms)
        .shimmer(delay: 1200.ms, duration: 1800.ms),
        const SizedBox(height: 15),
        ...[
          _buildBenefitItem('Improves cardiovascular fitness', 0),
          _buildBenefitItem('Strengthens muscles throughout your body', 1),
          _buildBenefitItem('Enhances balance and coordination', 2),
          _buildBenefitItem("Low-impact exercise that's gentle on joints", 3),
          _buildBenefitItem('Boosts lymphatic circulation and immunity', 4),
        ],
        const SizedBox(height: 30),
        SizedBox(
          width: 250,
          child: TiltCard(
            tiltFactor: 0.15,
            glowFactor: 0.2,
            glowColor: const Color(0xFF87C540),
            child: ElevatedButton(
              onPressed: () => context.go('/booking'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF87C540),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20, 
                  vertical: 15,
                ),
                elevation: 10,
                shadowColor: const Color(0xFF87C540).withOpacity(0.5),
              ),
              child: const Text(
                'VIEW FITNESS CLASS SCHEDULE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
          .animate()
          .fadeIn(delay: 1000.ms)
          .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0)),
        ),
      ],
    );
  }

  Widget _buildBenefitItem(String text, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Icon(
              Icons.check_circle,
              color: const Color(0xFF87C540),
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    )
    .animate()
    .fadeIn(delay: Duration(milliseconds: 800 + 200 * index))
    .slideX(begin: -0.2, end: 0);
  }
} 