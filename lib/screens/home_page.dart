import 'package:flutter/material.dart';
import 'package:wisesplit/services/auth_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          "You logged in",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {AuthService().signOut();},
        child: const Icon(Icons.logout),
      ),
    );
  }
}