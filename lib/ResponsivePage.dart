import 'package:flutter/material.dart';

abstract class ResponsivePage extends StatefulWidget {
  const ResponsivePage({super.key});

  // @override
  // State<ResponsivePage> createState() => ResponsivePageState();
}

abstract class ResponsivePageState<T extends ResponsivePage> extends State<T> {
  static const desktopMinWidth = 1200;
  static const mobileMaxWidth =  730;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopMinWidth;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileMaxWidth;
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMaxWidth;

  Widget buildDesktop(BuildContext context);
  Widget buildTablet(BuildContext context);
  Widget buildMobile(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return buildDesktop(context);
    } else if (isTablet(context)) {
      return buildTablet(context);
    } else {
      return buildMobile(context);
    }
  }
}
