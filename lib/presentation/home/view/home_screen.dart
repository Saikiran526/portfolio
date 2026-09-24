
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/constants/asset_paths.dart';
import 'package:portfolio/presentation/helper/app_widgets.dart';
import 'package:portfolio/presentation/helper/projects_carousel.dart';
import 'package:portfolio/presentation/helper/project_link_stub.dart'
    if (dart.library.js_interop) 'package:portfolio/presentation/helper/project_link_web.dart'
    as external_links;
import 'package:portfolio/presentation/home/animations/skill_orbit_animation.dart';
import 'package:portfolio/presentation/home/viewmodel/home_viewmodel.dart';
import 'layout.dart';
import 'palette.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

part 'hero_section.dart';
part 'about_section.dart';
part 'skills_section.dart';
part 'experience_section.dart';
part 'contact_section.dart';
part 'navigation.dart';
part 'section_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => HomeViewmodel(),
          child: Builder(
            builder: (context) {
              final viewModel = context.read<HomeViewmodel>();
              return Stack(
              children: [
                _MainContent(viewModel: viewModel),
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Consumer<HomeViewmodel>(
                    builder: (context, model, _) => _FloatingNavbar(viewModel: model),
                  ),
                ),
              ],
            );
            },
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
      child: Stack(
          children: [
            // Orbit animation — desktop/tablet only, positioned absolutely
            if (context.isDesktop)
              Positioned(
                right: -105,
                top: -105,
                child: ValueListenableBuilder<bool>(
                  valueListenable: viewModel.isHeroVisible,
                  builder: (context, visible, _) => TickerMode(
                    enabled: visible && !context.reduceMotion,
                    child: const RepaintBoundary(child: SkillOrbitAnimation()),
                  ),
                ),
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
                _ExperienceSection(sectionKey: viewModel.experienceKey),
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
    );
  }
}

// ── Hero ──────────────────────────────────────────────────────────────────────
