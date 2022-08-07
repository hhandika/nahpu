import 'package:flutter/cupertino.dart';

import 'package:nahpu/models/project.dart';

class NewProjectValidation {
  String? value;
  String? error;

  NewProjectValidation(this.value, this.error);
}

class NewProjectNotifier extends ChangeNotifier {
  NewProjectValidation _projectName = NewProjectValidation(null, null);
  NewProjectValidation _collNum = NewProjectValidation(null, null);
  NewProjectValidation _collName = NewProjectValidation(null, null);
  NewProjectValidation _email = NewProjectValidation(null, null);
  NewProjectValidation get projectName => _projectName;
  NewProjectValidation get collNum => _collNum;
  NewProjectValidation get collName => _collName;
  NewProjectValidation get email => _email;

  void validateProjectName(String? value) {
    if (value != null && value.isValidProjectName) {
      _projectName = NewProjectValidation(value, null);
    } else {
      _projectName = NewProjectValidation(
          value, 'Enter a valid project name (letter and numbers only)');
    }
    notifyListeners();
  }

  void checkProjectNameExists(BuildContext context, String? name) {
    ProjectModel(context: context).isProjectExists(name).then((isExists) {
      if (!isExists) {
        _projectName = NewProjectValidation(name, null);
      } else {
        _projectName = NewProjectValidation(
            name, 'Project name already exists, please choose another one');
      }
      notifyListeners();
    });
  }

  void validateCollNum(String? value) {
    if (value != null && value.isValidCollNum) {
      _collNum = NewProjectValidation(value, null);
    } else {
      _collNum = NewProjectValidation(value, 'Enter number only');
    }
    notifyListeners();
  }

  void validateCollName(String? value) {
    if (value != null && value.isValidName) {
      _collName = NewProjectValidation(value, null);
    } else {
      _collName = NewProjectValidation(value, 'Enter a valid name');
    }
    notifyListeners();
  }

  void validateEmail(String? value) {
    if (value != null && value.isValidEmail) {
      _email = NewProjectValidation(value, null);
    } else {
      _email = NewProjectValidation(value, 'Enter a valid email address');
    }
    notifyListeners();
  }

  bool get validate {
    return _projectName.error == null &&
        _collName.error == null &&
        _collNum.error == null &&
        _email.error == null;
  }
}

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
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    return emailRegex.hasMatch(this);
  }
}
