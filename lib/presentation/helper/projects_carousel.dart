import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProjectsCarousel extends StatefulWidget {
  const ProjectsCarousel({super.key});

  @override
  State<ProjectsCarousel> createState() => _ProjectsCarouselState();
}

class _ProjectsCarouselState extends State<ProjectsCarousel> {
  final CarouselSliderController _carouselController =
  CarouselSliderController();

  int _currentIndex = 0;

  final List<Map<String, String>> _projects = [
    {
      "title": "TGNPDCL Employee App – Dashboard Module",
      "description":
      "Enterprise mobile dashboard providing real-time operational insights.\n\n"
          "Tech Stack: Flutter, Dart, Provider, Dio, REST APIs, Sqflite, fl_chart\n"
          "Architecture: Clean Architecture, MVVM\n\n"
          "• Developed data-driven dashboard screens\n"
          "• Integrated REST APIs using Dio\n"
          "• Implemented Sqflite caching\n"
          "• Built interactive charts\n"
          "• Optimized performance",
    },
    {
      "title": "Tailors Town – Tailor Application",
      "description":
      "Tailor-focused workflow management application.\n\n"
          "Tech Stack: Flutter, Provider, Firebase Crashlytics, REST APIs, Lottie\n"
          "Architecture: Clean Architecture, MVVM\n\n"
          "• Built application from scratch\n"
          "• Centralized navigation\n"
          "• Multipart image uploads\n"
          "• Provider-based architecture\n"
          "• Crash monitoring integration",
    },
    {
      "title": "Chaarvi Grow – Plant Disease Detection",
      "description":
      "AI-powered plant disease detection application.\n\n"
          "Tech Stack: Flutter, Firebase Auth, Dio, REST APIs\n\n"
          "• End-to-end authentication flow\n"
          "• Image capture & upload\n"
          "• Disease prediction & prevention guidance",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final isMobile = width < 700;
        final isTablet = width >= 700 && width < 1000;
        final isDesktop = width >= 1000 && width < 1400;
        final isLargeDesktop = width >= 1400;

        double viewportFraction;
        double aspectRatio;

        if (isLargeDesktop) {
          viewportFraction = 0.60;
          aspectRatio = 16 / 6.2;
        } else if (isDesktop) {
          viewportFraction = 0.70;
          aspectRatio = 16 / 7.0;
        } else if (isTablet) {
          viewportFraction = 0.85;
          aspectRatio = 16 / 8.8;
        } else {
          viewportFraction = 0.95;
          aspectRatio = 16 / 13.5; // taller on mobile so text fits better
        }

        final titleSize = isMobile
            ? 18.0
            : isTablet
            ? 22.0
            : 26.0;

        final descSize = isMobile
            ? 11.5
            : isTablet
            ? 12.8
            : 14.0;

        final sectionTitleSize = isMobile ? 12.0 : 14.0;
        final sectionHeadingSize = isMobile ? 26.0 : 40.0;

        return Column(
          children: [
            Text(
              "PROJECTS",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: sectionTitleSize,
                letterSpacing: 3,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 11),
            Text(
              "Featured Work & Case Studies",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: sectionHeadingSize,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFc9a400),
              ),
            ),
            const SizedBox(height: 30),

            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: _projects.length,
              options: CarouselOptions(
                aspectRatio: aspectRatio,
                viewportFraction: viewportFraction,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeInOut,
                enableInfiniteScroll: true,
                clipBehavior: Clip.none,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _currentIndex == index ? 1 : 0.7,
                  child: _projectCard(
                    title: _projects[index]["title"]!,
                    description: _projects[index]["description"]!,
                    isMobile: isMobile,
                    isTablet: isTablet,
                    titleFontSize: titleSize,
                    descriptionFontSize: descSize,
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            AnimatedSmoothIndicator(
              activeIndex: _currentIndex,
              count: _projects.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: Color(0xFFfbd214),
                dotColor: Color(0xFFDDDDDD),
                dotHeight: 10,
                dotWidth: 10,
                expansionFactor: 3,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _projectCard({
    required String title,
    required String description,
    required bool isMobile,
    required bool isTablet,
    required double titleFontSize,
    required double descriptionFontSize,
  }) {
    final horizontalPadding = isMobile
        ? 18.0
        : isTablet
        ? 28.0
        : 40.0;

    final verticalPadding = isMobile
        ? 22.0
        : isTablet
        ? 32.0
        : 45.0;

    final titleBottomSpacing = isMobile ? 14.0 : 28.0;
    final dividerTopSpacing = isMobile ? 18.0 : 30.0;

    final cardRadius = isMobile ? 24.0 : 32.0;
    final stripWidth = isMobile ? 5.0 : 6.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 12,
        vertical: isMobile ? 8 : 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFfbd214).withOpacity(0.22),
            blurRadius: isMobile ? 35 : 60,
            offset: const Offset(0, 25),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cardRadius),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1C1C1E),
                Color(0xFF2A2A2D),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: stripWidth,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFfbd214),
                        Color(0xFFFFA500),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 20, end: 0),
                        duration: const Duration(milliseconds: 600),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, value),
                            child: Opacity(
                              opacity: 1 - (value / 20),
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          title,
                          maxLines: isMobile ? 3 : 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: titleFontSize,
                            height: 1.2,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: titleBottomSpacing),
                      Text(
                        description,
                        style: GoogleFonts.poppins(
                          fontSize: descriptionFontSize,
                          height: isMobile ? 1.45 : 1.7,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(height: dividerTopSpacing),
                      Container(
                        height: 2,
                        width: isMobile ? 60 : 80,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFfbd214),
                              Colors.orangeAccent,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}