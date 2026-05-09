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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: ChangeNotifierProvider(
        create: (_) => HomeViewmodel(),
        child: Consumer<HomeViewmodel>(
          builder: (context, viewModel, child) {
            return Stack(
              children: [

                // Main content
                SingleChildScrollView(
                  controller: viewModel.scrollController,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF000000), Color(0xFF000000)],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Stack(
                        children: [

                          // Skills animation
                          Positioned(
                            right: -90,
                            top: -90,
                            child: const SkillOrbitAnimation(),
                          ),

                          // main content
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Profile Section
                              verticalSpacing(customHeight: height*0.05),
                              Container(
                                key: viewModel.homeKey,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    // Profile Image
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Image.asset(
                                          // color: Colors.red,
                                          AssetPaths.blackBackgroundImage,
                                          width: 500,
                                          height: height * 0.9,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    // Intro Text
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          // Intro line
                                          Text(
                                            "Hi, I'm",
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              color: Colors.grey[400],
                                              letterSpacing: 1.2,
                                            ),
                                          )
                                              .animate()
                                              .fadeIn(duration: 600.ms)
                                              .slideX(begin: -0.2),

                                          const SizedBox(height: 8),

                                          // Name with gradient
                                          ShaderMask(
                                            shaderCallback: (bounds) => const LinearGradient(
                                              colors: [Color(0xFFfbd214), Colors.orangeAccent],
                                            ).createShader(bounds),
                                            child: Text(
                                              AppConstants.nameText,
                                              style: GoogleFonts.poppins(
                                                fontSize: 56,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                height: 1.1,
                                              ),
                                            ),
                                          )
                                              .animate(delay: 300.ms)
                                              .fadeIn(duration: 800.ms)
                                              .slideY(begin: 0.2),
                                          const SizedBox(height: 12),

                                          // Role with animated emphasis
                                          Text(
                                            AppConstants.frontEndDeveloperText,
                                            style: GoogleFonts.poppins(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          )
                                              .animate(delay: 600.ms)
                                              .fadeIn(duration: 800.ms)
                                              .slideX(begin: 0.3),
                                          const SizedBox(height: 20),

                                          // Short refined intro
                                          Container(
                                            constraints: const BoxConstraints(maxWidth: 520),
                                            child: Text(
                                              AppConstants.introText,
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                height: 1.6,
                                                color: Colors.grey[300],
                                              ),
                                            ),
                                          )
                                              .animate(delay: 900.ms)
                                              .fadeIn(duration: 900.ms)
                                              .slideY(begin: 0.2),
                                          const SizedBox(height: 32),

                                          //  Buttons
                                          Row(
                                            children: [

                                              _modernButton(
                                                text: "Download CV",
                                                isPrimary: true,
                                                callback: viewModel.downloadResume,
                                              ).animate(delay: 1200.ms)
                                                  .fadeIn(duration: 800.ms)
                                                  .slideY(begin: 0.3),

                                              const SizedBox(width: 20),

                                              _modernButton(
                                                text: "Let's Connect",
                                                isPrimary: false,
                                                callback: (){}
                                              ).animate(delay: 1400.ms)
                                                  .fadeIn(duration: 800.ms)
                                                  .slideY(begin: 0.3),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              verticalSpacing(customHeight: height*0.05),

                              // About me Section
                              Container(
                                width: double.infinity,
                                color: const Color(0xFFF7F6F2),
                                padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    // LEFT SIDE IMAGE
                                    Expanded(
                                      flex: 2,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [

                                          // Soft glow background
                                          Container(
                                            width: 320,
                                            height: 420,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(24),
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFFfbd214),
                                                  Colors.orangeAccent,
                                                ],
                                              ),
                                            ),
                                          ).animate().fadeIn(duration: 600.ms),

                                          // Image card
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
                                          )
                                              .animate(delay: 300.ms)
                                              .fadeIn(duration: 800.ms)
                                              .slideX(begin: -0.2),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 80),

                                    // RIGHT SIDE CONTENT
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(
                                            " - ABOUT ME",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              letterSpacing: 3,
                                              color: const Color(0xFFc9a400),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                              .animate()
                                              .fadeIn(duration: 600.ms)
                                              .slideY(begin: 0.2),

                                          const SizedBox(height: 16),

                                          Text(
                                            "Crafting Clean & Scalable\nFlutter Experiences",
                                            style: GoogleFonts.poppins(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF111111), // Dark text for light bg
                                              height: 1.2,
                                            ),
                                          )
                                              .animate(delay: 200.ms)
                                              .fadeIn(duration: 800.ms)
                                              .slideY(begin: 0.2),

                                          const SizedBox(height: 24),

                                          Container(
                                            constraints: const BoxConstraints(maxWidth: 600),
                                            child: Text(
                                              "I am a passionate Flutter Frontend Developer with hands-on experience in building scalable, high-performance mobile applications. "
                                                  "My focus is on writing clean architecture-driven code, implementing efficient state management, and crafting seamless user experiences.\n\n"
                                                  "I enjoy transforming complex business requirements into intuitive UI solutions while maintaining performance, readability, and maintainability at the core of every project.",
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                height: 1.7,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                          )
                                              .animate(delay: 400.ms)
                                              .fadeIn(duration: 900.ms)
                                              .slideY(begin: 0.2),

                                          const SizedBox(height: 32),

                                          Row(
                                            children: [
                                              _aboutHighlightLight("2+", "Years Experience"),
                                              const SizedBox(width: 24),
                                              _aboutHighlightLight("10+", "Projects Built"),
                                              const SizedBox(width: 24),
                                              _aboutHighlightLight("Clean", "Architecture Focus"),
                                            ],
                                          )
                                              .animate(delay: 600.ms)
                                              .fadeIn(duration: 900.ms)
                                              .slideY(begin: 0.2),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpacing(customHeight: height*0.02),

                              // Skills section
                              Container(
                                key: viewModel.skillsKey,
                                width: double.infinity,
                                // height: height,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 60,
                                  horizontal: 60,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFc9a400),
                                      ),
                                    ).animate(delay: 200.ms).fadeIn(duration: 800.ms),

                                    const SizedBox(height: 40),

                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 320,
                                        mainAxisSpacing: 30,
                                        crossAxisSpacing: 30,
                                        childAspectRatio: 1.6,
                                      ),
                                      itemCount: 8,
                                      itemBuilder: (context, index) {
                                        final skills = [
                                          {
                                            "title": "Programming Languages",
                                            "desc": "Dart • Java • JavaScript • ReactJS • HTML • CSS",
                                            "icon": Icons.code,
                                          },
                                          {
                                            "title": "Frameworks & SDKs",
                                            "desc": "Flutter",
                                            "icon": Icons.phone_android,
                                          },
                                          {
                                            "title": "State Management",
                                            "desc": "Provider",
                                            "icon": Icons.sync_alt,
                                          },
                                          {
                                            "title": "Architecture",
                                            "desc": "MVVM",
                                            "icon": Icons.architecture,
                                          },
                                          {
                                            "title": "API Integration",
                                            "desc": "RESTful APIs • JSON • Dio",
                                            "icon": Icons.cloud_done,
                                          },
                                          {
                                            "title": "Databases & Storage",
                                            "desc": "SQLite (Sqflite) • Firebase",
                                            "icon": Icons.storage,
                                          },
                                          {
                                            "title": "Version Control",
                                            "desc": "Git",
                                            "icon": Icons.merge_type,
                                          },
                                          {
                                            "title": "Tools & Platforms",
                                            "desc": "Postman • Android Studio • VS Code",
                                            "icon": Icons.build,
                                          },
                                        ];

                                        return _minimalSkillCard(
                                          skills[index]["title"] as String,
                                          skills[index]["desc"] as String,
                                          skills[index]["icon"] as IconData,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              // Experience section
                              Container(
                                key: viewModel.experienceKey,
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFF9F8F4),
                                      Color(0xFFF2F1ED),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    // Section Label
                                    Text(
                                      "EXPERIENCE",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        letterSpacing: 3,
                                        color: const Color(0xFF1A1A1A),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ).animate().fadeIn(duration: 600.ms),
                                    Text(
                                      "Professional Journey",
                                      style: GoogleFonts.poppins(
                                        fontSize: 42,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFc9a400),
                                      ),
                                    ).animate(delay: 200.ms).fadeIn(duration: 800.ms),
                                    const SizedBox(height: 21),

                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        final isMobile = constraints.maxWidth < 900;

                                        return Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            if (!isMobile) ...[
                                              // Vertical Timeline
                                              Column(
                                                children: [
                                                  Container(
                                                    width: 18,
                                                    height: 18,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      gradient: const LinearGradient(
                                                        colors: [
                                                          Color(0xFFfbd214),
                                                          Colors.orangeAccent,
                                                        ],
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: const Color(0xFFfbd214).withOpacity(0.6),
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
                                                          const Color(0xFFfbd214).withOpacity(0.7),
                                                          Colors.transparent,
                                                        ],
                                                        begin: Alignment.topCenter,
                                                        end: Alignment.bottomCenter,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 60),
                                            ],

                                            Expanded(
                                              child: _premiumExperienceCard(),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ).animate().fadeIn(duration: 900.ms).slideY(begin: 0.2),
                              verticalSpacing(customHeight: height*0.02),


                              // Projects section
                              Container(
                                  key: viewModel.projectsKey,
                                  child: const ProjectsCarousel()
                              ),
                              verticalSpacing(customHeight: height*0.02),

                              // Footer Section
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 80),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF0F0F10),
                                      Color(0xFF1C1C1E),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final isMobile = constraints.maxWidth < 900;

                                    return Column(
                                      children: [

                                        isMobile
                                            ? Column(
                                          children: [
                                            _footerLeftSection(),
                                            const SizedBox(height: 60),
                                            _footerRightSection(),
                                          ],
                                        )
                                            : Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(flex: 1, child: _footerLeftSection()),
                                            const SizedBox(width: 80),
                                            Expanded(flex: 1, child: _footerRightSection()),
                                          ],
                                        ),

                                        const SizedBox(height: 80),

                                        Divider(color: Colors.white.withOpacity(0.1)),

                                        const SizedBox(height: 20),

                                        Text(
                                          "© 2026 ${AppConstants.nameText}. All rights reserved.",
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),


                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

                // top Menu
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: _floatingNavbar(viewModel),
                ),


              ],
            );
          },
        ),
      ),
    );
  }

  // Footer widgets
  Widget _footerLeftSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFfbd214), Colors.orangeAccent],
          ).createShader(bounds),
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

        _contactInfo(Icons.email, "yourmail@example.com"),
        const SizedBox(height: 15),
        _contactInfo(Icons.phone, "+91 9XXXXXXXXX"),
      ],
    );
  }

  Widget _contactInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFFfbd214)),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  Widget _footerRightSection() {
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

        _footerTextField("Your Name"),
        const SizedBox(height: 20),

        _footerTextField("Your Email"),
        const SizedBox(height: 20),

        _footerTextField("Your Message", maxLines: 4),
        const SizedBox(height: 30),

        SizedBox(
          width: 160,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color(0xFFfbd214),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              // Later: integrate EmailJS / Firebase / backend API
            },
            child: Text(
              "Send Message",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _footerTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: const Color(0xFF2A2A2D),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFfbd214),
            width: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _floatingNavbar(HomeViewmodel viewModel) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),

              // Glass base
              color: Colors.white.withOpacity(0.08),

              // Soft gradient border
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
              children: [
                _menuItem("Home", "home", viewModel),
                _menuItem("Skills", "skills", viewModel),
                _menuItem("Experience", "experience", viewModel),
                _menuItem("Projects", "projects", viewModel),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: -0.3);
  }

  Widget _skillCardPremium(String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFF8F8F8), // subtle contrast from white
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // Top gold accent line
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFc9a400),
            ),
          ),

          const SizedBox(height: 18),

          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFfbd214).withOpacity(0.15),
            ),
            child: Icon(
              icon,
              size: 26,
              color: const Color(0xFFc9a400),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111111),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.6,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.15);
  }

  Widget _glassSkillCard(String title, String description, IconData icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),

            // Slightly stronger white
            color: Colors.white.withOpacity(0.85),

            border: Border.all(
              color: Colors.grey.withOpacity(0.15),
              width: 1,
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 25,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              // Icon container
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFfbd214),
                      Color(0xFFe0a800),
                    ],
                  ),
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: Colors.black, // Strong contrast
                ),
              ),

              const SizedBox(height: 24),

              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111111),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                description,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  height: 1.6,
                  color: const Color(0xFF555555), // darker grey
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 700.ms)
        .slideY(begin: 0.15)
        .scale(begin: const Offset(0.96, 0.96));
  }

  Widget _minimalSkillCard(String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFfbd214).withOpacity(0.2),
            ),
            child: Icon(
              icon,
              size: 22,
              color: const Color(0xFFc9a400),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111111),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    height: 1.4,
                    color: const Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.1);
  }

  Widget _experienceCard(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Role
          Text(
            "Junior Frontend Developer (Flutter)",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111111),
            ),
          ),

          const SizedBox(height: 6),

          // Company + Duration
          Row(
            children: [
              Text(
                "Analogue I Solutions",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFc9a400),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFfbd214).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Feb 2025 – Present",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          _experiencePoint(
            "Developed and maintained cross-platform mobile application features using Flutter and Dart, following clean and maintainable coding practices.",
          ),
          _experiencePoint(
            "Implemented Provider-based state management and applied Clean Architecture and MVVM patterns to build scalable and modular codebases.",
          ),
          _experiencePoint(
            "Integrated RESTful APIs using Dio, including multipart data handling and secure token-based authentication flows.",
          ),
          _experiencePoint(
            "Improved application performance by implementing local data caching strategies to reduce redundant network calls.",
          ),
          _experiencePoint(
            "Implemented data-driven UI components and visualizations to present complex information in a user-friendly manner.",
          ),
          _experiencePoint(
            "Integrated Firebase Authentication and Firebase Crashlytics to ensure secure access and monitor application stability.",
          ),
          _experiencePoint(
            "Collaborated with designers and backend developers to deliver production-ready features with optimized performance and smooth user experience.",
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2);
  }

  Widget _experiencePoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFc9a400),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.6,
                color: const Color(0xFF444444),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _premiumExperienceCard() {
    return Container(
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 40,
            offset: const Offset(0, 25),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Role
          Text(
            "Junior Frontend Developer (Flutter)",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111111),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [

              // Company
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFFfbd214).withOpacity(0.15),
                ),
                child: Text(
                  "Analogue I Solutions",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFc9a400),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Text(
                "Feb 2025 – Present",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          _premiumPoint(
              "Developed and maintained cross-platform mobile application features using Flutter and Dart, following clean architecture practices."
          ),
          _premiumPoint(
              "Implemented Provider-based state management and applied MVVM architecture for scalable modular codebases."
          ),
          _premiumPoint(
              "Integrated RESTful APIs using Dio with multipart data handling and secure authentication flows."
          ),
          _premiumPoint(
              "Improved application performance through efficient local data caching strategies."
          ),
          _premiumPoint(
              "Built interactive and data-driven UI components for intuitive user experiences."
          ),
          _premiumPoint(
              "Integrated Firebase Authentication and Crashlytics for secure access and monitoring."
          ),
          _premiumPoint(
              "Collaborated closely with designers and backend teams to deliver optimized production-ready features."
          ),
        ],
      ),
    );
  }

  Widget _premiumPoint(String text) {
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
                colors: [
                  Color(0xFFfbd214),
                  Colors.orangeAccent,
                ],
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
                color: const Color(0xFF444444),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerBrand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFfbd214), Colors.orangeAccent],
          ).createShader(bounds),
          child: Text(
            AppConstants.nameText,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 16),

        Text(
          "Flutter Frontend Developer crafting scalable, clean and performance-driven mobile applications.",
          style: GoogleFonts.poppins(
            fontSize: 14,
            height: 1.6,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _footerLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Navigation",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 20),

        _footerLinkItem("Home"),
        _footerLinkItem("About"),
        _footerLinkItem("Skills"),
        _footerLinkItem("Experience"),
        _footerLinkItem("Projects"),
      ],
    );
  }

  Widget _footerContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Contact",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 20),

        _footerContactItem(Icons.email, "yourmail@email.com"),
        _footerContactItem(Icons.phone, "+91 XXXXX XXXXX"),
        _footerContactItem(Icons.location_on, "India"),
      ],
    );
  }

  Widget _footerContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFFfbd214)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[400],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerLinkItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.grey[400],
        ),
      ),
    );
  }

  Widget _skillCard(String title, String description, IconData icon) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFfbd214).withOpacity(0.15),
            ),
            child: Icon(
              icon,
              size: 28,
              color: const Color(0xFFc9a400),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111111),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.6,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.2);
  }

  Widget _skillCardWhite(String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFF9F9F9), // Slight contrast from pure white
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // Icon
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFfbd214).withOpacity(0.15),
            ),
            child: Icon(
              icon,
              size: 28,
              color: const Color(0xFFc9a400),
            ),
          ),

          const SizedBox(height: 20),

          // Title
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111111),
            ),
          ),

          const SizedBox(height: 12),

          // Description
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.6,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.15);
  }

  Widget _aboutHighlightLight(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
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
            title,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFc9a400),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(String text, String keyName, HomeViewmodel viewModel) {
    final isActive = viewModel.activeMenuItem == keyName;
    final isHovered = viewModel.hoverMenuItem == keyName;

    return MouseRegion(
      onEnter: (_) => viewModel.setHoverMenuItem = keyName,
      onExit: (_) => viewModel.clearHoverItem(),
      child: InkWell(
        onTap: () => viewModel.setActiveMenuItem = keyName,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isActive
                      ? const Color(0xFFfbd214)
                      : (isHovered ? Colors.white : Colors.grey),
                ),
                child: Text(text),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 2,
                width: isActive ? 60 : (isHovered ? 40 : 0),
                color: const Color(0xFFfbd214),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _modernButton({
    required String text,
    required bool isPrimary,
    required VoidCallback callback,
  }) {
    return InkWell(
      onTap: callback, // CORRECT
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: isPrimary
                ? const LinearGradient(
              colors: [
                Color(0xFFfbd214),
                Colors.orangeAccent,
              ],
            )
                : null,
            border: isPrimary
                ? null
                : Border.all(
              color: const Color(0xFFfbd214),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isPrimary
                  ? Colors.black
                  : const Color(0xFFfbd214),
            ),
          ),
        ),
      ),
    );
  }

}

