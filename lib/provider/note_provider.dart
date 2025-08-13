import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class NoteProvider with ChangeNotifier {
  List<Map<String, String>> _notes = [];

  List<Map<String, String>> get notes => _notes;

  NoteProvider() {
    loadNotes();
  }

  Future<void> loadNotes() async {
  final String jsonString = await rootBundle.loadString('assets/json/note.json');
  final List<dynamic> jsonData = json.decode(jsonString);
  
  _notes = jsonData.map<Map<String, String>>((item) {
    return (item as Map<String, dynamic>).map<String, String>((String key, dynamic value) {
      return MapEntry(key, value.toString());
    });
  }).toList();

  print("Loaded notes: $_notes");
  notifyListeners();
}


}



