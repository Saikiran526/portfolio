part of 'home_screen.dart';

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
          colors: [PortfolioColors.footerBg1, PortfolioColors.footerBg2],
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
              KeyedSubtree(key: viewModel.contactSectionKey, child: _FooterRight(viewModel: viewModel)),
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(child: _FooterLeft()),
              const SizedBox(width: 80),
              Expanded(
                key: viewModel.contactSectionKey,
                  child: _FooterRight(viewModel: viewModel)
              ),
            ],
          ),
          const SizedBox(height: 80),
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          const SizedBox(height: 20),
          Text(
            "© 2026 ${AppConstants.nameText}. All rights reserved.",
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate(value: context.reduceMotion ? 1 : null, autoPlay: !context.reduceMotion).fadeIn(duration: 800.ms).slideY(begin: 0.2);
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
            colors: [PortfolioColors.primary, Colors.orangeAccent],
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
    return Form(
      key: viewModel.contactFormKey,
      child: Column(
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
          _FooterTextField(
            hint: "Your Name",
            controller: viewModel.nameController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "I'd love to know your name before we connect.";
              }
              if (value.trim().length < 2) {
                return "Please enter a valid name.";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _FooterTextField(hint: "Your Email",
            controller: viewModel.emailController,
            validator: (value) {
              final email = value?.trim() ?? '';
              if (email.isEmpty) {
                return "Please provide your email so I can follow up on your message.";
              }

              final emailRegex = RegExp(
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
                r"[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z]{2,}$",
              );

              if (!emailRegex.hasMatch(email)) {
                return "Enter a valid email";
              }

              return null;
            },
          ),
          const SizedBox(height: 20),
          _FooterTextField(
            hint: "Your Message",
            controller: viewModel.messageController,
            maxLines: 4,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Please let me know why you'd like to connect.";
              }
              if (value.trim().length < 10) {
                return "Message should be at least 10 characters";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: PortfolioColors.primary,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () async {

                final formState = viewModel.contactFormKey.currentState;
                if (formState == null) return;
                if (!formState.validate()) {
                  return; // stop here if any field is invalid
                }


                final sent = await viewModel.sendMessage();
                if (!context.mounted) return;
                showTopSnackBar(
                  Overlay.of(context),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 300,
                      child: sent
                          ? const CustomSnackBar.success(
                          message: "Message sent successfully...!")
                          : const CustomSnackBar.error(
                          message: "Message not sent. Try again!"),
                    ),
                  )
                );
              },
              child: Text(
                "Send Message",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Floating Navbar

