import 'package:dartdiff/src/diff/diff.dart' show Component;

import 'package:dartdiff/src/diff/util.dart' show analyzeHtml, patchHtml, HtmlObject, TextObject, Tuple;

String asHtml(List<Component> components) {
  final StringBuffer buffer = new StringBuffer();
  final List<Tuple> analyzed = <Tuple>[];

  for (int i=0, len=components.length; i<len; i++) analyzed.add(new Tuple(components[i], analyzeHtml(components[i].value)));

  //final List<dynamic> patched = patchHtml(analyzed);
  final List<dynamic> patched = analyzed;

  for (int i=0, len=patched.length; i<len; i++) {
    Tuple entry = patched[i];

    for (int j=0, len2=entry.analyzed.length; j<len2; j++) {
      bool isAdded = entry.component.isAdded == null ? false : entry.component.isAdded;
      bool isRemoved = entry.component.isRemoved == null ? false : entry.component.isRemoved;
      dynamic analyzed = entry.analyzed[j];

      if (analyzed is TextObject) {
        buffer.write(isAdded ? '<ins>' : isRemoved ? '<del>' : '');
        buffer.write(analyzed.text);
        buffer.write(isAdded ? '</ins>' : isRemoved ? '</del>' : '');
      } else if (analyzed is HtmlObject) {
        analyzed.fullTag = analyzed.fullTag.replaceAllMapped(new RegExp(r'<([/]*)([a-zA-Z]+)_[^ ]+(>|.*?[^?]>)'), (Match match) => '<${match.group(1)}${match.group(2)}${match.group(3)}');

        if (analyzed.isOpenTag) {
          if (analyzed.isVariable) {
            buffer.write('${analyzed.fullTag.substring(0, analyzed.fullTag.length - 1)} ${isAdded ? 'ins-var' : isRemoved ? 'del-var' : 'clear'}>');
          } else if (analyzed.isAnswerSelection) {
            buffer.write('${analyzed.fullTag.substring(0, analyzed.fullTag.length - 1)} ${isAdded ? 'ins-ans' : isRemoved ? 'del-ans' : 'clear'}>');
          } else {
            buffer.write('${analyzed.fullTag.substring(0, analyzed.fullTag.length - 1)} ${isAdded ? 'ins' : isRemoved ? 'del' : 'clear'}>');
          }
        } else if (analyzed.tagName.toLowerCase() != 'br') {
          buffer.write(analyzed.fullTag);
        }
      }
    }
  }

  return buffer.toString();
}