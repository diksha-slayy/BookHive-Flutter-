import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
import 'PostBookScreen.dart';
import 'UserProfileScreen.dart';
import 'BookHistoryScreen.dart';

void main() {
  runApp(BookSharingApp());
}

class BookSharingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Sharing App',
      theme: ThemeData(
        primaryColor: Color(0xFF351904), // Espresso
        scaffoldBackgroundColor: Color(0xFFFFECB8), // Malibu
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF8B3A00), // Ember
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFE08E00), // Gold
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Sharing Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeButton(
              title: 'Post a Book',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PostBookScreen()),
                );
              },
            ),
            HomeButton(
              title: 'User Profile',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => UserProfileScreen()),
                );
              },
            ),
            HomeButton(
              title: 'Book History',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BookHistoryScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const HomeButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
