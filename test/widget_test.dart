// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Test Casing',
    () {
      test(
        'To snake_case',
        () {
          final result = Casing.snakeCase("assets/images/ic_like_fill.png");
          debugPrint(result); 
        },
      );
    },
  );
}

class Casing {
  static final RegExp _symbols = RegExp(r'[ ./_\-\\]');
  static final RegExp _camelPascalCase = RegExp(r'(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])');
  static final RegExp _digitRegExp = RegExp(r'\d');
  static final RegExp _letterRegExp = RegExp(r'[a-zA-Z]');

  static String camelCase(String input) {
    final group = _getWordsGroup(input);

    final buffer = StringBuffer();

    for (int i = 0; i < group.length; i++) {
      var word = group[i];

      if (i == 0) {
        buffer.write(word.toLowerCase());
      } else {
        buffer.write(_uppercaseFirst(word.toLowerCase()));
      }
    }

    return buffer.toString();
  }

  static String pascalCase(String input) {
    final group = _getWordsGroup(input).map(_uppercaseFirst);

    return group.join();
  }

  static String snakeCase(String input) {
    return lowerCase(input, separator: "_");
  }

  static String kebabCase(String input) {
    return lowerCase(input, separator: "-");
  }

  static String dotCase(String input) {
    return lowerCase(input, separator: ".");
  }

  static String constantCase(String input) {
    return upperCase(input, separator: "_");
  }

  static String titleCase(String input, {String separator = " "}) {
    final group = _getWordsGroup(input).map(_uppercaseFirst);

    return group.join(separator);
  }

  static String lowerCase(String input, {String separator = " "}) {
    final group = _getWordsGroup(input);

    return group.join(separator);
  }

  static String upperCase(String input, {String separator = " "}) {
    final group = _getWordsGroup(input).map((x) => x.toUpperCase());

    return group.join(separator);
  }

  static String _uppercaseFirst(String word) {
    return word.replaceRange(0, 1, word[0].toUpperCase());
  }

  static List<String> _getWordsGroup(String input) {
    final buffer = StringBuffer();
    List<String> group = [];

    for (int i = 0; i < input.length; i++) {
      String currentChar = input[i];
      String? nextChar = i == input.length - 1 ? null : input[i + 1];

      if (_symbols.hasMatch(currentChar)) continue;

      bool isDigit = _digitRegExp.hasMatch(currentChar);
      bool isNextDigit = _digitRegExp.hasMatch(nextChar ?? "");
      bool isLetter = _letterRegExp.hasMatch(currentChar);
      bool isNextLetter = _letterRegExp.hasMatch(nextChar ?? "");

      if ((isDigit && isNextLetter) || (isLetter && isNextDigit)) {
        buffer.write(currentChar);
        group.add(buffer.toString());
        buffer.clear();
        continue;
      }

      bool isUppercase = currentChar.toUpperCase() == currentChar;
      bool isNextUppercase = nextChar?.toUpperCase() == nextChar;

      if (isUppercase && buffer.isNotEmpty && !isNextUppercase && !isDigit) {
        group.add(buffer.toString());
        buffer.clear();
      }

      buffer.write(currentChar);

      if (_isEndOfWord(nextChar)) {
        group.add(buffer.toString());
        buffer.clear();
      }
    }

    // Split CamelCase and PascalCase strings
    group = group.expand((word) {
      if (_camelPascalCase.hasMatch(word)) {
        return word.split(_camelPascalCase);
      }
      return [word];
    }).toList();

    return group.map((e) => e.toLowerCase()).toList();
  }

  static bool _isEndOfWord(String? nextChar) {
    return nextChar == null || _symbols.hasMatch(nextChar);
  }
}
