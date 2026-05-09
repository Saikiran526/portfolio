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

        double viewportFraction;
        double aspectRatio;

        if (width > 1400) {
          viewportFraction = 0.60; // show side cards clearly
          aspectRatio = 16 / 6;
        } else if (width > 1000) {
          viewportFraction = 0.70;
          aspectRatio = 16 / 7;
        } else if (width > 700) {
          viewportFraction = 0.85;
          aspectRatio = 16 / 8;
        } else {
          viewportFraction = 0.95; // mobile full width
          aspectRatio = 16 / 10;
        }

        return Column(
          children: [

            // SECTION TITLE
            Text(
              "PROJECTS",
              style: GoogleFonts.poppins(
                fontSize: 14,
                letterSpacing: 3,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 11),
            Text(
              "Featured Work & Case Studies",
              style: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFc9a400),
              ),
            ),
            const SizedBox(height: 30),

            // CAROUSEL
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
                autoPlayAnimationDuration:
                const Duration(milliseconds: 800),
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
                    _projects[index]["title"]!,
                    _projects[index]["description"]!,
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // SMOOTH DOT INDICATOR
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

  Widget _projectCard(String title, String description) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFfbd214).withOpacity(0.25),
            blurRadius: 60,
            offset: const Offset(0, 30),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
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

              // Accent Strip
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 6,
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 45),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      TweenAnimationBuilder(
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
                          style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      Text(
                        description,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          height: 1.8,
                          color: Colors.grey.shade300,
                        ),
                      ),

                      const SizedBox(height: 30),

                      Container(
                        height: 2,
                        width: 80,
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
