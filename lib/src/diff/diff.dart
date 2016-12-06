import 'dart:math';

abstract class Diff {

  final String oldString, newString;
  List<String> oldTokens, newTokens;

  bool useLongestToken = false;

  Diff(this.oldString, this.newString) {
    oldTokens = tokenize(oldString);
    newTokens = tokenize(newString);
  }

  List<Component> diff({Map<String, dynamic> options}) {
    final int newLen = newTokens.length, oldLen = oldTokens.length;
    final int maxEditLength = newLen + oldLen;
    final Map<int, _Path> bestPath = <int, _Path>{0: new _Path(newPos: -1, components: <Component>[])};
    final int oldPos = _extractCommon(bestPath.values.first, 0);
    int editLength = 1;

    if (bestPath.values.first.newPos + 1 >= newLen && oldPos + 1 >= oldLen) {
      return <Component>[new Component(count: newTokens.length, value: join(newTokens))];
    }

    while (editLength <= maxEditLength) {
      List<Component> components = _execEditLength(bestPath, editLength);

      if (components != null) return components;

      editLength++;
    }

    return null;
  }

  List<String> tokenize(String value) => value.split('');

  bool equals(String a, String b) => a.compareTo(b) == 0;

  String join(Iterable<String> characters) => characters.join('');

  List<Component> _execEditLength(Map<int, _Path> bestPath, int editLength) {
    final int newLen = newTokens.length, oldLen = oldTokens.length;

    for (int diagonalPath = -1 * editLength; diagonalPath <= editLength; diagonalPath += 2) {
      _Path basePath;
      _Path addPath = bestPath[diagonalPath - 1];
      _Path removePath = bestPath[diagonalPath + 1];
      int oldPos = (removePath != null ? removePath.newPos : 0) - diagonalPath;

      if (addPath != null) bestPath[diagonalPath - 1] = null;

      bool canAdd = (addPath != null) && (addPath.newPos + 1 < newLen);
      bool canRemove = (removePath != null) && 0 <= oldPos && oldPos < oldLen;

      if (!canAdd && !canRemove) {
        bestPath[diagonalPath] = null;

        continue;
      }

      if (!canAdd || (canRemove && addPath.newPos < removePath.newPos)) {
        basePath = new _Path.cloned(removePath);

        _pushComponent(basePath.components, null, true);
      } else {
        basePath = addPath;

        basePath.newPos++;

        _pushComponent(basePath.components, true, null);
      }

      oldPos = _extractCommon(basePath, diagonalPath);

      if ((basePath.newPos + 1) >= newLen && (oldPos + 1) >= oldLen) {
        return _buildValues(basePath.components, useLongestToken);
      } else {
        bestPath[diagonalPath] = basePath;
      }
    }

    return null;
  }

  void _pushComponent(List<Component> components, bool isAdded, bool isRemoved) {
    final Component last = components.isNotEmpty ? components.last : null;

    if (last != null && last.isAdded == isAdded && last.isRemoved == isRemoved) {
      components[components.length - 1] = new Component(count: last.count + 1, isAdded: isAdded, isRemoved: isRemoved);
    } else {
      components.add(new Component(count: 1, isAdded: isAdded, isRemoved: isRemoved));
    }
  }

  List<Component> _buildValues(List<Component> components, bool useLongestToken) {
    final int componentLen = components.length;
    int componentPos = 0;
    int newPos = 0;
    int oldPos = 0;

    for (; componentPos < componentLen; componentPos++) {
      Component component = components.elementAt(componentPos);

      component.isAdded = component.isAdded == null ? false : component.isAdded;
      component.isRemoved = component.isRemoved == null ? false : component.isRemoved;

      if (!component.isRemoved) {
        if (!component.isAdded && useLongestToken) {
          int i = 0;

          component.value = join(newTokens
            .sublist(newPos, newPos + component.count)
            .map((String value) {
              final String oldValue = oldTokens[oldPos + i++];

              return oldValue.length > value.length ? oldValue : value;
            }));
        } else {
          component.value = join(newTokens.sublist(newPos, newPos + component.count));
        }

        newPos += component.count;

        if (!component.isAdded) oldPos += component.count;
      } else {
        component.value = join(oldTokens.sublist(oldPos, oldPos + component.count));

        oldPos += component.count;

        Component last = components.elementAt(componentPos - 1);

        if (componentPos != 0 && last.isAdded) {
          Component tmp = last;

          components[componentPos - 1] = components.elementAt(componentPos);
          components[componentPos] = tmp;
        }
      }
    }

    Component lastComponent = components.elementAt(componentLen - 1);

    if (componentLen > 1 && (lastComponent.isAdded || lastComponent.isRemoved) && lastComponent.value.isEmpty) {
      components[componentLen - 2].value += lastComponent.value;
      components.removeLast();
    }

    return components;
  }

  int _extractCommon(_Path basePath, int diagonalPath) {
    final int newLen = newTokens.length;
    final int oldLen = oldTokens.length;
    int newPos = basePath.newPos;
    int oldPos = newPos - diagonalPath;
    int commonCount = 0;

    while ((newPos + 1) < newLen && (oldPos + 1) < oldLen && equals(newTokens[newPos + 1], oldTokens[oldPos + 1])) {
      newPos++;
      oldPos++;
      commonCount++;
    }

    if (commonCount > 0) basePath.components.add(new Component(count: commonCount));

    basePath.newPos = newPos;

    return oldPos;
  }

}

class _Path {

  int newPos;
  List<Component> components;
  bool isEmpty;

  _Path({this.newPos, this.components, this.isEmpty: false});

  factory _Path.cloned(_Path path) => new _Path(newPos: path.newPos, components: new List<Component>.from(path.components));

}

class Component {

  int count;
  bool isAdded, isRemoved;
  String value;

  Component({this.count, this.isAdded, this.isRemoved, this.value});

  @override String toString() => value;

}