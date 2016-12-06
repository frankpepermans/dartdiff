import 'dart:html';

import 'package:dartdiff/src/diff/diff.dart' show Diff;

import 'package:dartdiff/src/diff/word_diff.dart' show WordDiff;

class HtmlDiff extends Diff {

  HtmlDiff(String oldString, String newString) : super(oldString, newString);

  @override List<String> tokenize(String value) {
    final DocumentFragment fragment = new DocumentFragment.html(value, treeSanitizer: NodeTreeSanitizer.trusted);

    return _flattenHtml(fragment);
  }

  List<String> _flattenHtml(Node node, {List<String> list}) {
    list ??= <String>[];

    if (node is Element) {
      if (node.attributes.isNotEmpty) list.add('<${node.tagName} ${_flattenAttributes(node.attributes)}>');
      else list.add('<${node.tagName}>');
    }

    node.childNodes.forEach((Node childNode) {
      if (childNode is Element) {
        _flattenHtml(childNode, list: list);
      } else {
        list.addAll(new WordDiff(oldString, newString).tokenize(childNode.text));
      }
    });

    if (node is Element) {
      list.add('</${node.tagName}>');
    }

    return list;
  }

  String _flattenAttributes(Map<String, String> attributes) {
    final List<String> list = <String>[];

    attributes.forEach((String K, String V) {
      if (V.trim().isEmpty) {
        list.add(K);
      } else {
        list.add('$K="$V"');
      }
    });

    return list.join(' ');
  }
}