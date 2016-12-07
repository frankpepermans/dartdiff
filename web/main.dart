import 'dart:html';

import 'package:dartdiff/dartdiff_html.dart';

final String A = '<div class="ng2-html-text-transform-text-area" spellcheck="false" contenteditable="true">DOOR EN TUSSEN:<br>(1) <span class="text-erased-fa638de-ea6a-79fb-3ee5-983f8264d04a" answer-id="fa638de-ea6a-79fb-3ee5-983f8264d04a"><span class="text-erased-6743805-8f17-d878-540a-498ff99beed0" var-key="6743805-8f17-d878-540a-498ff99beed0" contenteditable="true">[naam Aannemer]</span>, ingeschreven in de Kruispuntbank van Ondernemingen met ondernemingsnummer <span class="text-erased-b05fa7f-f9f6-d3f8-eaec-e6c5035cd485" var-key="b05fa7f-f9f6-d3f8-eaec-e6c5035cd485">[KBO Bouwheer]</span> &nbsp;en met maatschappelijke zetel gevestigd te <span class="text-erased-a6d2fe5-3e48-f347-eb96-6f94f90e6fa7" var-key="a6d2fe5-3e48-f347-eb96-6f94f90e6fa9">[adres Bouwheer]</span>, hierna genoemd de "Bouwheer"; &nbsp;</span><br><span class="text-erased-5f194c7-d164-3cda-27f1-94e8737cbd8" answer-id="5f194c7-d164-3cda-27f1-94e8737cbd8">De <span class="text-erased-86ea5fa-709b-7a24-13fc-1b28a3023314" var-key="86ea5fa-709b-7a24-13fc-1b28a3023314">[aanspreektitel en naam bouwheer]</span>, wonende te<span class="text-erased-c9b1a8e-f598-83fb-fdc9-7a432201e2" var-key="c9b1a8e-f598-83fb-fdc9-7a432201e2"> [adres Bouwheer]</span>,</span><br><br>EN:<br><br>(2) <span class="text-erased-7b05072-83a6-7d4f-c36e-415f9c0e68b2" var-key="7b05072-83a6-7d4f-c36e-415f9c0e68b2">[naam Aannemer]</span>, ingeschreven in de kruispuntbank van ondernemingen met KBO <span class="text-erased-fe9cdef-2278-814b-3e41-a68073ce744c" var-key="fe9cdef-2278-814b-3e41-a68073ce744c">[KBO Aannemer]</span> en met maatschappelijke zetel gevestigd te <span class="text-erased-76fe869-8621-df4c-5f32-ad4e89da5b62" var-key="76fe869-8621-df4c-5f32-ad4e89da5b62">[adres Aannemer]</span>, hierna genoemd de "Aannemer";<br><br>De partijen vermeld onder punten (1) tot en met (2) worden elk hierna afzonderlijk een "Partij" en gezamenlijk de "Partijen" genoemd.<br></div>';
final String B = '<div class="ng2-html-text-transform-text-area" spellcheck="false" contenteditable="true">DOOR EN TUSSEN:<br>(1) <span class="text-erased-fa638de-ea6a-79fb-3ee5-983f8264d04a" answer-id="fa638de-ea6a-79fb-3ee5-983f8264d04a"><span class="text-erased-6743805-8f17-d878-540a-498ff99beed0" var-key="6743805-8f17-d878-540a-498ff99beed0" contenteditable="true">[naam Bouwheer]</span>, ingeschreven in de Kruispuntbank van Ondernemingen met ondernemingsnummer <span class="text-erased-b05fa7f-f9f6-d3f8-eaec-e6c5035cd485" var-key="b05fa7f-f9f6-d3f8-eaec-e6c5035cd485">[KBO Bouwheer]</span> &nbsp;en met </span><span class="text-erased-a6d2fe5-3e48-f347-eb96-6f94f90e6fa9" var-key="a6d2fe5-3e48-f347-eb96-6f94f90e6fa9">[maatschappelijke zetel]</span> gevestigd te adres Bouwheer, hierna genoemd de "Bouwheer"; &nbsp;<br><span class="text-erased-5f194c7-d164-3cda-27f1-94e8737cbd8" answer-id="5f194c7-d164-3cda-27f1-94e8737cbd8">De <span class="text-erased-86ea5fa-709b-7a24-13fc-1b28a3023314" var-key="86ea5fa-709b-7a24-13fc-1b28a3023314">[aanspreektitel en naam bouwheer]</span>, wonende te<span class="text-erased-c9b1a8e-f598-83fb-fdc9-7a432201e2" var-key="c9b1a8e-f598-83fb-fdc9-7a432201e2"> [adres Bouwheer]</span>,</span><br><br>EN:<br><br>(2) <span class="text-erased-7b05072-83a6-7d4f-c36e-415f9c0e68b2" var-key="7b05072-83a6-7d4f-c36e-415f9c0e68b2">[naam Aannemer]</span>, ingeschreven in de Kruispuntbank van Ondernemingen met ondernemingsnummer <span class="text-erased-fe9cdef-2278-814b-3e41-a68073ce744c" var-key="fe9cdef-2278-814b-3e41-a68073ce744c">[KBO Aannemer]</span> en met maatschappelijke zetel gevestigd te <span class="text-erased-76fe869-8621-df4c-5f32-ad4e89da5b62" var-key="76fe869-8621-df4c-5f32-ad4e89da5b62">[adressen Aannemers]</span>, hierna genoemd de "Aannemer";<br><br>De partijen vermeld onder punten (1) tot en met (2) worden elk hierna afzonderlijk een "Partij" en gezamenlijk de "Partijen" genoemd.<br></div>';

DivElement output;

void main() {
  output = querySelector('#output');

  <Function>[
     () {
      final _Container container = _createResultContainers('Fix typo');
      final String A = 'Anyone who has never made a moistrake has never tried anything new.';
      final String B = 'Anyone who has never made a mistake has never tried anything new.';
      final Diff htmlDiff = new HtmlDiff(A, B, useCharacterDiff: false);

      container.original.setInnerHtml(A, treeSanitizer: NodeTreeSanitizer.trusted);
      container.changed.setInnerHtml(B, treeSanitizer: NodeTreeSanitizer.trusted);
      container.diff.setInnerHtml(asHtml(htmlDiff.diff()), treeSanitizer: NodeTreeSanitizer.trusted);
    }, () {
      final _Container container = _createResultContainers('Fix more complex typo');
      final String A = 'Anyone who has never made a moist rake has never tried anything new.';
      final String B = 'Anyone who has never made a mistake has never tried anything new.';
      final Diff htmlDiff = new HtmlDiff(A, B, useCharacterDiff: false);

      container.original.setInnerHtml(A, treeSanitizer: NodeTreeSanitizer.trusted);
      container.changed.setInnerHtml(B, treeSanitizer: NodeTreeSanitizer.trusted);
      container.diff.setInnerHtml(asHtml(htmlDiff.diff()), treeSanitizer: NodeTreeSanitizer.trusted);
    }, () {
       final _Container container = _createResultContainers('Text formatting');
       final String A = '<i>Anyone</i> who has never made a <b>mistake</b> has never tried anything new.';
       final String B = 'Anyone who has <i>never</i> made a mistake has never tried <b>anything</b> new.';
       final Diff htmlDiff = new HtmlDiff(A, B, useCharacterDiff: false);

       container.original.setInnerHtml(A, treeSanitizer: NodeTreeSanitizer.trusted);
       container.changed.setInnerHtml(B, treeSanitizer: NodeTreeSanitizer.trusted);
       container.diff.setInnerHtml(asHtml(htmlDiff.diff()), treeSanitizer: NodeTreeSanitizer.trusted);
     }, () {
      final _Container container = _createResultContainers('Append variable');
      final String A = 'Anyone who has never made a mistake has never tried anything new.';
      final String B = 'Anyone who has never made a <span var-key="abc">[mistake]</span> has never tried anything new.';
      final Diff htmlDiff = new HtmlDiff(A, B, useCharacterDiff: false);

      container.original.setInnerHtml(A, treeSanitizer: NodeTreeSanitizer.trusted);
      container.changed.setInnerHtml(B, treeSanitizer: NodeTreeSanitizer.trusted);
      container.diff.setInnerHtml(asHtml(htmlDiff.diff()), treeSanitizer: NodeTreeSanitizer.trusted);
    }, () {
      final _Container container = _createResultContainers('Remove variable');
      final String A = 'Anyone who has never made a <span var-key="abc">[mistake]</span> has never tried anything new.';
      final String B = 'Anyone who has never made a mistake has never tried anything new.';
      final Diff htmlDiff = new HtmlDiff(A, B, useCharacterDiff: false);

      container.original.setInnerHtml(A, treeSanitizer: NodeTreeSanitizer.trusted);
      container.changed.setInnerHtml(B, treeSanitizer: NodeTreeSanitizer.trusted);
      container.diff.setInnerHtml(asHtml(htmlDiff.diff()), treeSanitizer: NodeTreeSanitizer.trusted);
    }, () {
      final _Container container = _createResultContainers('New answer selection');
      final String A = 'Anyone who has never made a mistake has never tried anything new.';
      final String B = '<span answer-id="abc">Anyone who has never</span> made a mistake has never tried anything new.';
      final Diff htmlDiff = new HtmlDiff(A, B, useCharacterDiff: false);

      container.original.setInnerHtml(A, treeSanitizer: NodeTreeSanitizer.trusted);
      container.changed.setInnerHtml(B, treeSanitizer: NodeTreeSanitizer.trusted);
      container.diff.setInnerHtml(asHtml(htmlDiff.diff()), treeSanitizer: NodeTreeSanitizer.trusted);
    }, () {
      final _Container container = _createResultContainers('Removed answer selection');
      final String A = '<span answer-id="abc">Anyone who has never</span> made a mistake has never tried anything new.';
      final String B = 'Anyone who has never made a mistake has never tried anything new.';
      final Diff htmlDiff = new HtmlDiff(A, B, useCharacterDiff: false);

      container.original.setInnerHtml(A, treeSanitizer: NodeTreeSanitizer.trusted);
      container.changed.setInnerHtml(B, treeSanitizer: NodeTreeSanitizer.trusted);
      container.diff.setInnerHtml(asHtml(htmlDiff.diff()), treeSanitizer: NodeTreeSanitizer.trusted);
    }, () {
       final _Container container = _createResultContainers('Combine all');
       final String A = '<span answer-id="abc">Anyone <span var-key="abc">[who]</span> has never</span> made a mostake has <b>never</b> tried anything newest.';
       final String B = 'Anyone who <span answer-id="abc">has <span var-key="abc">[never]</span> made</span> a mistake has <i>never</i> tried <span var-key="abc">[anything]</span> new.';
       final Diff htmlDiff = new HtmlDiff(A, B, useCharacterDiff: false);

       container.original.setInnerHtml(A, treeSanitizer: NodeTreeSanitizer.trusted);
       container.changed.setInnerHtml(B, treeSanitizer: NodeTreeSanitizer.trusted);
       container.diff.setInnerHtml(asHtml(htmlDiff.diff()), treeSanitizer: NodeTreeSanitizer.trusted);print(asHtml(htmlDiff.diff()));
     }
  ].forEach((Function f) => f());
}

_Container _createResultContainers(String title) {
  final DivElement wrapper = new DivElement()..className = 'wrapper';
  final LabelElement label = new LabelElement()..className = 'title'..innerHtml = title;
  final LabelElement original_label = new LabelElement()..className = 'sub_title'..innerHtml = 'original version';
  final DivElement original = new DivElement()..className = 'result';
  final LabelElement changed_label = new LabelElement()..className = 'sub_title'..innerHtml = 'changed version';
  final DivElement changed = new DivElement()..className = 'result';
  final LabelElement diff_label = new LabelElement()..className = 'sub_title'..innerHtml = 'difference view';
  final DivElement diff = new DivElement()..className = 'result';

  wrapper.append(label);
  wrapper.append(original_label);
  wrapper.append(original);
  wrapper.append(changed_label);
  wrapper.append(changed);
  wrapper.append(diff_label);
  wrapper.append(diff);

  output.append(wrapper);

  return new _Container(original, changed, diff);
}

class _Container {

  final DivElement original, changed, diff;

  _Container(this.original, this.changed, this.diff);

}