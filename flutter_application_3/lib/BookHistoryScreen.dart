import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookHistoryScreen extends StatefulWidget {
  @override
  _BookHistoryScreenState createState() => _BookHistoryScreenState();
}

class _BookHistoryScreenState extends State<BookHistoryScreen> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> _bookHistory = [];
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _loadBookHistory();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
  }

  Future<void> _loadBookHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> books = prefs.getStringList('user_books') ?? [];

    setState(() {
      _bookHistory = books
          .map((bookJson) => Map<String, dynamic>.from(jsonDecode(bookJson)))
          .toList();
    });

    _animationController?.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFECB8),
      appBar: AppBar(
        title: Text('My Posted Books', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color(0xFF8B3A00),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: _bookHistory.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: _bookHistory.length,
              itemBuilder: (context, index) {
                final book = _bookHistory[index];
                final animation = Tween<Offset>(
                  begin: Offset(1, 0),
                  end: Offset(0, 0),
                ).animate(
                  CurvedAnimation(
                    parent: _animationController!,
                    curve: Interval((1 / _bookHistory.length) * index, 1.0, curve: Curves.easeOut),
                  ),
                );
                return SlideTransition(
                  position: animation,
                  child: _buildBookCard(book),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu_book_rounded, color: Color(0xFF351904), size: 100),
          SizedBox(height: 20),
          Text(
            "No books posted yet!",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF351904)),
          ),
          SizedBox(height: 10),
          Text(
            "Start your journey by posting your first book 📚",
            style: TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(Map<String, dynamic> book) {
    String prologue = book['prologue'] ?? '';

    return Card(
      elevation: 8,
      shadowColor: Color(0xFFE08E00),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book['title'] ?? '',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF351904),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Author: ${book['author'] ?? ''}",
              style: TextStyle(color: Colors.black87),
            ),
            SizedBox(height: 4),
            Text(
              "Category: ${book['category'] ?? ''}",
              style: TextStyle(color: Colors.black87),
            ),
            SizedBox(height: 8),
            Text(
              "Prologue: ${prologue.length > 60 ? prologue.substring(0, 60) + '...' : prologue}",
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE08E00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  _showPrologueDialog(book);
                },
                child: Text("Read Prologue", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showPrologueDialog(Map<String, dynamic> book) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Color(0xFFFFECB8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          book['title'] ?? '',
          style: TextStyle(color: Color(0xFF351904), fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Text(
            book['prologue'] ?? 'No prologue available.',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close", style: TextStyle(color: Color(0xFF8B3A00))),
          ),
        ],
      ),
    );
  }
}
