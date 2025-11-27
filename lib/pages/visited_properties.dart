import 'package:flutter/material.dart';

class VisitedPropertiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Visited Properties")),
      body: const Center(
        child: Text("Visited property list will appear here."),
      ),
    );
  }
}
