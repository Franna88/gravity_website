import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:go_router/go_router.dart';

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
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                'images/foam.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                  ),
                ).animate().fadeIn(duration: 500.ms),
                const SizedBox(height: 20),
                Container(
                  width: 100,
                  height: 5,
                  color: const Color(0xFFF36122),
                ).animate().fadeIn(duration: 500.ms, delay: 200.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            'OUR INDOOR PLAY PARKS',
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            constraints: BoxConstraints(
              maxWidth: isMobile ? double.infinity : 800,
            ),
            child: const Text(
              'Gravity offers two exciting indoor play park locations in Port Elizabeth - Baywest Mall and Walmer Park Shopping Centre. Our play parks are the perfect place for children to have fun, burn energy, and develop new skills in a safe and supervised environment.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFF36122),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 40),
          isMobile
              ? Column(
                  children: [
                    _buildLocationCard('Baywest Play Park'),
                    const SizedBox(height: 20),
                    _buildLocationCard('Walmer Park Play Park'),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: _buildLocationCard('Baywest Play Park'),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: _buildLocationCard('Walmer Park Play Park'),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(String title) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: const AssetImage('images/walmer-hero.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6),
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF36122),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'VIEW DETAILS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn();
  }

  Widget _buildLocationSection(bool isMobile, String title, bool isFirst) {
    return Container(
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
          ),
          const SizedBox(height: 10),
          const Text(
            'Fun & Adventure for Kids',
            style: TextStyle(
              color: Color(0xFFF36122),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 40),
          isMobile
              ? Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'images/baywest.jpg',
                        fit: BoxFit.cover,
                        height: 300,
                        width: double.infinity,
                      ),
                    ),
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
                          'images/walmer.jpg',
                          fit: BoxFit.cover,
                          height: 400,
                        ),
                      ),
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
        ),
        const SizedBox(height: 15),
        Text(
          title == 'Baywest Play Park'
              ? 'Our flagship play park located in Baywest Mall offers a spacious and modern play environment for children of all ages. The facility includes multiple play zones designed to encourage physical activity, imagination, and social interaction.'
              : 'The Walmer Park Shopping Centre location provides a convenient and fun play option for families. This play park features innovative play equipment in a compact but well-designed space that children love to explore.',
          style: const TextStyle(
            height: 1.6,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Features',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        ...features.map((feature) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Color(0xFF87C540),
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
        )),
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
              ),
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
              ),
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
            ),
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
            ),
          ],
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () => context.go('/booking'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF36122),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 15,
            ),
          ),
          child: const Text(
            'BOOK A JUMP',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(bool isMobile) {
    final features = [
      {
        'title': 'Safe Environment',
        'description': 'All our play parks are designed with safety as the top priority, with soft play surfaces and constant supervision.',
        'icon': Icons.shield,
      },
      {
        'title': 'Age-Appropriate Zones',
        'description': 'Dedicated areas for different age groups ensure that both toddlers and older children can play comfortably.',
        'icon': Icons.people,
      },
      {
        'title': 'Birthday Parties',
        'description': 'We offer special birthday party packages that include private party rooms and play time.',
        'icon': Icons.cake,
      },
      {
        'title': 'Parent Comfort',
        'description': 'Comfortable seating areas for parents with WiFi and refreshments available.',
        'icon': Icons.weekend,
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
            'WHY CHOOSE OUR PLAY PARKS?',
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 50),
          isMobile
              ? Column(
                  children: features.map((feature) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: _buildFeatureCard(
                        feature['title'].toString(),
                        feature['description'].toString(),
                        feature['icon'] as IconData,
                      ),
                    );
                  }).toList(),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                  ),
                  itemCount: features.length,
                  itemBuilder: (context, index) {
                    return _buildFeatureCard(
                      features[index]['title'].toString(),
                      features[index]['description'].toString(),
                      features[index]['icon'] as IconData,
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String title, String description, IconData icon) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn();
  }

  Widget _buildCallToActionSection(bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 80,
      ),
      color: Colors.black,
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
            ),
            const SizedBox(height: 20),
            const Text(
              'Visit one of our play parks today or contact us for birthday party bookings!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 40),
            isMobile 
            ? Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.go('/booking'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF36122),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                      ),
                      child: const Text(
                        'VISIT NOW',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.go('/contact'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                      ),
                      child: const Text(
                        'CONTACT US',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.go('/booking'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF36122),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'VISIT NOW',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => context.go('/contact'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'CONTACT US',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 