import 'package:http/http.dart' as http;
import 'package:portfolio/core/constants/app_constants.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  /// Getters
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
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.clear();
    emailController.clear();
    messageController.clear();
  }
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

    final url = 'https://drive.google.com/uc?export=download&id=${AppConstants.fileId}';

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

    if(response.statusCode == 200){

      nameController.clear();
      emailController.clear();
      messageController.clear();
      return true;

    }

    return false;
    print('Response : ${response.body}');

  }


}
