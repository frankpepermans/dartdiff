import 'package:dartdiff/src/diff/diff.dart' show Component;

import 'package:dartdiff/src/diff/util.dart' show analyzeHtml, HtmlObject, TextObject;

String asHtml(List<Component> components) {
  final StringBuffer buffer = new StringBuffer();

  for (int i=0, len=components.length; i<len; i++) {
    final Component component = components.elementAt(i);
    final List<dynamic> result = analyzeHtml(component.value);

    result.forEach((dynamic entry) {
      if (entry is TextObject) {
        buffer.write(component.isAdded ? '<ins>' : component.isRemoved ? '<del>' : '');
        buffer.write(entry.text);
        buffer.write(component.isAdded ? '</ins>' : component.isRemoved ? '</del>' : '');
      } else if (entry is HtmlObject) {
        entry.fullTag = entry.fullTag.replaceAllMapped(new RegExp(r'<([/]*)([a-zA-Z]+)_[\d]+(>|.*?[^?]>)'), (Match match) => '<${match.group(1)}${match.group(2)}${match.group(3)}');

        if (entry.isOpenTag) {
          if (entry.isVariable) {
            buffer.write('${entry.fullTag.substring(0, entry.fullTag.length - 1)} ${component.isAdded ? 'ins-var' : 'del-var'}>');
          } else if (entry.isAnswerSelection) {
            buffer.write('${entry.fullTag.substring(0, entry.fullTag.length - 1)} ${component.isAdded ? 'ins-ans' : 'del-ans'}>');
          } else {
            buffer.write('${entry.fullTag.substring(0, entry.fullTag.length - 1)} ${component.isAdded ? 'ins' : 'del'}>');
          }
        } else {
          buffer.write(entry.fullTag);
        }
      }
    });
  }

  return buffer.toString();
}