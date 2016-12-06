import 'package:test/test.dart';

import 'package:dartdiff/dartdiff.dart';

main() {
  test("should diff whitespace", () {
    expect(asXml(new WordDiff('New Value', 'New  ValueMoreData').diff()), 'New<del> Value</del><ins>  ValueMoreData</ins>');
  });

  test("should diff multiple whitespace", () {
    expect(asXml(new WordDiff('New Value ', 'New  ValueMoreData  ').diff()), 'New<del> Value </del><ins>  ValueMoreData  </ins>');
  });

  test("should diff on word boundaries", () {
    expect(asXml(new WordDiff('New :Value:Test', 'New ValueMoreData').diff()), 'New<del> :Value:Test</del><ins> ValueMoreData</ins>');
  });

  test("should diff when there is no anchor value", () {
    expect(asXml(new WordDiff('New Value New Value', 'Value Value New New').diff()), '<del>New</del><ins>Value</ins> Value New <del>Value</del><ins>New</ins>');
  });
}