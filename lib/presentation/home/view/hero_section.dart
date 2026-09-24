part of 'home_screen.dart';

class _HeroDesktop extends StatelessWidget {
  const _HeroDesktop({required this.viewModel});
  final HomeViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1440),
      padding: EdgeInsets.symmetric(horizontal: context.isTablet ? 32 : 64),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: Image.asset(
              AssetPaths.blackBackgroundImage,
              width: 500,
              height: context.screenHeight * 0.9,
              fit: BoxFit.contain,
              cacheWidth: 780,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: _HeroText(viewModel: viewModel),
        ),
      ],
    ),
    );
  }
}

class _HeroMobile extends StatelessWidget {
  const _HeroMobile({required this.viewModel});
  final HomeViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Image.asset(
          AssetPaths.blackBackgroundImage,
          width: double.infinity,
          height: context.screenHeight * 0.42,
          fit: BoxFit.contain,
          cacheWidth: 600,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          child: _HeroText(viewModel: viewModel),
        ),
      ],
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText({required this.viewModel});
  final HomeViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hi, I'm",
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 16 : 20,
            color: Colors.grey[400],
            letterSpacing: 1.2,
          ),
        ).animate(value: context.reduceMotion ? 1 : null, autoPlay: !context.reduceMotion).fadeIn(duration: 600.ms).slideX(begin: -0.2),
        const SizedBox(height: 8),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [PortfolioColors.primary, Colors.orangeAccent],
          ).createShader(bounds),
          child: Text(
            AppConstants.nameText,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 36 : 56,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.1,
            ),
          ),
        ).animate(value: context.reduceMotion ? 1 : null, autoPlay: !context.reduceMotion, delay: 300.ms).fadeIn(duration: 800.ms).slideY(begin: 0.2),
        const SizedBox(height: 12),
        Text(
          AppConstants.frontEndDeveloperText,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 18 : 28,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ).animate(value: context.reduceMotion ? 1 : null, autoPlay: !context.reduceMotion, delay: 600.ms).fadeIn(duration: 800.ms).slideX(begin: 0.3),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            AppConstants.introText,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 13 : 15,
              height: 1.6,
              color: Colors.grey[300],
            ),
          ),
        ).animate(value: context.reduceMotion ? 1 : null, autoPlay: !context.reduceMotion, delay: 900.ms).fadeIn(duration: 900.ms).slideY(begin: 0.2),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _ModernButton(
              text: "Download CV",
              isPrimary: true,
              onTap: viewModel.downloadResume,
            ).animate(value: context.reduceMotion ? 1 : null, autoPlay: !context.reduceMotion, delay: 1200.ms).fadeIn(duration: 800.ms).slideY(begin: 0.3),
            _ModernButton(
              text: "Let's Connect",
              isPrimary: false,
              onTap : viewModel.scrollToContactSection,
            ).animate(value: context.reduceMotion ? 1 : null, autoPlay: !context.reduceMotion, delay: 1400.ms).fadeIn(duration: 800.ms).slideY(begin: 0.3),
          ],
        ),
      ],
    );
  }
}

// ── About ─────────────────────────────────────────────────────────────────────

