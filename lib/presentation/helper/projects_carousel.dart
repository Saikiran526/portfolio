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
      "title": "Annadatha – Agricultural Services Mobile Application",
      "description":
      "Mobile application focused on providing digital services for farmers, including agricultural product purchasing and equipment rental workflows.\n\n"
          "Tech Stack: Flutter, Dart, BLoC, Dio, GoRouter, OpenStreetMap\n"
          "Status: Ongoing Development\n\n"
          "• Contributing to the development of the Annadatha mobile application from scratch, implementing assigned modules and farmer-focused user workflows.\n"
          "• Implemented BLoC-based state management to provide predictable and scalable state handling across application features.\n"
          "• Integrated RESTful APIs using Dio for product, service, and equipment rental workflows, including structured backend data handling.\n"
          "• Implemented structured navigation and route management using GoRouter for maintainable application navigation.\n"
          "• Integrated OpenStreetMap to support map-based functionality and location interactions within the application.\n"
          "• Developed user-facing workflows related to agricultural services, seed purchasing, and equipment rental functionality.",
    },
    {
      "title": "Gazam – Real Estate Mobile Application",
      "description":
      "Real-estate mobile application focused on property discovery, search, location-based exploration, and personalized property experiences.\n\n"
          "Tech Stack: Flutter, Dart, GetX, Dio, Firebase Cloud Messaging, GetStorage, SharedPreferences, Google Maps, Google Geocoding API, REST APIs\n"
          "Architecture: MVC\n\n"
          "• Developed and maintained multiple modules of the Gazam real-estate mobile application using Flutter and Dart.\n"
          "• Implemented property listing, search, and location-based property discovery workflows for exploring available properties.\n"
          "• Integrated Google Maps with custom property markers, interactive map controls, and marker-based property detail views.\n"
          "• Integrated Google Geocoding API to support city and locality selection and location-based property search functionality.\n"
          "• Implemented push notifications using Firebase Cloud Messaging, handling notification delivery and click events across foreground, background, and terminated app states.\n"
          "• Built notification-based navigation to route users directly to the relevant property or screen from foreground, background, and terminated-state notification taps.\n"
          "• Implemented app-tour and onboarding flows to guide new users through key application features.\n"
          "• Implemented application state management and centralized navigation using GetX.\n"
          "• Used GetStorage and SharedPreferences for local persistence, user preferences, and application state management.\n"
          "• Integrated RESTful APIs using Dio and handled dynamic property data and backend-driven application workflows.",
    },
    {
      "title": "TGNPDCL Employee App – Dashboard Module",
      "description":
      "Enterprise mobile dashboard module providing real-time operational insights to employees.\n\n"
          "Tech Stack: Flutter, Dart, Provider, Dio, REST APIs, Sqflite, fl_chart\n"
          "Scale: 58+ screens, 80+ API integrations\n"
          "Architecture: Clean Architecture, MVVM\n\n"
          "• Developed data-driven dashboard screens and reusable Flutter UI components for an enterprise employee application.\n"
          "• Integrated 80+ RESTful API endpoints using Dio with Provider-based state management.\n"
          "• Implemented local data caching using Sqflite to store frequently accessed data, reduce redundant API calls, and improve screen load performance.\n"
          "• Designed and implemented interactive data visualizations using fl_chart, including line, bar, and pie charts for presenting operational insights.\n"
          "• Implemented dynamic data updates and optimized UI rendering to provide a smooth and responsive user experience.",
    },
    {
      "title": "Tailors Town – Tailor Application",
      "description":
      "Tailor-focused mobile application for managing orders, customers, and tailoring workflows as part of a dual-app platform.\n\n"
          "Tech Stack: Flutter, Dart, Provider, Dio, Firebase Crashlytics, REST APIs, Lottie\n"
          "Architecture: Clean Architecture, MVVM\n\n"
          "• Developed the tailor-side application from scratch, owning the complete application flow from initialization to production-ready features.\n"
          "• Implemented centralized navigation using named routes to maintain a clean and scalable navigation flow.\n"
          "• Integrated RESTful APIs using Dio, including multipart requests for store registration and logo image uploads.\n"
          "• Implemented Provider-based state management to support modular and maintainable feature development.\n"
          "• Integrated Lottie animations for loading states and enhanced user experience across application workflows.\n"
          "• Integrated Firebase Crashlytics for crash monitoring, runtime issue analysis, and application stability improvements.",
    },
    {
      "title": "Chaarvi Grow – Plant Disease Detection Application",
      "description":
      "Mobile application that detects plant diseases using image analysis via backend services.\n\n"
          "Tech Stack: Flutter, Dart, Firebase Authentication, Dio, REST APIs\n\n"
          "• Implemented the end-to-end authentication flow, including application launch logic, login, and navigation to the authenticated home screen.\n"
          "• Integrated image capture and image upload workflows using backend APIs for plant disease analysis.\n"
          "• Processed and displayed backend-generated disease predictions, severity levels, and prevention guidance through responsive Flutter interfaces.",
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