import 'package:flutter/material.dart';
import 'package:responsive/responsive_layout.dart';
import 'package:responsive/widgets/mobile_body.dart';
import 'package:responsive/widgets/tablet_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(
        mobileBody: MobileBody(),
        tabletBody: TabletBody(),
      ),
    );
  }
}
