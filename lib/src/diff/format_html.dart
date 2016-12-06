import 'package:dartdiff/src/diff/diff.dart' show Component;

String asHtml(List<Component> components) {
  final StringBuffer buffer = new StringBuffer();

  for (int i=0, len=components.length; i<len; i++) {
    final Component component = components.elementAt(i);

    buffer.write(component.isAdded ? '<ins>' : component.isRemoved ? '<del>' : '');
    buffer.write(component.value.replaceAll('>', ' ${component.isAdded ? 'ins' : component.isRemoved ? 'del' : ''}>'));
    buffer.write(component.isAdded ? '</ins>' : component.isRemoved ? '</del>' : '');
  }

  return buffer.toString();
}