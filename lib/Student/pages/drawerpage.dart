import 'package:flutter/material.dart';

class Drawerpage extends StatelessWidget {
  const Drawerpage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [Text("Drawer")],
      ),
    );
  }
}
