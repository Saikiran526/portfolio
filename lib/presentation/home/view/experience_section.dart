part of 'home_screen.dart';

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection({required this.sectionKey});
  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Container(
      key: sectionKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 40,
        horizontal: isMobile ? 20 : 60,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF9F8F4), Color(0xFFF2F1ED)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Text(
            "EXPERIENCE",
            style: GoogleFonts.poppins(
              fontSize: 14,
              letterSpacing: 3,
              color: PortfolioColors.ink,
              fontWeight: FontWeight.w600,
            ),
          ).animate(value: context.reduceMotion ? 1 : null, autoPlay: !context.reduceMotion).fadeIn(duration: 600.ms),
          Text(
            "Professional Journey",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 28 : 42,
              fontWeight: FontWeight.w700,
              color: PortfolioColors.primaryDark,
            ),
          ).animate(value: context.reduceMotion ? 1 : null, autoPlay: !context.reduceMotion, delay: 200.ms).fadeIn(duration: 800.ms),
          const SizedBox(height: 21),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMobile) ...[
                const _TimelineIndicator(),
                const SizedBox(width: 60),
              ],
              const Expanded(child: _ExperienceCard()),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

