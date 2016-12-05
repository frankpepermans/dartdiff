import 'dart:convert' show HtmlEscape;

import 'package:dartdiff/src/diff/diff.dart' show Component;

String asXml(List<Component> components) {
  final StringBuffer buffer = new StringBuffer();
  final HtmlEscape escape = const HtmlEscape();

  for (int i=0, len=components.length; i<len; i++) {
    Component component = components.elementAt(i);

    buffer.write(component.isAdded ? '<ins>' : component.isRemoved ? '<del>' : '');
    buffer.write(escape.convert(component.value));
    buffer.write(component.isAdded ? '</ins>' : component.isRemoved ? '</del>' : '');
  }

  return buffer.toString();
}