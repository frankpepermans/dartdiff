import 'package:dartdiff/src/diff/diff.dart' show Component;

List<dynamic> analyzeHtml(String value) {
  final RegExp tagKey = new RegExp(r'<([/]*)([a-zA-Z_\-\d]*)(>|.*?[^?]>)');
  final List<dynamic> result = <dynamic>[];
  int offset = 0;

  tagKey.allMatches(value)
    .forEach((Match match) {
      if (offset < match.start) result.add(new TextObject(value.substring(offset, match.start)));

      result.add(new HtmlObject(match.group(2),
        match.group(0),
        isOpenTag: match.group(1).isEmpty,
        isCloseTag: match.group(1).isNotEmpty,
        isVariable: match.group(0).contains(' var-key="'),
        isAnswerSelection: match.group(0).contains(' answer-id="')));

      offset = match.end;
    });

  if (offset < value.length) result.add(new TextObject(value.substring(offset, value.length)));

  return result;
}

List<Tuple> patchHtml(List<Tuple> list) {
  final List<Tuple> result = <Tuple>[];
  List<String> openTags = <String>[];

  for (int i=0, len=list.length; i<len; i++) {
    Tuple tuple = list[i];

    for (int k=0, len3=tuple.analyzed.length; k<len3; k++) {
      dynamic entry = tuple.analyzed[k];

      if (entry is HtmlObject) {
        if (entry.isOpenTag) {
          openTags.add(entry.tagName);

          result.add(new Tuple(tuple.component, <dynamic>[entry]));
        } else if (entry.isCloseTag) {
          openTags.remove(entry.tagName);

          if (entry.tagName.startsWith('SPAN_')) for (int j=0, len2=openTags.length; j<len2; j++) {
            String openTag = openTags[j];
            HtmlObject original = _findHtmlObject(list, openTag, false);

            result.add(new Tuple(tuple.component, <dynamic>[new HtmlObject.from(original)]));
          }

          result.add(new Tuple(tuple.component, <dynamic>[entry]));

          if (entry.tagName.startsWith('SPAN_')) for (int j=0, len2=openTags.length; j<len2; j++) {
            String openTag = openTags[j];
            HtmlObject original = _findHtmlObject(list, openTag, true);

            result.add(new Tuple(tuple.component, <dynamic>[new HtmlObject.from(original)]));
          }
        }
      } else {
        result.add(new Tuple(tuple.component, <dynamic>[entry]));
      }
    }
  }

  return result;
}

HtmlObject _findHtmlObject(List<Tuple> list, String tagToMatch, bool findOpenTag) {
  for (int i=0, len=list.length; i<len; i++) {
    Tuple tuple = list[i];

    for (int j=0, len2=tuple.analyzed.length; j<len2; j++) {
      dynamic entry = tuple.analyzed[j];

      if (entry is HtmlObject && (entry.isOpenTag == findOpenTag) && entry.tagName.compareTo(tagToMatch) == 0) return entry;
    }
  }

  return null;
}

class TextObject {

  final String text;

  TextObject(this.text);

}

class HtmlObject {

  final String tagName;
  final bool isCloseTag, isOpenTag, isVariable, isAnswerSelection;
  String fullTag;

  HtmlObject(this.tagName, this.fullTag, {this.isOpenTag: false, this.isCloseTag: false, this.isVariable: false, this.isAnswerSelection: false});

  factory HtmlObject.from(HtmlObject other) =>
      new HtmlObject(other.tagName, other.fullTag, isOpenTag: other.isOpenTag, isCloseTag: other.isCloseTag, isVariable: other.isVariable, isAnswerSelection: other.isAnswerSelection);

}

class Tuple {

  final Component component;
  final List<dynamic> analyzed;

  Tuple(this.component, this.analyzed);

}