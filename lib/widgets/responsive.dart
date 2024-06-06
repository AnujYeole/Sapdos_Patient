// widgets/responsive.dart
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  Responsive({required this.mobile, required this.desktop});

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 850;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isDesktop(context)) {
          return desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}
