import 'package:flutter/cupertino.dart';
import 'package:responsive/widgets/mobile_body.dart';
import 'package:responsive/predefined.dart';
import 'package:responsive/widgets/tablet_body.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    required this.tabletBody,
  });

  final Widget mobileBody;
  final Widget tabletBody;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > Dimensions.mobileWidth) {
          return const TabletBody();
        }
        return const MobileBody();
      }),
    );
  }
}
