import 'package:flutter/cupertino.dart';

// import 'package:nahpu/models/project.dart';

class NewProjectValidation {
  String? value;
  String? error;

  NewProjectValidation(this.value, this.error);
}

class NewProjectProvider extends ChangeNotifier {
  NewProjectValidation _projectName = NewProjectValidation(null, null);
  NewProjectValidation _collNum = NewProjectValidation(null, null);
  NewProjectValidation _email = NewProjectValidation(null, null);
  NewProjectValidation get email => _projectName;
  NewProjectValidation get password => _collNum;
  NewProjectValidation get phone => _email;

  void validateCollNumber(String? value) {
    if (value != null && value.isValidCollNum) {
      _collNum = NewProjectValidation(value, null);
    } else {
      _collNum = NewProjectValidation(value, 'Enter a valid collection number');
    }
    notifyListeners();
  }

  void validateProjectName(String? value) {
    if (value != null && value.isValidProjectName) {
      _projectName = NewProjectValidation(value, null);
    } else {
      _projectName = NewProjectValidation(value, 'Enter a valid project name');
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

  // Future _checkProjectName() async {
  //   bool isExist = await ProjectModel(context: context)
  //       .isProjectExists(projectNameController.text);
  // }
}

// Future _checkProjectName() async {
//   _validationMsg = null;
//   setState(() {});

//   if (projectNameController.text.isEmpty) {
//     _validationMsg = 'Project name is required';
//     setState(() {});
//     return;
//   }

//   bool isExist = await ProjectModel(context: context)
//       .isProjectExists(projectNameController.text);
//   if (isExist) {
//     _validationMsg = 'Project name already exists';
//     return;
//   }
// }

extension StringValidator on String {
  bool get isValidCollNum {
    final catNumRegex = RegExp(r'^[0-9]+$');
    return catNumRegex.hasMatch(this);
  }

  bool get isValidProjectName {
    final projectNameRegex = RegExp(r'^[a-zA-Z0-9-_ ]+$');
    return projectNameRegex.hasMatch(this);
  }

  bool get isValidEmail {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    return emailRegex.hasMatch(this);
  }
}
