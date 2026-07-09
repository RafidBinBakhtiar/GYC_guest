import 'package:flutter/material.dart';

import 'screen/gyc_login_screen.dart';

void main() {
  runApp(const GuestUserApp());
}

class GuestUserApp extends StatelessWidget {
  const GuestUserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guest User',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF1E1F20),
      ),
      home: const GycLoginScreen(),
    );
  }
}
