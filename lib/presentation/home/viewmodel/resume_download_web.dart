import 'package:web/web.dart' as web;

Future<void> downloadResume(String url) async {
  final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
  anchor.href = url;
  anchor.setAttribute('download', 'Saikiran_Resume.pdf');
  web.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
}
