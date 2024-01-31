
extension Extension on Map {
  dynamic tryGet(dynamic key, {dynamic Function()? ifnull}) =>
      containsKey(key) && this[key] != null
          ? this[key]
          : ifnull == null
              ? null
              : ifnull();
}

extension ExtensionJson on Map<String, dynamic> {
  dynamic tryPath(String path) {
    final index = path.indexOf("/");
    if (index < 0) return tryGet(path);

    final parent = tryGet(path.substring(0, index));
    if (parent == null) {
      return null;
    } else {
      return (parent as Map<String, dynamic>)
          .tryPath(path.substring(index + 1));
    }
  }

  void setPath(String path, dynamic value) {
    final index = path.indexOf("/");
    if (index < 0) {
      this[path] = value;
    } else {
      final key = path.substring(0, index);
      final Map<String, dynamic> parent = tryGet(key, ifnull: () {
        this[key] = <String, dynamic>{};
        return this[key];
      });
      parent.setPath(path.substring(index + 1), value);
    }
  }
}
