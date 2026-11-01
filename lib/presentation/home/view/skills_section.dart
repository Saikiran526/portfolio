part of 'home_screen.dart';

class _SkillsSection extends StatelessWidget {
  const _SkillsSection({required this.sectionKey});
  final GlobalKey sectionKey;

  static const _skills = [
    _SkillItem("Programming Languages", "Dart, Java", Icons.code),
    _SkillItem(
      "Frameworks & SDKs",
      "Flutter, Agora RTC SDK",
      Icons.phone_android,
    ),
    _SkillItem("State Management", "Provider, BLoC, GetX", Icons.sync_alt),
    _SkillItem(
      "Architecture",
      "MVVM, Clean Architecture, MVC",
      Icons.architecture,
    ),
    _SkillItem(
      "API Integration",
      "RESTful APIs, JSON, Dio, Interceptors, Multipart Requests, Token-based Authentication",
      Icons.cloud_done,
    ),
    _SkillItem(
      "Firebase",
      "Firebase Authentication, Firebase Cloud Messaging (Push Notifications), Firebase Crashlytics",
      Icons.local_fire_department,
    ),
    _SkillItem(
      "Push Notifications",
      "Foreground, Background & Terminated-state Notification Handling, Notification-based Navigation/Deep Linking",
      Icons.notifications_active,
    ),
    _SkillItem(
      "Databases & Local Storage",
      "SQLite (Sqflite), SharedPreferences, GetStorage",
      Icons.storage,
    ),
    _SkillItem("Navigation", "GoRouter, Named Routes", Icons.navigation),
    _SkillItem(
      "Maps & Location",
      "Google Maps, Google Geocoding API, OpenStreetMap",
      Icons.location_on,
    ),
    _SkillItem(
      "Data Visualization",
      "fl_chart (Line, Bar, Pie Charts)",
      Icons.bar_chart,
    ),
    _SkillItem(
      "UI & Animation",
      "Responsive UI, Reusable Components, Lottie",
      Icons.animation,
    ),
    _SkillItem(
      "Real-Time Communication",
      "Agora RTC, Video Calling, Voice Calling",
      Icons.video_call,
    ),
    _SkillItem("Version Control", "Git and Github", Icons.merge_type),
    _SkillItem(
      "Tools & Platforms",
      "Postman, Android Studio, VS Code",
      Icons.build,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width < 600
        ? 1
        : width < 900
        ? 2
        : width < 1300
        ? 3
        : 4;

    return Container(
      key: sectionKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile
            ? 20
            : context.isTablet
            ? 32
            : 60,
      ),
      child: Column(
        children: [
          Text(
                "SKILLS",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  letterSpacing: 3,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              )
              .animate(
                value: context.reduceMotion ? 1 : null,
                autoPlay: !context.reduceMotion,
              )
              .fadeIn(duration: 600.ms),
          const SizedBox(height: 11),
          Text(
                "Technical Expertise & Tools",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 26 : 40,
                  fontWeight: FontWeight.w700,
                  color: PortfolioColors.primaryDark,
                ),
              )
              .animate(
                value: context.reduceMotion ? 1 : null,
                autoPlay: !context.reduceMotion,
                delay: 200.ms,
              )
              .fadeIn(duration: 800.ms),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              mainAxisExtent: width < Breakpoints.mobile ? 174 : 146,
            ),
            itemCount: _skills.length,
            itemBuilder: (_, i) => _SkillCard(skill: _skills[i]),
          ),
        ],
      ),
    );
  }
}

// ── Experience ────────────────────────────────────────────────────────────────
