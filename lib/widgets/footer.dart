import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 50,
        vertical: 50,
      ),
      child: isMobile 
        ? _buildMobileFooter(context)
        : _buildDesktopFooter(context),
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: _buildCompanyInfo(),
            ),
            Expanded(
              flex: 2,
              child: _buildQuickLinks(context),
            ),
            Expanded(
              flex: 2,
              child: _buildContactInfo(),
            ),
          ],
        ),
        const Divider(color: Colors.white24, height: 50),
        _buildCopyright(),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCompanyInfo(),
        const SizedBox(height: 30),
        _buildQuickLinks(context),
        const SizedBox(height: 30),
        _buildContactInfo(),
        const Divider(color: Colors.white24, height: 50),
        _buildCopyright(),
      ],
    );
  }

  Widget _buildCompanyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'images/Gravity-Logo.png',
              height: 60,
            ),
            
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(right: 40),
          child: const Text(
            'Gravity Indoor Trampoline Park in Port Elizabeth has over 2000m² of pure adventure waiting for you! Trampolines, foam pits, rope course and climbing walls, basketball and more.',
            style: TextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _buildSocialIcon(FontAwesomeIcons.facebook),
            _buildSocialIcon(FontAwesomeIcons.instagram),
            _buildSocialIcon(FontAwesomeIcons.twitter),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: IconButton(
        icon: FaIcon(icon, color: Colors.white),
        onPressed: () async {
          Uri url;
          if (icon == FontAwesomeIcons.facebook) {
            url = Uri.parse('https://www.facebook.com/gravityparks');
          } else if (icon == FontAwesomeIcons.instagram) {
            url = Uri.parse('https://www.instagram.com/gravityparks');
          } else if (icon == FontAwesomeIcons.twitter) {
            url = Uri.parse('https://www.twitter.com/gravityparks');
          } else {
            url = Uri.parse('https://www.youtube.com/gravityparks');
          }
          
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          }
        },
      ),
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    final links = [
      {'label': 'Home', 'path': '/'},
      {'label': 'Activities', 'path': '/activities'},
      {'label': 'Parties', 'path': '/parties'},
      {'label': 'Play Parks', 'path': '/play-parks'},
      {'label': 'Escape Rooms', 'path': '/escape-rooms'},
      {'label': 'Contact', 'path': '/contact'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Links',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            onTap: () => context.go(link['path']!),
            child: Text(
              link['label']!,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Info',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _buildContactItem(
          FontAwesomeIcons.locationDot, 
          'Port Elizabeth, South Africa',
        ),
        _buildContactItem(
          FontAwesomeIcons.phone, 
          '+27 41 000 0000',
          isPhone: true,
        ),
        _buildContactItem(
          FontAwesomeIcons.envelope, 
          'info@gravitype.co.za',
          isEmail: true,
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text, {bool isPhone = false, bool isEmail = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () async {
          final Uri url;
          if (isPhone) {
            url = Uri.parse('tel:${text.replaceAll(' ', '')}');
          } else if (isEmail) {
            url = Uri.parse('mailto:$text');
          } else {
            return;
          }
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          }
        },
        child: Row(
          children: [
            FaIcon(icon, color: const Color(0xFFF36122), size: 16),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCopyright() {
    return Center(
      child: Text(
        '© ${DateTime.now().year} Gravity Indoor Trampoline Park. All Rights Reserved.',
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
} 