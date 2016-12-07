List<dynamic> analyzeHtml(String value) {
  final RegExp tagKey = new RegExp(r'<([/]*)([a-zA-Z]*)(>|.*?[^?]>)');
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

class TextObject {

  final String text;

  TextObject(this.text);

}

class HtmlObject {

  final String tagName;
  final bool isCloseTag, isOpenTag, isVariable, isAnswerSelection;
  String fullTag;

  HtmlObject(this.tagName, this.fullTag, {this.isOpenTag: false, this.isCloseTag: false, this.isVariable: false, this.isAnswerSelection: false});

}