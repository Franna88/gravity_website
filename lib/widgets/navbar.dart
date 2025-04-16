import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Navbar extends StatelessWidget {
  final String currentPath;
  
  const Navbar({super.key, required this.currentPath});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: isMobile 
          ? _buildMobileNavbar(context) 
          : _buildDesktopNavbar(context),
      ),
    );
  }

  Widget _buildDesktopNavbar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          Row(
            children: _buildNavItems(context, false),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildMobileNavbar(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLogo(),
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Image.asset(
          'images/Gravity-Logo.png',
          height: 50,
        ),
        const SizedBox(width: 10),
        const Text(
          '',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildNavItems(BuildContext context, bool isMobile) {
    final navItems = [
      {'label': 'Home', 'path': '/'},
      {'label': 'Activities', 'path': '/activities'},
      {'label': 'Parties', 'path': '/parties'},
      {'label': 'Play Parks', 'path': '/play-parks'},
      {'label': 'Escape Rooms', 'path': '/escape-rooms'},
      {'label': 'Contact', 'path': '/contact'},
    ];

    return navItems.map((item) {
      final isActive = currentPath == item['path'];
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 0 : 15, 
          vertical: isMobile ? 15 : 0,
        ),
        child: InkWell(
          onTap: () {
            if (currentPath != item['path']) {
              context.go(item['path']!);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item['label']!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 18 : 16,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (isActive)
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 2,
                  width: 20,
                  color: const Color(0xFFF36122),
                ),
            ],
          ),
        ),
      );
    }).toList();
  }
}

class NavDrawer extends StatelessWidget {
  final String currentPath;
  
  const NavDrawer({super.key, required this.currentPath});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              alignment: Alignment.center,
              child: Image.asset(
                'images/Block-Logo.png',
                height: 80,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ...Navbar(currentPath: currentPath)._buildNavItems(context, true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 