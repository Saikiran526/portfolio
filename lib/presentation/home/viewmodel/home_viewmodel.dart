import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio/core/constants/app_constants.dart';

class HomeViewmodel extends ChangeNotifier {
  HomeViewmodel() {
    scrollController.addListener(_onScroll);
  }

  /// State
  String _activeMenuItem = "home";
  String _hoverMenuItem = "";
  bool _isFloatingNavbarVisible = true;

  Timer? _navbarIdleTimer;

  /// Section navigation
  final ScrollController scrollController = ScrollController();
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  /// Getters
  String get activeMenuItem => _activeMenuItem;
  String get hoverMenuItem => _hoverMenuItem;
  bool get isFloatingNavbarVisible => _isFloatingNavbarVisible;

  /// Setters
  set setActiveMenuItem(String value) {
    _activeMenuItem = value;
    _isFloatingNavbarVisible = true;
    _scrollToSection(value);
    notifyListeners();
  }

  set setHoverMenuItem(String value) {
    _hoverMenuItem = value;
    notifyListeners();
  }

  /// Behaviour
  @override
  void dispose() {
    _navbarIdleTimer?.cancel();
    scrollController.removeListener(_onScroll);
    scrollController.dispose();

    nameController.dispose();
    emailController.dispose();
    messageController.dispose();

    super.dispose();
  }

  void clearHoverItem() {
    _hoverMenuItem = "";
    notifyListeners();
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    // Keep the active tab synced with the current visible section.
    _updateActiveSection();

    final offset = scrollController.offset;

    // Always show navbar at the very top.
    if (offset <= 0) {
      _setNavbarVisible(true);
      return;
    }

    final direction = scrollController.position.userScrollDirection;

    // Hide while scrolling down, show while scrolling up.
    if (direction == ScrollDirection.reverse) {
      _setNavbarVisible(false);
    } else if (direction == ScrollDirection.forward) {
      _setNavbarVisible(true);
    }

    // When scrolling stops, show it again after a short delay.
    _navbarIdleTimer?.cancel();
    _navbarIdleTimer = Timer(const Duration(milliseconds: 180), () {
      if (!scrollController.hasClients) return;
      _setNavbarVisible(true);
    });
  }

  void _setNavbarVisible(bool value) {
    if (_isFloatingNavbarVisible == value) return;
    _isFloatingNavbarVisible = value;
    notifyListeners();
  }

  void _updateActiveSection() {
    const double triggerLine = 180;

    final sections = <String, GlobalKey>{
      "home": homeKey,
      "skills": skillsKey,
      "experience": experienceKey,
      "projects": projectsKey,
    };

    String current = _activeMenuItem;

    for (final entry in sections.entries) {
      final ctx = entry.value.currentContext;
      if (ctx == null) continue;

      final renderObject = ctx.findRenderObject();
      if (renderObject is! RenderBox || !renderObject.attached) continue;

      final top = renderObject.localToGlobal(Offset.zero).dy;

      if (top <= triggerLine) {
        current = entry.key;
      }
    }

    if (current != _activeMenuItem) {
      _activeMenuItem = current;
      notifyListeners();
    }
  }

  void _scrollToSection(String section) {
    GlobalKey? targetKey;

    switch (section) {
      case "home":
        targetKey = homeKey;
        break;
      case "skills":
        targetKey = skillsKey;
        break;
      case "experience":
        targetKey = experienceKey;
        break;
      case "projects":
        targetKey = projectsKey;
        break;
    }

    if (targetKey?.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignment: 0.08,
      );
    }
  }

  Future<void> downloadResume() async {
    final url =
        'https://drive.google.com/uc?export=download&id=${AppConstants.fileId}';

    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'Saikiran_Resume.pdf');

    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
  }

  Future<bool> sendMessage() async {
    final response = await http.post(
      Uri.parse('https://api.web3forms.com/submit'),
      body: {
        'access_key': '3fc8bafe-2bdd-4ba4-a904-4a401a66fbe9',
        'name': nameController.text,
        'email': emailController.text,
        'message': messageController.text,
      },
    );

    if (response.statusCode == 200) {
      nameController.clear();
      emailController.clear();
      messageController.clear();
      return true;
    }

    print('Response : ${response.body}');
    return false;
  }
}