import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'project_link_stub.dart' if (dart.library.js_interop) 'project_link_web.dart' as project_links;

class ProjectsCarousel extends StatefulWidget {
  const ProjectsCarousel({super.key});

  @override
  State<ProjectsCarousel> createState() => _ProjectsCarouselState();
}

class _ProjectsCarouselState extends State<ProjectsCarousel> {
  final CarouselSliderController _carouselController =
  CarouselSliderController();

  int _currentIndex = 0;
  bool _pauseAutoPlay = false;

  void _setAutoPlayPaused(bool paused) {
    if (_pauseAutoPlay == paused) return;
    setState(() => _pauseAutoPlay = paused);
  }

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
      "appStoreUrl": "https://apps.apple.com/in/app/gazam-in/id6747278647",
      "playStoreUrl": "https://play.google.com/store/apps/details?id=com.gazam.inapp",
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
    return LayoutBuilder(builder: (context, constraints) {
      final compact = constraints.maxWidth < 640;
      final reducedMotion = MediaQuery.disableAnimationsOf(context);
      final viewportFraction = compact ? 0.94 : constraints.maxWidth < 960 ? 0.78 : 0.58;
      return Container(
        width: double.infinity,
        color: const Color(0xFF111111),
        padding: EdgeInsets.symmetric(vertical: compact ? 64 : 100),
        child: Column(children: [
          Text('SELECTED WORK', style: GoogleFonts.poppins(color: const Color(0xFFFBD214), fontWeight: FontWeight.w700, letterSpacing: 3, fontSize: 12)),
          const SizedBox(height: 10),
          Text('Projects with purpose.', textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.white, fontSize: compact ? 28 : 46, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text('Explore the work behind the screens.', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 32),
          MouseRegion(
            onEnter: (_) => _setAutoPlayPaused(true),
            onExit: (_) => _setAutoPlayPaused(false),
            child: CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: _projects.length,
            options: CarouselOptions(
              height: compact ? 420 : 420,
              viewportFraction: viewportFraction,
              enlargeCenterPage: !reducedMotion,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              enableInfiniteScroll: true,
              autoPlay: !reducedMotion && !_pauseAutoPlay,
              autoPlayInterval: const Duration(seconds: 8),
              autoPlayAnimationDuration: const Duration(milliseconds: 650),
              autoPlayCurve: Curves.easeInOutCubic,
              pauseAutoPlayOnTouch: true,
              pauseAutoPlayOnManualNavigate: true,
              onPageChanged: (index, _) => setState(() => _currentIndex = index),
            ),
            itemBuilder: (context, index, _) {
              final project = _projects[index];
              final description = project['description']!;
              final summary = description.split('\n').first;
              return Semantics(
                label: 'Project ${index + 1} of ${_projects.length}: ${project['title']}',
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  padding: EdgeInsets.all(compact ? 22 : 30),
                  decoration: BoxDecoration(
                    color: const Color(0xFF222225),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: index == _currentIndex ? const Color(0xFFFBD214) : Colors.white24),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('${(index + 1).toString().padLeft(2, '0')} / ${_projects.length.toString().padLeft(2, '0')}', style: GoogleFonts.poppins(color: const Color(0xFFFBD214), fontWeight: FontWeight.w700, letterSpacing: 2)),
                    const SizedBox(height: 18),
                    Text(project['title']!, maxLines: 3, overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(color: Colors.white, fontSize: compact ? 20 : 26, height: 1.2, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 14),
                    Expanded(child: Text(summary, maxLines: compact ? 5 : 4, overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14, height: 1.6))),
                    if (project['appStoreUrl'] != null) ...[
                      _storeLinks(project),
                      const SizedBox(height: 4),
                    ],
                    TextButton.icon(
                      onPressed: () => _showProject(context, project),
                      iconAlignment: IconAlignment.end,
                      icon: const Icon(Icons.arrow_forward, size: 18),
                      label: const Text('Read case study'),
                      style: TextButton.styleFrom(foregroundColor: const Color(0xFFFBD214), minimumSize: const Size(0, 48)),
                    ),
                  ]),
                ),
              );
            },
            ),
          ),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(tooltip: 'Previous project', onPressed: () => _carouselController.previousPage(), color: const Color(0xFFFBD214), icon: const Icon(Icons.arrow_back)),
            const SizedBox(width: 12),
            Text('${_currentIndex + 1} / ${_projects.length}', style: GoogleFonts.poppins(color: Colors.white70)),
            const SizedBox(width: 12),
            IconButton(tooltip: 'Next project', onPressed: () => _carouselController.nextPage(), color: const Color(0xFFFBD214), icon: const Icon(Icons.arrow_forward)),
          ]),
        ]),
      );
    });
  }

  Widget _storeLinks(Map<String, String> project) {
    return Wrap(
      spacing: 12,
      runSpacing: 4,
      children: [
        TextButton.icon(
          onPressed: () => project_links.openProjectLink(project['appStoreUrl']!),
          icon: const Icon(Icons.open_in_new, size: 16),
          label: const Text('App Store'),
          style: TextButton.styleFrom(foregroundColor: const Color(0xFFFBD214), minimumSize: const Size(0, 44)),
        ),
        TextButton.icon(
          onPressed: () => project_links.openProjectLink(project['playStoreUrl']!),
          icon: const Icon(Icons.open_in_new, size: 16),
          label: const Text('Google Play'),
          style: TextButton.styleFrom(foregroundColor: const Color(0xFFFBD214), minimumSize: const Size(0, 44)),
        ),
      ],
    );
  }

  Future<void> _showProject(BuildContext context, Map<String, String> project) async {
    _setAutoPlayPaused(true);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1C1C1E),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => SafeArea(
        child: FractionallySizedBox(
          heightFactor: 0.85,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(alignment: Alignment.centerRight, child: IconButton(tooltip: 'Close case study', onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.white))),
              Text(project['title']!, style: GoogleFonts.poppins(color: const Color(0xFFFBD214), fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 20),
              Expanded(child: SingleChildScrollView(child: SelectableText(project['description']!, style: GoogleFonts.poppins(color: Colors.white, height: 1.7, fontSize: 15)))),
              if (project['appStoreUrl'] != null) _storeLinks(project),
            ]),
          ),
        ),
      ),
    );
    if (mounted) _setAutoPlayPaused(false);
  }
}
