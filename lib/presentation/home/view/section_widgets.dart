part of 'home_screen.dart';

class _ModernButton extends StatelessWidget {
  const _ModernButton({
    required this.text,
    required this.isPrimary,
    required this.onTap,
  });

  final String text;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: isPrimary
                ? const LinearGradient(
              colors: [PortfolioColors.primary, Colors.orangeAccent],
            )
                : null,
            border: isPrimary
                ? null
                : Border.all(color: PortfolioColors.primary),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isPrimary ? Colors.black : PortfolioColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class _HighlightChip extends StatelessWidget {
  const _HighlightChip({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: PortfolioColors.cardBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: PortfolioColors.primaryDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  const _SkillCard({required this.skill});
  final _SkillItem skill;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: PortfolioColors.cardBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: PortfolioColors.primary.withValues(alpha: 0.2),
            ),
            child: Icon(skill.icon, size: 20, color: PortfolioColors.primaryDark),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  skill.title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: PortfolioColors.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  skill.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    height: 1.4,
                    color: PortfolioColors.inkMid,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(value: context.reduceMotion ? 1 : null, autoPlay: !context.reduceMotion).fadeIn(duration: 600.ms).slideY(begin: 0.1);
  }
}

class _TimelineIndicator extends StatelessWidget {
  const _TimelineIndicator();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [PortfolioColors.primary, Colors.orangeAccent],
            ),
            boxShadow: [
              BoxShadow(
                color: PortfolioColors.primary.withValues(alpha: 0.6),
                blurRadius: 20,
              ),
            ],
          ),
        ),
        Container(
          width: 3,
          height: 450,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                PortfolioColors.primary.withValues(alpha: 0.7),
                Colors.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard();

  static const _points = [
    "Developed and maintained cross-platform mobile applications using Flutter and Dart, implementing reusable UI components and modular features for production environments.",
    "Worked with Provider, BLoC, and GetX state management patterns across different application codebases based on project requirements.",
    "Applied MVVM, Clean Architecture, and MVC patterns to build scalable, modular, and maintainable Flutter applications.",
    "Integrated RESTful APIs using Dio with interceptors, token-based authentication, multipart requests, and structured backend data handling.",
    "Implemented Firebase Cloud Messaging push notifications, handling foreground, background, and terminated-state notification delivery, along with notification-based in-app navigation and deep linking.",
    "Implemented local data persistence and caching using Sqflite, SharedPreferences, and GetStorage to improve application responsiveness and reduce redundant network requests.",
    "Integrated Firebase Authentication and Firebase Crashlytics to implement secure authentication flows and monitor production application stability.",
    "Developed map-based features using Google Maps, Google Geocoding API, and OpenStreetMap for location-based application workflows.",
    "Implemented structured navigation using GoRouter and named routes to maintain scalable and predictable application navigation flows.",
    "Optimized application performance, handled dynamic data updates, and developed responsive interfaces for a consistent user experience across mobile devices.",
    "Collaborated with backend developers and designers to translate business requirements into production-ready mobile features and resolve integration issues.",
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: PortfolioColors.cardBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 40,
            offset: const Offset(0, 25),
          ),
        ],
        border: Border.all(color: Colors.grey.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Junior Frontend Developer (Flutter)",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 18 : 24,
              fontWeight: FontWeight.w700,
              color: PortfolioColors.ink,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: PortfolioColors.primary.withValues(alpha: 0.15),
                ),
                child: Text(
                  "Analogue It Solutions",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: PortfolioColors.primaryDark,
                  ),
                ),
              ),
              Text(
                "Feb 2025 – Present",
                style: GoogleFonts.poppins(
                    fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 32),
          ..._points.map((p) => _BulletPoint(text: p)),
        ],
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  const _BulletPoint({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [PortfolioColors.primary, Colors.orangeAccent],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15,
                height: 1.7,
                color: PortfolioColors.inkLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: PortfolioColors.primary),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.poppins(
                fontSize: 13, color: Colors.grey[300]),
          ),
        ),
      ],
    );
  }
}

class _FooterTextField extends StatelessWidget {
  const _FooterTextField({
    required this.hint,
    required this.controller,
    this.maxLines = 1,
    this.validator,
  });

  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: GoogleFonts.poppins(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          color: Colors.white54,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.08),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: PortfolioColors.primary, // your primary color
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: PortfolioColors.primary, // your primary color
            width: 1.5,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: PortfolioColors.primary, // your primary color
            width: 2,
          ),
        ),

        errorStyle: GoogleFonts.poppins(
          color: PortfolioColors.primary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}

// ── Data models ───────────────────────────────────────────────────────────────

class _SkillItem {
  const _SkillItem(this.title, this.description, this.icon);
  final String title;
  final String description;
  final IconData icon;
}