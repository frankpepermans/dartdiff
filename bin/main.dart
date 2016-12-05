import 'package:dartdiff/dartdiff.dart';

void main(List<String> args) {
  final Diff characterDiff = new CharacterDiff('The clock tick along steadily', 'The car ticks along steadily');
  final Diff wordDiff = new WordDiff('The clock tick along steadily', 'The car ticks along steadily');
  List<Component> resultA = characterDiff.diff();
  List<Component> resultB = wordDiff.diff();

  resultA ??= <Component>[];


  print(asXml(resultA));
  print('New  <del>Value</del><ins>ValueMoreData</ins>');
  print(asXml(resultB));
}
