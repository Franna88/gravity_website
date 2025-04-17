import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/page_layout.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  
  bool _isSubmitting = false;
  
  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _nameController.clear();
          _emailController.clear();
          _phoneController.clear();
          _subjectController.clear();
          _messageController.clear();
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message sent successfully!'),
            backgroundColor: Color(0xFF87C540),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    
    return PageLayout(
      currentPath: '/contact',
      scrollController: _scrollController,
      child: Column(
        children: [
          _buildHeroSection(isMobile),
          _buildContactSection(isMobile),
          _buildMapSection(isMobile),
          _buildOperatingHoursSection(isMobile),
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
                  'images/Kid-Jump.jpg',
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
                  'CONTACT US',
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

  Widget _buildContactSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            'GET IN TOUCH',
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'We\'d Love to Hear From You',
            style: TextStyle(
              color: Color(0xFFF36122),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 50),
          isMobile
              ? Column(
                  children: [
                    _buildContactForm(),
                    const SizedBox(height: 40),
                    _buildContactInfo(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: _buildContactForm(),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      flex: 5,
                      child: _buildContactInfo(),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Send Us a Message',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )
              .animate()
              .fadeIn(duration: 500.ms)
              .slideX(begin: -0.2, end: 0),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              )
              .animate()
              .fadeIn(delay: 100.ms, duration: 500.ms)
              .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 500.ms)
                    .slideY(begin: 0.2, end: 0),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 500.ms)
                    .slideY(begin: 0.2, end: 0),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.subject),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.message),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF36122),
                    foregroundColor: Colors.white,
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          'SEND MESSAGE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn();
  }

  Widget _buildContactInfo() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideX(begin: 0.2, end: 0),
            const SizedBox(height: 30),
            _buildContactItem(
              FontAwesomeIcons.locationDot,
              'Address',
              'Gravity Indoor Trampoline Park\nPort Elizabeth, South Africa',
              index: 0,
            ),
            const SizedBox(height: 20),
            _buildContactItem(
              FontAwesomeIcons.phone,
              'Phone',
              '+27 41 000 0000',
              isLink: true,
              onTap: () => _launchUrl('tel:+27410000000'),
              index: 1,
            ),
            const SizedBox(height: 20),
            _buildContactItem(
              FontAwesomeIcons.envelope,
              'Email',
              'info@gravitype.co.za',
              isLink: true,
              onTap: () => _launchUrl('mailto:info@gravitype.co.za'),
              index: 2,
            ),
            const SizedBox(height: 20),
            _buildContactItem(
              FontAwesomeIcons.globe,
              'Website',
              'www.gravitype.co.za',
              isLink: true,
              onTap: () => _launchUrl('https://gravitype.co.za'),
              index: 3,
            ),
            const SizedBox(height: 30),
            const Text(
              'Follow Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
            .animate()
            .fadeIn(delay: 800.ms)
            .slideX(begin: 0.2, end: 0),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildSocialIcon(FontAwesomeIcons.facebook, 0),
                _buildSocialIcon(FontAwesomeIcons.instagram, 1),
                _buildSocialIcon(FontAwesomeIcons.twitter, 2),
                _buildSocialIcon(FontAwesomeIcons.youtube, 3),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 300.ms);
  }
  
  Widget _buildContactItem(
    IconData icon,
    String title,
    String content, {
    bool isLink = false,
    VoidCallback? onTap,
    required int index,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFF36122),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 3),
              child: FaIcon(
                icon,
                color: const Color(0xFFF36122),
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: isLink
                  ? InkWell(
                      onTap: onTap,
                      child: Text(
                        content,
                        style: const TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  : Text(
                      content,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
            ),
          ],
        ),
      ],
    )
    .animate()
    .fadeIn(delay: Duration(milliseconds: 200 * index), duration: 500.ms)
    .slideX(begin: 0.2, end: 0);
  }

  Widget _buildSocialIcon(IconData icon, int index) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFF36122),
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        icon: FaIcon(icon, color: Colors.white, size: 18),
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
    )
    .animate()
    .fadeIn(delay: Duration(milliseconds: 400 + 150 * index))
    .slideX(begin: 0.5, end: 0);
  }

  Widget _buildMapSection(bool isMobile) {
    return Container(
      height: 400,
      width: double.infinity,
      color: Colors.grey[200],
      child: Stack(
        children: [
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1),
                BlendMode.srcOver,
              ),
              child: Image.asset(
                'images/map.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'FIND US',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideY(begin: -0.5, end: 0),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () => _launchUrl('https://maps.google.com/?q=Gravity+Indoor+Trampoline+Park'),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF36122),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.directions,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'GET DIRECTIONS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 500.ms, delay: 400.ms)
            .slideY(begin: 0.5, end: 0),
          ),
        ],
      ),
    );
  }

  Widget _buildOperatingHoursSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            'OPERATING HOURS',
            style: TextStyle(
              color: Colors.black,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          )
          .animate()
          .fadeIn(duration: 500.ms)
          .slideY(begin: 0.3, end: 0),
          const SizedBox(height: 20),
          const Text(
            'Plan Your Visit',
            style: TextStyle(
              color: Color(0xFFF36122),
              fontSize: 18,
            ),
          )
          .animate()
          .fadeIn(duration: 500.ms, delay: 200.ms)
          .slideY(begin: 0.3, end: 0),
          const SizedBox(height: 50),
          isMobile
              ? Column(
                  children: [
                    _buildHoursCard('Weekdays', '10:00 AM - 8:00 PM', 0),
                    const SizedBox(height: 20),
                    _buildHoursCard('Weekends', '9:00 AM - 10:00 PM', 1),
                    const SizedBox(height: 20),
                    _buildHoursCard('Public Holidays', '9:00 AM - 9:00 PM', 2),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: _buildHoursCard('Weekdays', '10:00 AM - 8:00 PM', 0)),
                    const SizedBox(width: 20),
                    Expanded(child: _buildHoursCard('Weekends', '9:00 AM - 10:00 PM', 1)),
                    const SizedBox(width: 20),
                    Expanded(child: _buildHoursCard('Public Holidays', '9:00 AM - 9:00 PM', 2)),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildHoursCard(String day, String hours, int index) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.access_time,
              color: Color(0xFFF36122),
              size: 40,
            ),
            const SizedBox(height: 15),
            Text(
              day,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              hours,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    )
    .animate()
    .fadeIn(delay: Duration(milliseconds: 300 * index))
    .slideY(begin: 0.3, end: 0);
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
} 