import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math' as math;
import 'package:visibility_detector/visibility_detector.dart';

import '../widgets/page_layout.dart';

class EscapeRoomsScreen extends StatefulWidget {
  const EscapeRoomsScreen({super.key});

  @override
  State<EscapeRoomsScreen> createState() => _EscapeRoomsScreenState();
}

class _EscapeRoomsScreenState extends State<EscapeRoomsScreen> {
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
      currentPath: '/escape-rooms',
      scrollController: _scrollController,
      backgroundColor: Colors.black,
      child: Column(
        children: [
          _buildHeroSection(isMobile),
          _buildIntroSection(isMobile),
          _buildRoomsSection(isMobile),
        ],
      ),
    );
  }

  Widget _buildHeroSection(bool isMobile) {
    return Container(
      height: isMobile ? 500 : 700,
      width: double.infinity,
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
                'images/escape.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Overlay gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),
          
          // Simple animated dots
          _buildAnimatedDots(isMobile),
          
          // Main content centered properly
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Escape Keyhole Effect
                Container(
                  width: isMobile ? 180 : 250,
                  height: isMobile ? 180 : 250,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFF36122),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF36122).withOpacity(0.5),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.lock,
                          color: const Color(0xFFF36122),
                          size: isMobile ? 80 : 120,
                        )
                        .animate(onPlay: (controller) => controller.repeat(reverse: true))
                        .rotate(
                          begin: -0.05,
                          end: 0.05,
                          duration: 2000.ms,
                        ),
                      ],
                    ),
                  ),
                )
                .animate()
                .scale(begin: const Offset(0, 0), end: const Offset(1, 1), duration: 800.ms)
                .then()
                .shimmer(delay: 500.ms, duration: 1800.ms),
                
                const SizedBox(height: 40),
                
                SizedBox(
                  width: isMobile ? 300 : 450,
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 32 : 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'ESCAPE ROOMS',
                          speed: const Duration(milliseconds: 150),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      isRepeatingAnimation: false,
                      totalRepeatCount: 1,
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                Container(
                  constraints: BoxConstraints(
                    maxWidth: isMobile ? 300 : 600,
                  ),
                  child: const Text(
                    'Can you escape in time?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 24,
                    ),
                  ),
                )
                .animate()
                .fadeIn(delay: 1000.ms, duration: 800.ms)
                .moveY(begin: 30, end: 0),
                
                const SizedBox(height: 40),
                
                // Custom countdown timer animation that better fits the theme
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        border: Border.all(
                          color: const Color(0xFFF36122),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 30,
                            color: const Color(0xFFF36122),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "60:00",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Courier',
                            ),
                          ),
                        ],
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .tint(
                      color: const Color(0xFFF36122).withOpacity(0.3),
                      duration: 1000.ms,
                    ),
                  ],
                )
                .animate()
                .fadeIn(delay: 1200.ms),
                
                const SizedBox(height: 40),
                
                // Call to action button
                ElevatedButton(
                  onPressed: () => context.go('/book-jump'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF36122),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 30 : 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                    shadowColor: const Color(0xFFF36122).withOpacity(0.5),
                  ),
                  child: const Text(
                    'BOOK YOUR ESCAPE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                .animate()
                .fadeIn(delay: 1500.ms)
                .moveY(begin: 30, end: 0),
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
      color: Colors.black,
      child: Column(
        children: [
          const Text(
            'THE ULTIMATE ESCAPE EXPERIENCE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            constraints: BoxConstraints(
              maxWidth: isMobile ? double.infinity : 800,
            ),
            child: const Text(
              'Gravity\'s Escape Rooms offer immersive, mind-bending experiences that will test your problem-solving skills, teamwork, and creativity. With multiple themed rooms of varying difficulty levels, there\'s a challenge waiting for everyone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 50),
          ResponsiveBreakpoints.of(context).smallerThan(TABLET)
          ? Column(
              children: [
                _buildStatItem('4+', 'Unique Rooms'),
                const SizedBox(height: 30),
                _buildStatItem('60', 'Minutes to Escape'),
                const SizedBox(height: 30),
                _buildStatItem('30%', 'Escape Rate'),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatItem('4+', 'Unique Rooms'),
                const SizedBox(width: 50),
                _buildStatItem('60', 'Minutes to Escape'),
                const SizedBox(width: 50),
                _buildStatItem('30%', 'Escape Rate'),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFFF36122),
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    ).animate().fadeIn();
  }

  Widget _buildRoomsSection(bool isMobile) {
    final rooms = [
      // {
      //   'title': 'Haunted Hospital',
      //   'difficulty': 'Difficult',
      //   'players': '2-6 Players',
      //   'description': 'You\'ve been trapped in an abandoned hospital with a dark past. Find the cure and escape before time runs out.',
      //   'image': 'images/Placeholder_view.png',
      // },
      {
        'title': 'Bank Heist',
        'difficulty': 'Medium',
        'players': '2-8 Players',
        'description': 'Plan the perfect heist as you break into the most secure bank vault in the city. Can you crack the code?',
        'image': 'images/bank.jpg',
      },
      {
        'title': 'Jumanji Adventure',
        'difficulty': 'Easy',
        'players': '2-8 Players',
        'description': 'You\'ve discovered an ancient temple deep in the jungle. Solve the puzzles to find the treasure and escape.',
        'image': 'images/jumanji.jpg',
      },
      // {
      //   'title': 'Space Station Crisis',
      //   'difficulty': 'Expert',
      //   'players': '4-8 Players',
      //   'description': 'Your space station is losing oxygen fast. Work together to fix the systems and return safely to Earth.',
      //   'image': 'images/Placeholder_view.png',
      // },
    ];

    return VisibilityDetector(
      key: const Key('rooms-section'),
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
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          image: DecorationImage(
            image: const AssetImage('images/pattern.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.95),
              BlendMode.srcOver,
            ),
            opacity: 0.1,
          ),
        ),
        child: Column(
          children: [
            const Text(
              'OUR ESCAPE ROOMS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms)
            .moveY(begin: 30, end: 0),
            const SizedBox(height: 20),
            const Text(
              'Choose Your Adventure',
              style: TextStyle(
                color: Color(0xFFF36122),
                fontSize: 18,
              ),
            )
            .animate()
            .fadeIn(delay: 200.ms)
            .moveY(begin: 20, end: 0),
            const SizedBox(height: 50),
            isMobile
                ? Column(
                    children: rooms.asMap().entries.map((entry) {
                      final index = entry.key;
                      final room = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: _buildRoomCard(
                          room['title'] as String,
                          room['difficulty'] as String,
                          room['players'] as String,
                          room['description'] as String,
                          room['image'] as String,
                          index,
                        ),
                      );
                    }).toList(),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                    ),
                    itemCount: rooms.length,
                    itemBuilder: (context, index) {
                      return _buildRoomCard(
                        rooms[index]['title'] as String,
                        rooms[index]['difficulty'] as String,
                        rooms[index]['players'] as String,
                        rooms[index]['description'] as String,
                        rooms[index]['image'] as String,
                        index,
                      );
                    },
                  ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () => context.go('/book-jump'),
              icon: const Icon(Icons.lock_open),
              label: const Text(
                'SEE ALL ESCAPE ROOMS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E1E1E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                elevation: 8,
                shadowColor: const Color(0xFFF36122).withOpacity(0.3),
              ),
            )
            .animate()
            .fadeIn(delay: 600.ms)
            .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0)),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomCard(
    String title,
    String difficulty,
    String players,
    String description,
    String imagePath,
    int index,
  ) {
    Color difficultyColor;
    switch (difficulty.toLowerCase()) {
      case 'easy':
        difficultyColor = Colors.green;
        break;
      case 'medium':
        difficultyColor = Colors.orange;
        break;
      case 'difficult':
        difficultyColor = Colors.red;
        break;
      case 'expert':
        difficultyColor = Colors.purple;
        break;
      default:
        difficultyColor = Colors.blue;
    }
    
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
              transform: isHovered ? (Matrix4.identity()..scale(1.03)) : Matrix4.identity(),
              child: Card(
                elevation: isHovered ? 16 : 10,
                color: const Color(0xFF1E1E1E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: isHovered 
                      ? const Color(0xFFF36122) 
                      : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          // Image with zoom effect on hover
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            height: 200,
                            width: double.infinity,
                            child: Image.asset(
                              imagePath,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              // Add a scale effect on hover
                              scale: isHovered ? 1.1 : 1.0,
                            ),
                          ),
                          
                          // Dark overlay on hover
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: isHovered ? 0.4 : 0,
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              color: Colors.black,
                              child: Center(
                                child: Text(
                                  'View Details',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          Positioned(
                            top: 15,
                            right: 15,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: difficultyColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: difficultyColor.withOpacity(0.5),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Text(
                                difficulty,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.people,
                                  color: Color(0xFFF36122),
                                  size: 16,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  players,
                                  style: const TextStyle(
                                    color: Color(0xFFF36122),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              description,
                              style: const TextStyle(
                                color: Colors.white70,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: isHovered 
                                      ? [const Color(0xFFF36122), Color.lerp(const Color(0xFFF36122), Colors.yellow, 0.3)!] 
                                      : [const Color(0xFFF36122), const Color(0xFFF36122)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: isHovered 
                                    ? [
                                        BoxShadow(
                                          color: const Color(0xFFF36122).withOpacity(0.4),
                                          blurRadius: 12,
                                          offset: const Offset(0, 6),
                                        )
                                      ] 
                                    : [],
                                ),
                                child: ElevatedButton(
                                  onPressed: () => context.go('/book-jump'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.white,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'BOOK THIS ROOM',
                                        style: TextStyle(
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
                                        child: const Icon(Icons.arrow_forward, size: 16),
                                      ),
                                    ],
                                  ),
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
            ),
          );
        },
      ),
    )
    .animate()
    .fadeIn(delay: Duration(milliseconds: 300 * index))
    .slideY(begin: 0.3, end: 0);
  }

  Widget _buildAnimatedDots(bool isMobile) {
    // Create animated elements for escape room theme
    return Positioned.fill(
      child: Stack(
        children: [
          // Mystery elements scattered throughout
          ...List.generate(15, (index) {
            final random = math.Random();
            final x = random.nextDouble() * MediaQuery.of(context).size.width;
            final y = random.nextDouble() * (isMobile ? 500 : 700);
            final type = random.nextInt(3); // 0 = keyhole, 1 = dot, 2 = mini lock
            final size = type == 1 
              ? 3.0 + random.nextDouble() * 3.0
              : 8.0 + random.nextDouble() * 12.0;
            
            return Positioned(
              left: x,
              top: y,
              child: type == 0
                ? Icon(
                    Icons.vpn_key,
                    size: size,
                    color: Colors.white.withOpacity(0.2 + random.nextDouble() * 0.1),
                  )
                  .animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .rotate(
                    begin: -0.1,
                    end: 0.1,
                    duration: Duration(milliseconds: 2000 + random.nextInt(2000)),
                  )
                  .then()
                  .shimmer(delay: Duration(milliseconds: random.nextInt(3000)), duration: 1800.ms)
                : type == 1
                  ? Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2 + random.nextDouble() * 0.1),
                        shape: BoxShape.circle,
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .scale(
                      begin: const Offset(0.5, 0.5), 
                      end: const Offset(1.5, 1.5),
                      duration: Duration(milliseconds: 2000 + random.nextInt(2000)),
                    )
                    .then()
                    .scale(
                      begin: const Offset(1.5, 1.5), 
                      end: const Offset(0.5, 0.5),
                      duration: Duration(milliseconds: 2000 + random.nextInt(2000)),
                    )
                  : Icon(
                      Icons.lock,
                      size: size,
                      color: const Color(0xFFF36122).withOpacity(0.1 + random.nextDouble() * 0.1),
                    )
                    .animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .shimmer(delay: Duration(milliseconds: random.nextInt(4000)), duration: 2000.ms),
            );
          }),
          
          // Mysterious numerals that fade in and out
          ...List.generate(8, (index) {
            final random = math.Random();
            final x = random.nextDouble() * MediaQuery.of(context).size.width;
            final y = random.nextDouble() * (isMobile ? 500 : 700);
            final digit = random.nextInt(10).toString();
            
            return Positioned(
              left: x,
              top: y,
              child: Text(
                digit,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.15),
                  fontSize: 14.0 + random.nextDouble() * 10.0,
                  fontFamily: 'Courier',
                  fontWeight: FontWeight.bold,
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .fadeIn(duration: Duration(milliseconds: 1000 + random.nextInt(2000)))
              .then()
              .fadeOut(duration: Duration(milliseconds: 1000 + random.nextInt(2000))),
            );
          }),
        ],
      ),
    );
  }
  
  Widget _buildDot(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    ).animate(onPlay: (controller) => controller.repeat())
      .scale(
        begin: const Offset(0.5, 0.5), 
        end: const Offset(1.5, 1.5),
        duration: 1200.ms,
      )
      .then()
      .scale(
        begin: const Offset(1.5, 1.5), 
        end: const Offset(0.5, 0.5),
        duration: 1200.ms,
      );
  }
} 