import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:go_router/go_router.dart';

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
      height: isMobile ? 400 : 600,
      width: double.infinity,
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
                  'images/escape.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock,
                  color: Color(0xFFF36122),
                  size: 80,
                ).animate().fadeIn(duration: 500.ms),
                const SizedBox(height: 30),
                Text(
                  'ESCAPE ROOMS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(duration: 500.ms, delay: 200.ms),
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
                ).animate().fadeIn(duration: 500.ms, delay: 400.ms),
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

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      color: const Color(0xFF121212),
      child: Column(
        children: [
          const Text(
            'OUR ESCAPE ROOMS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Choose Your Adventure',
            style: TextStyle(
              color: Color(0xFFF36122),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 50),
          isMobile
              ? Column(
                  children: rooms.map((room) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: _buildRoomCard(
                        room['title'] as String,
                        room['difficulty'] as String,
                        room['players'] as String,
                        room['description'] as String,
                        room['image'] as String,
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
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(
    String title,
    String difficulty,
    String players,
    String description,
    String imagePath,
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

    return Card(
      elevation: 10,
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  imagePath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
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
                  Text(
                    players,
                    style: const TextStyle(
                      color: Color(0xFFF36122),
                    ),
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
                    child: ElevatedButton(
                      onPressed: () => context.go('/booking'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF36122),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'BOOK THIS ROOM',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
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
    ).animate().fadeIn();
  }
} 