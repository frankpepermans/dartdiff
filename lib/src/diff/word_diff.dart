import 'package:dartdiff/src/diff/diff.dart' show Diff;

class WordDiff extends Diff {

  final RegExp extendedWordChars = new RegExp('^[a-zA-Z\u{C0}-\u{FF}\u{D8}-\u{F6}\u{F8}-\u{2C6}\u{2C8}-\u{2D7}\u{2DE}-\u{2FF}\u{1E00}-\u{1EFF}]+\$');

  WordDiff(String oldString, String newString) : super(oldString, newString);

  @override List<String> tokenize(String value) {
    final List<String> tokens = value.split(new RegExp(r'\b'));

    for (int i = 0, len = tokens.length - 1; i < len; i++) {
      if (tokens[i + 1].isEmpty && tokens[i + 2].isNotEmpty && extendedWordChars.hasMatch(tokens[i]) && extendedWordChars.hasMatch(tokens[i + 2])) {
        tokens[i] += tokens[i + 2];

        tokens.removeAt(i + 1);
        tokens.removeAt(i + 1);

        i--;
      }
    }

    return tokens;
  }
}