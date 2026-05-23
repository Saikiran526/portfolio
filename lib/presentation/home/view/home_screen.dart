import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/constants/asset_paths.dart';
import 'package:portfolio/presentation/helper/app_widgets.dart';
import 'package:portfolio/presentation/helper/projects_carousel.dart';
import 'package:portfolio/presentation/home/animations/skill_orbit_animation.dart';
import 'package:portfolio/presentation/home/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ── Breakpoints ───────────────────────────────────────────────────────────────

abstract class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  bool get isMobile => screenWidth < Breakpoints.mobile;
  bool get isTablet =>
      screenWidth >= Breakpoints.mobile && screenWidth < Breakpoints.tablet;
  bool get isDesktop => screenWidth >= Breakpoints.tablet;
  bool get isMobileOrTablet => screenWidth < Breakpoints.tablet;
}

// Design tokens

abstract class _Colors {
  static const primary = Color(0xFFfbd214);
  static const primaryDark = Color(0xFFc9a400);
  static const ink = Color(0xFF111111);
  static const inkLight = Color(0xFF444444);
  static const inkMid = Color(0xFF555555);
  static const surface = Color(0xFFF7F6F2);
  static const cardBg = Colors.white;
  static const footerBg1 = Color(0xFF0F0F10);
  static const footerBg2 = Color(0xFF1C1C1E);
  static const inputBg = Color(0xFF2A2A2D);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ChangeNotifierProvider(
        create: (_) => HomeViewmodel(),
        child: Consumer<HomeViewmodel>(
          builder: (context, viewModel, _) => Stack(
            children: [
              _MainContent(viewModel: viewModel),
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: _FloatingNavbar(viewModel: viewModel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Main scrollable content
class _MainContent extends StatelessWidget {
  const _MainContent({required this.viewModel});
  final HomeViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;

    return SingleChildScrollView(
      controller: viewModel.scrollController,
      // RepaintBoundary prevents scroll jank by isolating the scroll from
      // parent layers.
      child: RepaintBoundary(
        child: Stack(
          children: [
            // Orbit animation — desktop/tablet only, positioned absolutely
            if (context.isDesktop)
              const Positioned(
                right: -80,
                top: -80,
                child: SkillOrbitAnimation(),
              ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero
                verticalSpacing(customHeight: h * 0.08),
                Container(
                  key: viewModel.homeKey,
                  child: context.isMobile
                      ? _HeroMobile(viewModel: viewModel)
                      : _HeroDesktop(viewModel: viewModel),
                ),
                verticalSpacing(customHeight: h * 0.05),

                // ── About ─────────────────────────────────────────r────────
                _AboutSection(),
                verticalSpacing(customHeight: h * 0.02),

                // ── Skills ────────────────────────────────────────────────
                _SkillsSection(sectionKey: viewModel.skillsKey),

                // ── Experience ────────────────────────────────────────────
                _ExperienceSection(sectionKey: viewModel.experienceKey)
                    .animate()
                    .fadeIn(duration: 900.ms)
                    .slideY(begin: 0.2),
                verticalSpacing(customHeight: h * 0.02),

                // ── Projects ──────────────────────────────────────────────
                Container(
                  key: viewModel.projectsKey,
                  child: const ProjectsCarousel(),
                ),
                verticalSpacing(customHeight: h * 0.02),

                // ── Footer ────────────────────────────────────────────────
                _FooterSection(viewModel: viewModel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Hero ──────────────────────────────────────────────────────────────────────

class _HeroDesktop extends StatelessWidget {
  const _HeroDesktop({required this.viewModel});
  final HomeViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: Image.asset(
              AssetPaths.blackBackgroundImage,
              width: 500,
              height: context.screenHeight * 0.9,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: _HeroText(viewModel: viewModel),
        ),
      ],
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
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
        const SizedBox(height: 8),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [_Colors.primary, Colors.orangeAccent],
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
        ).animate(delay: 300.ms).fadeIn(duration: 800.ms).slideY(begin: 0.2),
        const SizedBox(height: 12),
        Text(
          AppConstants.frontEndDeveloperText,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 18 : 28,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ).animate(delay: 600.ms).fadeIn(duration: 800.ms).slideX(begin: 0.3),
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
        ).animate(delay: 900.ms).fadeIn(duration: 900.ms).slideY(begin: 0.2),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _ModernButton(
              text: "Download CV",
              isPrimary: true,
              onTap: viewModel.downloadResume,
            ).animate(delay: 1200.ms).fadeIn(duration: 800.ms).slideY(begin: 0.3),
            _ModernButton(
              text: "Let's Connect",
              isPrimary: false,
              onTap: () {},
            ).animate(delay: 1400.ms).fadeIn(duration: 800.ms).slideY(begin: 0.3),
          ],
        ),
      ],
    );
  }
}

// ── About ─────────────────────────────────────────────────────────────────────

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: _Colors.surface,
      padding: EdgeInsets.symmetric(
        vertical: context.isMobile ? 60 : 100,
        horizontal: context.isMobile ? 24 : 40,
      ),
      child: context.isMobile ? _AboutMobile() : _AboutDesktop(),
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
      children: [
        _AboutImage(),
        SizedBox(height: 48),
        _AboutContent(),
      ],
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
          width: 320,
          height: 420,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [_Colors.primary, Colors.orangeAccent],
            ),
          ),
        ).animate().fadeIn(duration: 600.ms),
        Container(
          width: 300,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: const DecorationImage(
              image: AssetImage(AssetPaths.profileImage),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 40,
                offset: const Offset(0, 25),
              ),
            ],
          ),
        ).animate(delay: 300.ms).fadeIn(duration: 800.ms).slideX(begin: -0.2),
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
            color: _Colors.primaryDark,
            fontWeight: FontWeight.w600,
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
        const SizedBox(height: 16),
        Text(
          "Crafting Clean & Scalable\nFlutter Experiences",
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 26 : 40,
            fontWeight: FontWeight.bold,
            color: _Colors.ink,
            height: 1.2,
          ),
        ).animate(delay: 200.ms).fadeIn(duration: 800.ms).slideY(begin: 0.2),
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
        ).animate(delay: 400.ms).fadeIn(duration: 900.ms).slideY(begin: 0.2),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _HighlightChip(value: "1+", label: "Years Experience"),
            _HighlightChip(value: "5+", label: "Projects Built"),
            _HighlightChip(value: "Clean", label: "Architecture Focus"),
          ],
        ).animate(delay: 600.ms).fadeIn(duration: 900.ms).slideY(begin: 0.2),
      ],
    );
  }
}

// ── Skills ────────────────────────────────────────────────────────────────────

class _SkillsSection extends StatelessWidget {
  const _SkillsSection({required this.sectionKey});
  final GlobalKey sectionKey;

  static const _skills = [
    _SkillItem("Programming Languages", "Dart • Java • JavaScript • ReactJS • HTML • CSS", Icons.code),
    _SkillItem("Frameworks & SDKs", "Flutter", Icons.phone_android),
    _SkillItem("State Management", "Provider", Icons.sync_alt),
    _SkillItem("Architecture", "MVVM", Icons.architecture),
    _SkillItem("API Integration", "RESTful APIs • JSON • Dio", Icons.cloud_done),
    _SkillItem("Databases & Storage", "SQLite (Sqflite) • Firebase", Icons.storage),
    _SkillItem("Version Control", "Git", Icons.merge_type),
    _SkillItem("Tools & Platforms", "Postman • Android Studio • VS Code", Icons.build),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Container(
      key: sectionKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 20 : 60,
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
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 11),
          Text(
            "Technical Expertise & Tools",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 26 : 40,
              fontWeight: FontWeight.w700,
              color: _Colors.primaryDark,
            ),
          ).animate(delay: 200.ms).fadeIn(duration: 800.ms),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: isMobile ? 360 : 320,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: isMobile ? 2.2 : 1.6,
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
              color: _Colors.ink,
              fontWeight: FontWeight.w600,
            ),
          ).animate().fadeIn(duration: 600.ms),
          Text(
            "Professional Journey",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 28 : 42,
              fontWeight: FontWeight.w700,
              color: _Colors.primaryDark,
            ),
          ).animate(delay: 200.ms).fadeIn(duration: 800.ms),
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

class _FooterSection extends StatelessWidget {
  const _FooterSection({required this.viewModel});
  final HomeViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobileOrTablet;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isMobile ? 24 : 80,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_Colors.footerBg1, _Colors.footerBg2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          isMobile
              ? Column(
            children: [
              const _FooterLeft(),
              const SizedBox(height: 60),
              _FooterRight(viewModel: viewModel),
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(child: _FooterLeft()),
              const SizedBox(width: 80),
              Expanded(child: _FooterRight(viewModel: viewModel)),
            ],
          ),
          const SizedBox(height: 80),
          Divider(color: Colors.white.withOpacity(0.1)),
          const SizedBox(height: 20),
          Text(
            "© 2026 ${AppConstants.nameText}. All rights reserved.",
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2);
  }
}

class _FooterLeft extends StatelessWidget {
  const _FooterLeft();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [_Colors.primary, Colors.orangeAccent],
          ).createShader(b),
          child: Text(
            AppConstants.nameText,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Flutter Frontend Developer\nCrafting scalable & elegant mobile experiences.",
          style: GoogleFonts.poppins(
            fontSize: 14,
            height: 1.7,
            color: Colors.grey[400],
          ),
        ),
        const SizedBox(height: 30),
        _ContactRow(icon: Icons.email, text: "saikiranlingampally26@gmail.com"),
        const SizedBox(height: 15),
        _ContactRow(icon: Icons.phone, text: "+91 9515916989"),
      ],
    );
  }
}

class _FooterRight extends StatelessWidget {
  const _FooterRight({required this.viewModel});
  final HomeViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's Connect",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 30),
        _FooterTextField(hint: "Your Name", controller: viewModel.nameController),
        const SizedBox(height: 20),
        _FooterTextField(hint: "Your Email", controller: viewModel.emailController),
        const SizedBox(height: 20),
        _FooterTextField(
          hint: "Your Message",
          controller: viewModel.messageController,
          maxLines: 4,
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: _Colors.primary,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () async {
              final sent = await viewModel.sendMessage();
              if (!context.mounted) return;
              showTopSnackBar(
                Overlay.of(context),
                sent
                    ? const CustomSnackBar.success(
                    message: "Message sent successfully")
                    : const CustomSnackBar.error(
                    message: "Message not sent. Try again!"),
              );
            },
            child: Text(
              "Send Message",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

// Floating Navbar

class _FloatingNavbar extends StatelessWidget {
  const _FloatingNavbar({required this.viewModel});
  final HomeViewmodel viewModel;

  static const _items = [
    ('Home', 'home'),
    ('Skills', 'skills'),
    ('Experience', 'experience'),
    ('Projects', 'projects'),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 40,
              vertical: isMobile ? 12 : 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white.withOpacity(0.08),
              border: Border.all(
                width: 1.2,
                color: Colors.white.withOpacity(0.15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _items
                  .map((e) => _NavItem(
                label: e.$1,
                key_: e.$2,
                viewModel: viewModel,
                isMobile: isMobile,
              ))
                  .toList(),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3);
  }
}

// Reusable leaf widgets

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.key_,
    required this.viewModel,
    required this.isMobile,
  });

  final String label;
  final String key_;
  final HomeViewmodel viewModel;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final isActive = viewModel.activeMenuItem == key_;
    final isHovered = viewModel.hoverMenuItem == key_;

    return MouseRegion(
      onEnter: (_) => viewModel.setHoverMenuItem = key_,
      onExit: (_) => viewModel.clearHoverItem(),
      child: InkWell(
        onTap: () => viewModel.setActiveMenuItem = key_,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 20),
          child: Column(
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 12 : 15,
                  fontWeight: FontWeight.w600,
                  color: isActive
                      ? _Colors.primary
                      : (isHovered ? Colors.white : Colors.grey),
                ),
                child: Text(label),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 2,
                width: isActive ? 40 : (isHovered ? 24 : 0),
                color: _Colors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
              colors: [_Colors.primary, Colors.orangeAccent],
            )
                : null,
            border: isPrimary
                ? null
                : Border.all(color: _Colors.primary),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isPrimary ? Colors.black : _Colors.primary,
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
        color: _Colors.cardBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              color: _Colors.primaryDark,
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
        color: _Colors.cardBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _Colors.primary.withOpacity(0.2),
            ),
            child: Icon(skill.icon, size: 20, color: _Colors.primaryDark),
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
                    color: _Colors.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  skill.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    height: 1.4,
                    color: _Colors.inkMid,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1);
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
              colors: [_Colors.primary, Colors.orangeAccent],
            ),
            boxShadow: [
              BoxShadow(
                color: _Colors.primary.withOpacity(0.6),
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
                _Colors.primary.withOpacity(0.7),
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
    "Developed and maintained cross-platform mobile application features using Flutter and Dart, following clean architecture practices.",
    "Implemented Provider-based state management and applied MVVM architecture for scalable modular codebases.",
    "Integrated RESTful APIs using Dio with multipart data handling and secure authentication flows.",
    "Improved application performance through efficient local data caching strategies.",
    "Built interactive and data-driven UI components for intuitive user experiences.",
    "Integrated Firebase Authentication and Crashlytics for secure access and monitoring.",
    "Collaborated closely with designers and backend teams to deliver optimized production-ready features.",
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: _Colors.cardBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 40,
            offset: const Offset(0, 25),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Junior Frontend Developer (Flutter)",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 18 : 24,
              fontWeight: FontWeight.w700,
              color: _Colors.ink,
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
                  color: _Colors.primary.withOpacity(0.15),
                ),
                child: Text(
                  "Analogue It Solutions",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _Colors.primaryDark,
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
                colors: [_Colors.primary, Colors.orangeAccent],
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
                color: _Colors.inkLight,
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
        Icon(icon, size: 18, color: _Colors.primary),
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
  });

  final String hint;
  final TextEditingController controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: _Colors.inputBg,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _Colors.primary, width: 1.2),
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