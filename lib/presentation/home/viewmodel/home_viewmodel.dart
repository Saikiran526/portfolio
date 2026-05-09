import 'dart:js_interop';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:web/web.dart' as web;
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:html' as html;

class HomeViewmodel extends ChangeNotifier {


  HomeViewmodel();

  /// State
  String _activeMenuItem = "";
  String _hoverMenuItem = "";
  // section navigation
  final ScrollController scrollController = ScrollController();
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  String get activeMenuItem => _activeMenuItem;
  String get hoverMenuItem => _hoverMenuItem;

  /// Setters
  set setActiveMenuItem(String value) {
    _activeMenuItem = value;
    _scrollToSection(value);
    notifyListeners();
  }
  set setHoverMenuItem(String value) {
    _hoverMenuItem = value;
    notifyListeners();
  }


  /// Behaviour
  void clearHoverItem() {
    _hoverMenuItem = "";
    notifyListeners();
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
      );
    }
  }
  Future<void> downloadResume() async {

    // 'https://drive.google.com/uc?export=download&id=1hLhQsAW4f7ZG_VbuFwtpBqCOgpg9Bz_h'
    final url = 'https://drive.google.com/uc?export=download&id=${AppConstants.fileId}';

    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'Saikiran_Resume.pdf');

    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
  }


}
