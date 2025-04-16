import 'package:flutter/material.dart';
import 'navbar.dart';
import 'footer.dart';

class PageLayout extends StatelessWidget {
  final String currentPath;
  final Widget child;
  final ScrollController? scrollController;
  final bool showScrollToTop;
  final Color backgroundColor;

  const PageLayout({
    super.key,
    required this.currentPath,
    required this.child,
    this.scrollController,
    this.showScrollToTop = true,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      endDrawer: NavDrawer(currentPath: currentPath),
      body: Stack(
        children: [
          Column(
            children: [
              Navbar(currentPath: currentPath),
              Expanded(
                child: _buildScrollView(context),
              ),
            ],
          ),
          if (showScrollToTop && scrollController != null)
            _buildScrollToTopButton(),
        ],
      ),
    );
  }
  
  Widget _buildScrollView(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        return false;
      },
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            RepaintBoundary(child: child),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollToTopButton() {
    return AnimatedBuilder(
      animation: scrollController!,
      builder: (context, _) {
        final showButton = scrollController!.hasClients && 
            scrollController!.position.pixels > 300;
        
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          bottom: showButton ? 20 : -60,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFFF36122),
            onPressed: () {
              if (scrollController!.hasClients) {
                scrollController!.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: const Icon(Icons.arrow_upward, color: Colors.white),
          ),
        );
      },
    );
  }
} 