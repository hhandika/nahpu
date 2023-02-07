extension StringValidator on String {
  bool get isValidCollNum {
    final catNumRegex = RegExp(r'^[0-9]+$');
    return catNumRegex.hasMatch(this);
  }

  bool get isValidProjectName {
    final projectNameRegex = RegExp(r'^[a-zA-Z0-9-_ ]+$');
    return projectNameRegex.hasMatch(this);
  }

  bool get isValidName {
    final nameRegex = RegExp(r'^[\p{L}\p{Mn}\p{Pd}\s]+$', unicode: true);
    return nameRegex.hasMatch(this);
  }

  bool get isValidEmail {
    final emailRegex =
        RegExp(r'(^[a-zA-Z0-9_.]+[@]{1}[a-z0-9]+[\.][a-z](.)+$)');
    return emailRegex.hasMatch(this);
  }
}
