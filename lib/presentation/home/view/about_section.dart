part of 'home_screen.dart';

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: PortfolioColors.surface,
      padding: EdgeInsets.symmetric(
        vertical: context.isMobile ? 60 : 100,
        horizontal: context.isMobile ? 24 : 40,
      ),
      child: context.isMobileOrTablet
          ? const _AboutMobile()
          : const _AboutDesktop(),
    );
  }
}

class _AboutDesktop extends StatelessWidget {
  const _AboutDesktop();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 2, child: const _AboutImage()),
        const SizedBox(width: 80),
        Expanded(flex: 3, child: const _AboutContent()),
      ],
    );
  }
}

class _AboutMobile extends StatelessWidget {
  const _AboutMobile();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [_AboutImage(), SizedBox(height: 48), _AboutContent()],
    );
  }
}

class _AboutImage extends StatelessWidget {
  const _AboutImage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
              width: context.screenWidth < 360 ? 270 : 320,
              height: context.screenWidth < 360 ? 360 : 420,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [PortfolioColors.primary, Colors.orangeAccent],
                ),
              ),
            )
            .animate(
              value: context.reduceMotion ? 1 : null,
              autoPlay: !context.reduceMotion,
            )
            .fadeIn(duration: 600.ms),
        Container(
              width: context.screenWidth < 360 ? 250 : 300,
              height: context.screenWidth < 360 ? 340 : 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: AssetImage(AssetPaths.profileImage),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 40,
                    offset: const Offset(0, 25),
                  ),
                ],
              ),
            )
            .animate(
              value: context.reduceMotion ? 1 : null,
              autoPlay: !context.reduceMotion,
              delay: 300.ms,
            )
            .fadeIn(duration: 800.ms)
            .slideX(begin: -0.2),
      ],
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent();

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
              " - ABOUT ME",
              style: GoogleFonts.poppins(
                fontSize: 14,
                letterSpacing: 3,
                color: PortfolioColors.primaryDark,
                fontWeight: FontWeight.w600,
              ),
            )
            .animate(
              value: context.reduceMotion ? 1 : null,
              autoPlay: !context.reduceMotion,
            )
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.2),
        const SizedBox(height: 16),
        Text(
              "Crafting Clean & Scalable\nFlutter Experiences",
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 26 : 40,
                fontWeight: FontWeight.bold,
                color: PortfolioColors.ink,
                height: 1.2,
              ),
            )
            .animate(
              value: context.reduceMotion ? 1 : null,
              autoPlay: !context.reduceMotion,
              delay: 200.ms,
            )
            .fadeIn(duration: 800.ms)
            .slideY(begin: 0.2),
        const SizedBox(height: 24),
        ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                "I am a passionate Flutter Frontend Developer with hands-on experience in building "
                "scalable, high-performance mobile applications. My focus is on writing clean "
                "architecture-driven code, implementing efficient state management, and crafting "
                "seamless user experiences.\n\n"
                "I enjoy transforming complex business requirements into intuitive UI solutions "
                "while maintaining performance, readability, and maintainability at the core of "
                "every project.",
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 13 : 15,
                  height: 1.7,
                  color: Colors.grey[800],
                ),
              ),
            )
            .animate(
              value: context.reduceMotion ? 1 : null,
              autoPlay: !context.reduceMotion,
              delay: 400.ms,
            )
            .fadeIn(duration: 900.ms)
            .slideY(begin: 0.2),
        const SizedBox(height: 32),
        Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                _HighlightChip(value: "1.5", label: "Years Experience"),
                _HighlightChip(value: "6", label: "Projects Built"),
                _HighlightChip(value: "Clean", label: "Architecture Focus"),
              ],
            )
            .animate(
              value: context.reduceMotion ? 1 : null,
              autoPlay: !context.reduceMotion,
              delay: 600.ms,
            )
            .fadeIn(duration: 900.ms)
            .slideY(begin: 0.2),
      ],
    );
  }
}

// ── Skills ────────────────────────────────────────────────────────────────────
