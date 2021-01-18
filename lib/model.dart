import 'package:flutter/foundation.dart';

class Note {
  final String languageCode;
  final String word;

  Note({@required this.languageCode, @required this.word});
}

class DailyWord {
  final String languageCode;
  final String word;
  bool isAdded;

  DailyWord(
      {@required this.languageCode, @required this.word, this.isAdded = false});
}
