import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:go_router/go_router.dart';

import '../widgets/page_layout.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
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
                ),
                const SizedBox(height: 20),
                Container(
                  width: 100,
                  height: 5,
                  color: const Color(0xFFF36122),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleActivities(bool isMobile) {
    final List<Map<String, dynamic>> activities = [
      {
        'title': 'Open Jump Arena',
        'description': 'Our interconnected trampolines allow you to bounce freely across the arena. Perfect for freestyle jumping, practicing tricks, or just having fun with friends.',
        'image': 'images/Open-Jump.jpg',
      },
      {
        'title': 'Foam Pit',
        'description': 'Practice your flips and tricks with a soft landing guaranteed in our foam pit. Great for beginners learning new moves or experienced jumpers perfecting their technique.',
        'image': 'images/foam.jpg',
      },
      {
        'title': 'Basketball',
        'description': 'Take your basketball skills to new heights! Our trampoline basketball court lets you soar through the air for slam dunks that would make any pro jealous.',
        'image': 'images/basket.jpg',
      },
      {
        'title': 'Rope Course & Climbing Walls',
        'description': 'Test your balance, strength and courage on our elevated rope course and challenging climbing walls. A great way to build confidence and overcome fears.',
        'image': 'images/Children-Climb.jpg',
      },
      {
        'title': 'Ninja Course',
        'description': 'Channel your inner ninja warrior as you navigate obstacles, balance challenges, and agility tests that will push your limits and build your skills.',
        'image': 'images/ninja.jpg',
      },
      {
        'title': 'Devil Slide',
        'description': 'Feel the adrenaline rush as you plunge down our devil slide. This thrilling attraction will have you coming back for more every time!',
        'image': 'images/slide.jpg',
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
          ),
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
          ),
          const SizedBox(height: 50),
          // Simple list approach - no complex layout
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              
              if (isMobile) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 16/9,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[300],
                            image: DecorationImage(
                              image: AssetImage(activity['image'] as String),
                              fit: BoxFit.cover,
                              onError: (exception, stackTrace) {},
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        activity['title'] as String,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF36122),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        activity['description'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  height: 300,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index % 2 == 0) 
                        Expanded(
                          flex: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[300],
                              image: DecorationImage(
                                image: AssetImage(activity['image'] as String),
                                fit: BoxFit.cover,
                                onError: (exception, stackTrace) {},
                              ),
                            ),
                          ),
                        ),
                      if (index % 2 == 0) const SizedBox(width: 30),
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              activity['title'] as String,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF36122),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              activity['description'] as String,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (index % 2 != 0) const SizedBox(width: 30),
                      if (index % 2 != 0)
                        Expanded(
                          flex: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[300],
                              image: DecorationImage(
                                image: AssetImage(activity['image'] as String),
                                fit: BoxFit.cover,
                                onError: (exception, stackTrace) {},
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
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
      color: const Color(0xFFF8F8F8),
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
          ),
          const SizedBox(height: 10),
          const Text(
            'Choose Your Adventure',
            style: TextStyle(
              color: Color(0xFFF36122),
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          if (isMobile)
            SizedBox(
              height: 450,
              child: Swiper(
                itemCount: pricingOptions.length,
                itemBuilder: (context, index) {
                  final option = pricingOptions[index];
                  return _buildSimplePricingCard(
                    option['title'].toString(),
                    option['duration'].toString(),
                    option['price'].toString(),
                    (option['features'] as List<dynamic>).cast<String>(),
                    option['color'] as Color,
                    option.containsKey('popular'),
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
              height: 450,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: pricingOptions.map((option) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: _buildSimplePricingCard(
                        option['title'].toString(),
                        option['duration'].toString(),
                        option['price'].toString(),
                        (option['features'] as List<dynamic>).cast<String>(),
                        option['color'] as Color,
                        option.containsKey('popular'),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          const SizedBox(height: 50),
          const Text(
            'Special rates available for groups, schools, and events. Contact us for more information.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimplePricingCard(
    String title,
    String duration,
    String price,
    List<String> features,
    Color color,
    bool isPopular,
  ) {
    return Card(
      elevation: 5,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
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
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: features.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: color,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(features[index]),
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
                    ),
                    child: const Text(
                      'BOOK NOW',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
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
                decoration: const BoxDecoration(
                  color: Color(0xFFF36122),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: const Text(
                  'POPULAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
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
                  child: AspectRatio(
                    aspectRatio: 4/3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[300],
                        image: const DecorationImage(
                          image: AssetImage('images/fit.jpg'),
                          fit: BoxFit.cover,
                          onError: null,
                        ),
                      ),
                    ),
                  ),
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
                AspectRatio(
                  aspectRatio: 16/9,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                      image: const DecorationImage(
                        image: AssetImage('images/fit.jpg'),
                        fit: BoxFit.cover,
                        onError: null,
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
        ),
        const SizedBox(height: 15),
        Text(
          'Get Fit While Having Fun',
          style: TextStyle(
            color: Colors.black,
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Did you know that jumping on a trampoline can burn up to 1,000 calories an hour while being easier on your joints than running or high-impact aerobics? Our fitness classes combine the fun of trampolining with effective workout routines.',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Benefits include:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 15),
        _buildBenefitItem('Improves cardiovascular fitness'),
        _buildBenefitItem('Strengthens muscles throughout your body'),
        _buildBenefitItem('Enhances balance and coordination'),
        _buildBenefitItem("Low-impact exercise that's gentle on joints"),
        _buildBenefitItem('Boosts lymphatic circulation and immunity'),
        const SizedBox(height: 30),
        SizedBox(
          width: 250,
          child: ElevatedButton(
            onPressed: () => context.go('/booking'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF87C540),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20, 
                vertical: 15,
              ),
            ),
            child: const Text(
              'VIEW FITNESS CLASS SCHEDULE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Icon(
              Icons.check_circle,
              color: Color(0xFF87C540),
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
    );
  }
} 