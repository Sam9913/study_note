import 'package:flutter/material.dart';
import './model.dart';

class MyModel with ChangeNotifier {
  List<Note> dictionaryList = List<Note>();
  final wordController = TextEditingController();
  String lang;

  void addNewWord(String word) {
    wordController.clear();

    if (dictionaryList.contains(Note(languageCode: lang, word: word))) {
      dictionaryList.remove(Note(languageCode: lang, word: word));
    }
    dictionaryList.add(Note(languageCode: lang, word: word));
    dictionaryList = dictionaryList.reversed.toList();
    lang = "";
    notifyListeners();
  }

  void changeLanguage(String newLang) {
    lang = newLang;
    notifyListeners();
  }

  Future<void> addToDict(DailyWord note) {
    dictionaryList.add(Note(languageCode: note.languageCode, word: note.word));
    //dictionaryList = dictionaryList.reversed.toList();

    notifyListeners();
    return Future.value();
  }

  deleteFromDict(DailyWord note) {
    dictionaryList.removeWhere((note2) {
      return note2.word == note.word;
    });
    notifyListeners();
  }
}
