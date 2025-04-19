import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PostBookScreen extends StatefulWidget {
  @override
  _PostBookScreenState createState() => _PostBookScreenState();
}

class _PostBookScreenState extends State<PostBookScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _prologueController = TextEditingController();
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _animationController?.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _categoryController.dispose();
    _prologueController.dispose();
    _animationController?.dispose();
    super.dispose();
  }

  Future<void> _saveBook() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> books = prefs.getStringList('user_books') ?? [];

    Map<String, dynamic> newBook = {
      'title': _titleController.text,
      'author': _authorController.text,
      'category': _categoryController.text,
      'prologue': _prologueController.text,
    };

    books.add(jsonEncode(newBook));
    await prefs.setStringList('user_books', books);

    Navigator.pop(context); // go back after posting
  }

  Widget _buildTextField(TextEditingController controller, String label, int maxLines) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xFF8B3A00)),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xFFE08E00)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xFFE08E00)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFECB8),
      appBar: AppBar(
        title: Text('Post a New Book', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color(0xFF8B3A00),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FadeTransition(
            opacity: _animationController!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(_titleController, 'Book Title', 1),
                _buildTextField(_authorController, 'Author', 1),
                _buildTextField(_categoryController, 'Category', 1),
                _buildTextField(_prologueController, 'Prologue (Optional)', 5),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE08E00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    onPressed: _saveBook,
                    child: Text(
                      'Post Book',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
