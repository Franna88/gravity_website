import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gravity/screens/booking/booking_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:go_router/go_router.dart';
import 'package:card_swiper/card_swiper.dart';

import '../widgets/page_layout.dart';


class PartiesScreen extends StatefulWidget {
  const PartiesScreen({super.key});

  @override
  State<PartiesScreen> createState() => _PartiesScreenState();
}

class _PartiesScreenState extends State<PartiesScreen> {
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
      currentPath: '/parties',
      scrollController: _scrollController,
      child: Column(
        children: [
          _buildHeroSection(isMobile),
          _buildIntroSection(isMobile),
          _buildRegularPackagesSection(isMobile),
          _buildEscapeRoomPackagesSection(isMobile),
          _buildFAQSection(isMobile),
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
                  'images/party.jpg',
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
                  'PARTIES & EVENTS',
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
            'HOST YOUR ULTIMATE CELEBRATION',
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Looking for the perfect venue for your next birthday party, corporate event, or school outing? Look no further than Gravity!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFF36122),
            ),
          ),
          const SizedBox(height: 40),
          isMobile
              ? Column(
                  children: [
                    _buildFeatureBox(
                      'Private Rooms', 
                      'Three air-conditioned private party rooms that can accommodate up to 50 people per room.',
                      Icons.meeting_room,
                    ),
                    const SizedBox(height: 20),
                    _buildFeatureBox(
                      'Dedicated Host', 
                      'Each party is assigned a dedicated host to ensure everything runs smoothly.',
                      Icons.person,
                    ),
                    const SizedBox(height: 20),
                    _buildFeatureBox(
                      'Catering Options', 
                      'Choose from a variety of food and beverage options or bring your own cake.',
                      Icons.restaurant,
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: _buildFeatureBox(
                        'Private Rooms', 
                        'Three air-conditioned private party rooms that can accommodate up to 50 people per room.',
                        Icons.meeting_room,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildFeatureBox(
                        'Dedicated Host', 
                        'Each party is assigned a dedicated host to ensure everything runs smoothly.',
                        Icons.person,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildFeatureBox(
                        'Catering Options', 
                        'Choose from a variety of food and beverage options or bring your own cake.',
                        Icons.restaurant,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildFeatureBox(String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xFFF36122),
            size: 50,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildRegularPackagesSection(bool isMobile) {
    final packages = [
      {
        'title': 'PARTY PACKAGE 1',
        'subtitle': 'Standard Package',
        'price': 'R2300 for 10 children',
        'description': 'Our basic package, perfect for birthday parties.',
        'features': [
          'R2300 for 10 children',
          'R230 per extra child',
          '1 hour on the trampoline arena',
          '1 hour in the party room',
          'Slush Puppie or water and bag of popcorn',
        ],
        'color': const Color(0xFFF36122),
      },
      {
        'title': 'PARTY PACKAGE 2',
        'subtitle': 'Trampoline Arena Rental',
        'price': 'R10 000',
        'description': 'Rent the entire trampoline arena for your group!',
        'features': [
          'R10 000 to rent the whole trampoline arena for 1 hour (when available)',
          'Maximum of 40 people',
          'R250 per extra person',
          '1 hour in the party room',
          'Slush Puppie or water and bag of popcorn',
        ],
        'color': const Color(0xFF87C540),
      },
      {
        'title': 'PARTY PACKAGE 3',
        'subtitle': 'Social Area Package',
        'price': 'R2000 for 10 kids',
        'description': 'Enjoy our social area with this great value package.',
        'features': [
          'R2000 for 10 kids',
          'R200 per additional child',
          '2 hour access to the venue',
          '1 hour access to trampoline arena',
          '1 Slush Puppie or water per child and bag of popcorn',
          '1 burger platter',
          '1 2L jug of juice',
          'Reserved table in the common area',
        ],
        'color': const Color(0xFFF36122),
      },
      {
        'title': 'PARTY PACKAGE 4',
        'subtitle': 'Social Area Gold Package',
        'price': 'R2400 for 10 kids',
        'description': 'An upgraded social area experience with more jump time.',
        'features': [
          'R2400 for 10 kids',
          'R240 per additional child',
          '2 hour access to the trampoline arena',
          'Reserved table in the general area',
          '10 x Slush Puppies or waters',
          '1 Burger Platter',
        ],
        'color': Colors.amber[700],
      },
      {
        'title': 'PARTY PACKAGE 5',
        'subtitle': 'Gravity Ultimate Package',
        'price': 'R2800 for 10 kids',
        'description': 'Our premium party experience with all the extras!',
        'features': [
          'R2800 for 10 kids',
          'R280 per additional child',
          '3 hour access to the trampoline arena',
          'Reserved table in the general area',
          '10 x Slush Puppies or waters',
          '1 Burger Platter',
          'Disco lights (After 6pm Only)',
        ],
        'color': Colors.purple,
        'popular': true,
      },
      {
        'title': 'PARTY PACKAGE 6',
        'subtitle': 'Design your own Party',
        'price': 'Custom Pricing',
        'description': 'Flexibility to create your own party experience!',
        'features': [
          'Table booking only (minimum of 5 kids)',
          'Allows you to bring in cake & party packs only',
          'All ages - R120 for 1 hour (FULL ACCESS)',
          'R90 for an additional hour',
          'Buy your food as you need',
        ],
        'color': Colors.teal,
      },
      {
        'title': 'PARTY PACKAGE 7',
        'subtitle': 'Crazy Weekday Party Special',
        'price': 'R1700 for 10 kids',
        'description': 'Special weekday pricing for budget-conscious parties!',
        'features': [
          'R1700 for 10 Kids (Monday to Friday Only)',
          'R170 per additional child',
          '3-hour jump (full Access)',
          'Reserved table Anywhere in the general area',
          'Not available on public holidays or during School Holiday times',
        ],
        'color': const Color(0xFF87C540),
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
            'PARTY PACKAGES',
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Choose the Perfect Package for Your Event',
            style: TextStyle(
              color: Color(0xFFF36122),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Swipe to explore our different party packages',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
          // Carousel view for packages using Swiper
          SizedBox(
            height: isMobile ? 700 : 540,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                final package = packages[index];
                return _buildPackageCard(
                  package['title'] as String,
                  package['price'] as String,
                  package['description'] as String,
                  package['features'] as List<String>,
                  package['color'] as Color,
                  package.containsKey('popular'),
                  subtitle: package['subtitle'] as String,
                );
              },
              itemCount: packages.length,
              viewportFraction: isMobile ? 0.85 : 0.4,
              scale: 0.9,
              pagination: const SwiperPagination(
                margin: EdgeInsets.only(top: 20),
                builder: DotSwiperPaginationBuilder(
                  activeColor: Color(0xFFF36122),
                  color: Colors.grey,
                  size: 8.0,
                  activeSize: 12.0,
                ),
              ),
              control: SwiperControl(
                color: isMobile ? Colors.transparent : const Color(0xFFF36122),
                disableColor: Colors.transparent,
              ),
              autoplay: true,
              autoplayDelay: 5000,
            ),
          ),
          // const SizedBox(height: 40),
          // ElevatedButton(
          //   onPressed: () => context.go('/booking'),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: const Color(0xFF87C540),
          //     foregroundColor: Colors.white,
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 40,
          //       vertical: 15,
          //     ),
          //   ),
          //   child: const Text(
          //     'BOOK A PARTY NOW',
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 16,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildEscapeRoomPackagesSection(bool isMobile) {
    final packages = [
      {
        'title': 'Escape Room Party Package 1',
        'price': 'R2200 for 8 people',
        'description': 'Can you solve the puzzles and escape in time?',
        'features': [
          'R2200 for 8 people',
          'R275 per additional child or adult',
          'Two different rooms to choose from:',
          'Bank Heist room or Jumanji room',
          '1 Burger platter',
          '1 Slush Puppie or water per person',
        ],
        'color': const Color(0xFFF36122),
      },
      {
        'title': 'Escape Room Party Package 2',
        'price': 'R3700 for 10 people',
        'description': 'Premium escape room experience with jump time included!',
        'features': [
          'R3700 for 10 people',
          'R370 per additional child or adult',
          'Two different rooms to choose from:',
          'Bank Heist room or Jumanji room',
          '1 Burger platter',
          '1 Slush Puppie or water per person',
          '1 Hour jump',
        ],
        'color': const Color(0xFF87C540),
        'popular': true,
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
            'ESCAPE ROOM PARTY PACKAGES',
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Test Your Problem-Solving Skills with Friends',
            style: TextStyle(
              color: Color(0xFFF36122),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Our escape room parties offer an exciting challenge for birthdays, team-building events, or any special occasion. Race against the clock to solve puzzles and escape!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 50),
          if (isMobile)
            Column(
              children: packages.map((package) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: _buildPackageCard(
                    package['title'] as String,
                    package['price'] as String,
                    package['description'] as String,
                    package['features'] as List<String>,
                    package['color'] as Color,
                    package.containsKey('popular'),
                  ),
                );
              }).toList(),
            )
          else
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: packages.map((package) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildPackageCard(
                        package['title'] as String,
                        package['price'] as String,
                        package['description'] as String,
                        package['features'] as List<String>,
                        package['color'] as Color,
                        package.containsKey('popular'),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPackageCard(
    String title,
    String price,
    String description,
    List<String> features,
    Color color,
    bool isPopular, {
    String? subtitle,
  }) {
    // Extract the base person count and additional person cost from features
    int basePersonCount = 10; // Default value
    String additionalPersonCost = "R0"; // Default value
    
    // Parse the base person count
    for (String feature in features) {
      if (feature.contains("for 10")) {
        basePersonCount = 10;
      } else if (feature.contains("for 8")) {
        basePersonCount = 8;
      } else if (feature.contains("for 5")) {
        basePersonCount = 5;
      } else if (feature.contains("Maximum of 40")) {
        basePersonCount = 40;
      }
      
      // Parse the additional person cost
      if (feature.contains("per extra") || 
          feature.contains("per additional") || 
          feature.contains("per extra person")) {
        // Extract the cost using regex
        final RegExp regExp = RegExp(r'R(\d+)');
        final match = regExp.firstMatch(feature);
        if (match != null) {
          additionalPersonCost = "R${match.group(1)}";
        }
      }
    }

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  const SizedBox(height: 15),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: features.map((feature) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: color,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              feature,
                              style: const TextStyle(height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the booking screen with package details
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BookingScreen(
                              packageTitle: title,
                              packagePrice: price,
                              additionalPersonCost: additionalPersonCost,
                              basePersonCount: basePersonCount,
                              packageColor: color,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'BOOK THIS PACKAGE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: const Text(
                  'MOST POPULAR',
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
    ).animate().fadeIn();
  }

  Widget _buildFAQSection(bool isMobile) {
    final faqs = [
      {
        'question': 'How far in advance should I book my party?',
        'answer': 'We recommend booking at least 2-3 weeks in advance, especially for weekend parties which tend to fill up quickly. For corporate events, 1 month notice is preferred.',
      },
      {
        'question': 'Can I bring my own food and drinks?',
        'answer': 'Outside food and drinks are not permitted except for birthday cakes. We offer a variety of food and beverage packages to choose from.',
      },
      {
        'question': 'Is there an age limit for parties?',
        'answer': 'We host parties for all ages! For young children (under 6), we recommend our special toddler time sessions.',
      },
      {
        'question': 'What should guests wear?',
        'answer': 'Comfortable athletic clothing is recommended. All jumpers must wear Gravity socks, which can be purchased on-site.',
      },
      {
        'question': 'How many people can I invite?',
        'answer': 'Our party rooms can accommodate up to 50 people each. For larger groups, we can arrange to use multiple rooms.',
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
            'FREQUENTLY ASKED QUESTIONS',
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 50),
          ...faqs.map((faq) => _buildFAQItem(faq['question'] as String, faq['answer'] as String)),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ExpansionTile(
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconColor: const Color(0xFFF36122),
        textColor: const Color(0xFFF36122),
        children: [
          Text(
            answer,
            style: const TextStyle(
              height: 1.5,
              fontSize: 16,
            ),
          ),
        ],
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
              'READY TO BOOK YOUR PARTY?',
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact us today to check availability and reserve your spot!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 40),
            isMobile ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () => context.go('/booking'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF36122),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40, 
                      vertical: 20,
                    ),
                  ),
                  child: const Text(
                    'BOOK ONLINE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => context.go('/contact'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40, 
                      vertical: 20,
                    ),
                  ),
                  child: const Text(
                    'CONTACT US',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ):
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.go('/booking'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF36122),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40, 
                      vertical: 20,
                    ),
                  ),
                  child: const Text(
                    'BOOK ONLINE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
                      horizontal: 40, 
                      vertical: 20,
                    ),
                  ),
                  child: const Text(
                    'CONTACT US',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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