import 'package:flash_card/feathers/home/data/models/word_list.dart';
import 'package:flash_card/feathers/home/data/models/word_model.dart';
import 'package:flutter/material.dart';

class FlashcardProvider extends ChangeNotifier {
  final List<WordModel> _words = List.of(wordsList);

  int _currentIndex = 0;

  List<WordModel> get words => _words;

  int get currentIndex => _currentIndex;

  WordModel get currentWord => _words[_currentIndex];

  bool get hasNext => _currentIndex < _words.length - 1;

  bool get hasPrevious => _currentIndex > 0;

  void nextWord() {
    if (!hasNext) return;

    _currentIndex++;
    notifyListeners();
  }

  void previousWord() {
    if (!hasPrevious) return;

    _currentIndex--;
    notifyListeners();
  }

  void addWord(WordModel word) {
    _words.add(word);

    _currentIndex = _words.length - 1;

    notifyListeners();
  }
}
