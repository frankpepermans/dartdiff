import 'dart:html';

import 'package:dartdiff/src/diff/diff.dart' show Diff;

import 'package:dartdiff/src/diff/character_diff.dart' show CharacterDiff;
import 'package:dartdiff/src/diff/word_diff.dart' show WordDiff;

class HtmlDiff extends Diff {

  final bool useCharacterDiff;

  HtmlDiff(String oldString, String newString, {this.useCharacterDiff: false}) : super(oldString, newString);

  @override List<String> tokenize(String value) {
    final DocumentFragment fragment = new DocumentFragment.html(value, treeSanitizer: NodeTreeSanitizer.trusted);

    return _flattenHtml(fragment);
  }

  List<String> _flattenHtml(Node node, {List<String> list}) {
    String tagName;

    if (node is Element) {
      Element nodeCast = node as Element;

      if (nodeCast.attributes.containsKey('repetition-id')) {
        node = new DocumentFragment.html(nodeCast.innerHtml, treeSanitizer: NodeTreeSanitizer.trusted);
      }

      if (nodeCast.attributes.containsKey('answer-id')) tagName = '${nodeCast.tagName}_${nodeCast.attributes['answer-id']}';
      else if (nodeCast.attributes.containsKey('var-key')) tagName = '${nodeCast.tagName}_${nodeCast.attributes['var-key']}';
      else tagName = nodeCast.tagName;
    }

    list ??= <String>[];

    if (node is Element) {
      if (node.attributes.isNotEmpty) list.add('<$tagName ${_flattenAttributes(node.attributes)}>');
      else list.add('<$tagName>');
    }

    node.childNodes.forEach((Node childNode) {
      if (childNode is Element) {
        _flattenHtml(childNode, list: list);
      } else {
        if (useCharacterDiff) list.addAll(new CharacterDiff('', '').tokenize(childNode.text));
        else list.addAll(new WordDiff('', '').tokenize(childNode.text));
      }
    });

    if (node is Element) list.add('</$tagName>');

    return list;
  }

  String _flattenAttributes(Map<String, String> attributes) {
    final List<String> list = <String>[];

    attributes.forEach((String K, String V) {
      if (K.toLowerCase() != 'uid' && K.toLowerCase() != 'class') {
        if (V.trim().isEmpty) {
          list.add(K);
        } else {
          list.add('$K="$V"');
        }
      }
    });

    return list.join(' ');
  }
}