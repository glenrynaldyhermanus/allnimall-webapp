import 'package:flutter/material.dart';

class AppPageTab extends StatefulWidget {
  const AppPageTab({Key? key}) : super(key: key);

  @override
  State<AppPageTab> createState() => _AppPageTabState();
}

class _AppPageTabState extends State<AppPageTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Hello! This is Tab'),
    );
  }
}
