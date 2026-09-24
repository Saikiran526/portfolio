import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/presentation/helper/projects_carousel.dart';
import 'package:portfolio/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('project details remain available after carousel navigation', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: ProjectsCarousel())));
    expect(find.text('1 / 5'), findsOneWidget);
    await tester.tap(find.byTooltip('Next project'));
    await tester.pumpAndSettle();
    expect(find.text('2 / 5'), findsOneWidget);
    expect(find.text('App Store'), findsWidgets);
    expect(find.text('Google Play'), findsWidgets);
    await tester.tap(find.text('Read case study').at(1));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Close case study'), findsOneWidget);
    expect(find.textContaining('Gazam'), findsWidgets);
  });

  testWidgets('projects advance automatically', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: ProjectsCarousel())));
    expect(find.text('1 / 5'), findsOneWidget);
    await tester.pump(const Duration(seconds: 8));
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.text('2 / 5'), findsOneWidget);
  });

  for (final width in [320.0, 768.0, 1440.0]) {
    testWidgets('home page lays out at ${width.toInt()} px', (tester) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const MyApp());
      await tester.pump(const Duration(milliseconds: 100));
      final error = tester.takeException();
      expect(error, isNull);
      expect(find.text('Saikiran'), findsWidgets);
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 2));
    });
  }

}
