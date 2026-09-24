part of 'home_screen.dart';

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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 40,
              vertical: isMobile ? 12 : 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color(0xFF202023),
              border: Border.all(
                width: 1.2,
                color: Colors.white.withValues(alpha: 0.15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
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
    );
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
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 7 : 18, vertical: 4),
          child: Column(
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 11 : 14,
                  fontWeight: FontWeight.w600,
                  color: isActive
                      ? PortfolioColors.primary
                      : (isHovered ? Colors.white : Colors.grey),
                ),
                child: Text(label),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 2,
                width: isActive ? 40 : (isHovered ? 24 : 0),
                color: PortfolioColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

