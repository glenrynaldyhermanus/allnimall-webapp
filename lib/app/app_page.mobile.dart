import 'package:flutter/material.dart';

class AppPageMobile extends StatefulWidget {
  const AppPageMobile({Key? key}) : super(key: key);

  @override
  State<AppPageMobile> createState() => _AppPageMobileState();
}

class _AppPageMobileState extends State<AppPageMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Hello! This is Mobile'),
    );
  }
}
