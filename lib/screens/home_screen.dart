import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
      height: isMobile ? 500 : 700,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          // Parallax background
          Positioned(
            top: -_parallaxOffset,
            left: 0,
            right: 0,
            height: isMobile ? 600 : 800,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.srcOver,
              ),
              child: Opacity(
                opacity: 0.7,
                child: Image.asset('images/Kid-Jump.jpg', fit: BoxFit.cover),
              ),
            ),
          ),
          // Content
          Container(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'THE ULTIMATE PLAYGROUND',
                  style: TextStyle(
                    color: const Color(0xFFF36122),
                    fontSize: isMobile ? 24 : 48,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 20),
                Text(
                  'Gravity Indoor Trampoline Park in Port Elizabeth \nhas over 2000m² of pure adventure waiting for you!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 18 : 24,
                    height: 1.4,
                  ),
                ).animate().fadeIn(delay: 400.ms),
                const SizedBox(height: 30),
                isMobile
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () => context.go('/activities'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF36122),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                          ),
                          child: const Text(
                            'EXPLORE ACTIVITIES',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ).animate().fadeIn(delay: 600.ms),
                        const SizedBox(height: 15),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ).animate().fadeIn(delay: 800.ms),
                      ],
                    )
                    : Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => context.go('/activities'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF36122),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                          ),
                          child: const Text(
                            'EXPLORE ACTIVITIES',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ).animate().fadeIn(delay: 600.ms),
                        const SizedBox(width: 15),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ).animate().fadeIn(delay: 800.ms),
                      ],
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitiesSection(bool isMobile) {
    final List<Map<String, dynamic>> activities = [
      {
        'title': 'Open Jump Arena',
        'description':
            'Bounce to your heart\'s content on our interconnected trampolines.',
        'icon': Icons.sports_gymnastics,
      },
      {
        'title': 'Foam Pit',
        'description':
            'Practice your flips and tricks with a soft landing guaranteed.',
        'icon': Icons.waves,
      },
      {
        'title': 'Basketball',
        'description':
            'Slam dunk like a pro with trampolines to boost your jump.',
        'icon': Icons.sports_basketball,
      },
      {
        'title': 'Rope Course',
        'description':
            'Test your balance and courage on our elevated rope course.',
        'icon': Icons.directions_run,
      },
      {
        'title': 'Climbing Walls',
        'description': 'Scale new heights on our challenging climbing walls.',
        'icon': Icons.terrain,
      },
      {
        'title': 'Escape Rooms',
        'description': 'Test your wits in our challenging themed escape rooms.',
        'icon': Icons.key,
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
            'OUR ACTIVITIES',
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Endless Fun For Everyone',
            style: TextStyle(color: Color(0xFFF36122), fontSize: 18),
          ),
          const SizedBox(height: 50),
          isMobile
              ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: _buildActivityCard(
                      activities[index]['title'] as String,
                      activities[index]['description'] as String,
                      activities[index]['icon'] as IconData,
                      index,
                    ),
                  );
                },
              )
              : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  return _buildActivityCard(
                    activities[index]['title'] as String,
                    activities[index]['description'] as String,
                    activities[index]['icon'] as IconData,
                    index,
                  );
                },
              ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () => context.go('/activities'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF87C540),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text(
              'VIEW ALL ACTIVITIES',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(
    String title,
    String description,
    IconData icon,
    int index,
  ) {
    final bool isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);

    if (isMobile) {
      // Compact mobile layout with minimal height
      return Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF36122).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: const Color(0xFFF36122), size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(delay: (100 * index).ms);
    } else {
      // Desktop layout
      return Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: const Color(0xFFF36122), size: 40),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Text(
                  description,
                  style: const TextStyle(color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(delay: (100 * index).ms);
    }
  }

  Widget _buildBookJumpSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'BOOK A JUMP',
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Jump into the fun with our flexible booking options!',
            style: TextStyle(color: Color(0xFFF36122), fontSize: 18),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () => context.go('/booking'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF36122),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text(
              'BOOK NOW',
              style: TextStyle(fontWeight: FontWeight.bold),
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
      child: Row(
        children: [
          if (!isMobile)
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('images/family.jpg', fit: BoxFit.cover),
              ),
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
                ),
                const SizedBox(height: 15),
                Text(
                  'Host Your Ultimate Party',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: isMobile ? 24 : 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Our three air-conditioned private party rooms can accommodate up to 50 people per room, making us the perfect venue for birthday parties, team building events, school outings, and more!',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 30),
                if (isMobile)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'images/family.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (isMobile)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFeatureItem('Private Rooms'),
                      const SizedBox(height: 10),
                      _buildFeatureItem('Catering Options'),
                      const SizedBox(height: 10),
                      _buildFeatureItem('Dedicated Host'),
                      const SizedBox(height: 10),
                      _buildFeatureItem('All Ages Welcome'),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildFeatureItem('Private Rooms'),
                          const SizedBox(width: 30),
                          _buildFeatureItem('Catering Options'),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          _buildFeatureItem('Dedicated Host'),
                          const SizedBox(width: 30),
                          _buildFeatureItem('All Ages Welcome'),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'BOOK A PARTY',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
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
        'quote':
            "Our son's birthday party was amazing! The staff was helpful and everything was well-organized.",
        'name': 'Sarah T.',
        'title': 'Parent',
      },
      {
        'quote':
            'The escape rooms are challenging and so much fun! Great team building activity for our office.',
        'name': 'Michael K.',
        'title': 'Business Manager',
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
          ),
          const SizedBox(height: 50),
          Row(
            children: [
              if (!isMobile) const Spacer(flex: 1),
              Expanded(
                flex: 10,
                child:
                    isMobile
                        ? Column(
                          children:
                              testimonials
                                  .map(
                                    (t) => Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 20,
                                      ),
                                      child: _buildTestimonialCard(
                                        t['quote'] as String,
                                        t['name'] as String,
                                        t['title'] as String,
                                      ),
                                    ),
                                  )
                                  .toList(),
                        )
                        : Row(
                          children:
                              testimonials
                                  .map(
                                    (t) => Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: _buildTestimonialCard(
                                          t['quote'] as String,
                                          t['name'] as String,
                                          t['title'] as String,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
              ),
              if (!isMobile) const Spacer(flex: 1),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(String quote, String name, String title) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.format_quote, color: Color(0xFFF36122), size: 40),
            const SizedBox(height: 20),
            Text(
              quote,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFF87C540),
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(title, style: const TextStyle(color: Colors.black54)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn();
  }
}
