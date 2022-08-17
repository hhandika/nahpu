import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nahpu/models/project.dart';
import 'package:nahpu/providers/project.dart';

final projectFormNotifier =
    StateNotifierProvider<ProjectFormValidationNotifier, ProjectFormState>(
        (ref) => ProjectFormValidationNotifier());

class ProjectFormValidationNotifier extends StateNotifier<ProjectFormState> {
  ProjectFormValidationNotifier()
      : super(ProjectFormState(ProjectFormValidation.empty()));

  void validateProjectName(String? value) {
    state = state.copyWith(
        form: state.form.copyWith(
            projectName: state.form.projectName.copyWith(
                value: value,
                errMsg:
                    value == null || value.isEmpty || !value.isValidProjectName
                        ? "Project name cannot be empty"
                        : null)));
  }

  void checkProjectNameExists(WidgetRef ref, String? name) {
    ref.watch(databaseProvider).getProjectByName(name).then((value) => {
          if (value != null)
            {
              state = state.copyWith(
                  form: state.form.copyWith(
                      projectName: state.form.projectName.copyWith(
                          value: name, errMsg: "Project name already exists")))
            }
        });
  }

  void validateCollName(String? value) {
    state = state.copyWith(
        form: state.form.copyWith(
            collName: state.form.collName.copyWith(
                value: value,
                errMsg: value == null || value.isEmpty
                    ? "Collector name is not valid"
                    : null)));
  }

  void validateEmail(String? value) {
    state = state.copyWith(
        form: state.form.copyWith(
            email: state.form.email.copyWith(
                value: value,
                errMsg: value == null || value.isEmpty || !value.isValidEmail
                    ? "Email is not valid"
                    : null)));
  }

  void validateCollNum(String? value) {
    state = state.copyWith(
        form: state.form.copyWith(
            collNum: state.form.collNum.copyWith(
                value: value,
                errMsg: value == null || value.isEmpty || !value.isValidCollNum
                    ? "Collector number is not valid"
                    : null)));
  }
}

// void validateProjectName(String? value) {
//   state = state.copyWith(
//       form: state.form.copyWith(
//           projectName: state.form.projectName.copyWith(
//               fieldValue: value,
//               isValid: value != null && value.isNotEmpty,
//               errMsg: value == null || value.isEmpty
//                   ? 'Project name cannot be empty'
//                   : '')));
// }

// void checkProjectNameExists(WidgetRef ref, String? value) {
//   ref.read(databaseProvider).getProjectByName(value).then((value) => state =
//       state.copyWith(
//           form: state.form.copyWith(
//               collName: state.form.projectName.copyWith(
//                   fieldValue: '',
//                   isValid: value == null,
//                   errMsg:
//                       value != null ? 'Project name already exists' : ''))));
// }

// void validateName(String? value) {
//   state = state.copyWith(
//       form: state.form.copyWith(
//           collName: state.form.collName.copyWith(
//               fieldValue: value,
//               isValid: value != null && value.isNotEmpty,
//               errMsg: value == null || value.isEmpty
//                   ? 'Collector name cannot be empty'
//                   : '')));
// }

// void validateCollNum(String? value) {
//   state = state.copyWith(
//       form: state.form.copyWith(
//           collNum: state.form.collNum.copyWith(
//               fieldValue: value,
//               isValid: value != null && value.isNotEmpty,
//               errMsg: value == null || value.isEmpty
//                   ? 'Catalog number cannot be empty'
//                   : '')));
// }

// void validateEmail(String? value) {
//   state = state.copyWith(
//       form: state.form.copyWith(
//           email: state.form.email.copyWith(
//               fieldValue: value,
//               isValid: value != null && value.isNotEmpty,
//               errMsg: value == null || value.isEmpty
//                   ? 'Email cannot be empty'
//                   : '')));
// }

// class NewProjectValidation {
//   String? value;
//   String? error;

//   NewProjectValidation(this.value, this.error);
// }

// final newProjectValidationProvider = ChangeNotifierProvider<NewProjectNotifier>(
//     (ref) => NewProjectNotifier(ref));

// class NewProjectNotifier extends ChangeNotifier {
//   NewProjectNotifier(this.ref);
//   final Ref ref;

//   NewProjectValidation _projectName = NewProjectValidation(null, null);
//   NewProjectValidation _collNum = NewProjectValidation(null, null);
//   NewProjectValidation _collName = NewProjectValidation(null, null);
//   NewProjectValidation _email = NewProjectValidation(null, null);
//   NewProjectValidation get projectName => _projectName;
//   NewProjectValidation get collNum => _collNum;
//   NewProjectValidation get collName => _collName;
//   NewProjectValidation get email => _email;

//   void validateProjectName(String? value) {
//     if (value != null && value.isValidProjectName) {
//       _projectName = NewProjectValidation(value, null);
//     } else {
//       _projectName = NewProjectValidation(
//           value, 'Enter a valid project name (letter and numbers only)');
//     }
//     notifyListeners();
//   }

//   void checkProjectNameExists(BuildContext context, String? name) {
//     ref.watch(databaseProvider).getProjectByName(name).then((value) {
//       if (value != null) {
//         _projectName = NewProjectValidation(name, null);
//       } else {
//         _projectName = NewProjectValidation(
//             name, 'Project name already exists, please choose another one');
//       }
//       notifyListeners();
//     });
//   }

//   void validateCollNum(String? value) {
//     if (value != null && value.isValidCollNum) {
//       _collNum = NewProjectValidation(value, null);
//     } else {
//       _collNum = NewProjectValidation(value, 'Enter number only');
//     }
//     notifyListeners();
//   }

//   void validateCollName(String? value) {
//     if (value != null && value.isValidName) {
//       _collName = NewProjectValidation(value, null);
//     } else {
//       _collName = NewProjectValidation(value, 'Enter a valid name');
//     }
//     notifyListeners();
//   }

//   void validateEmail(String? value) {
//     if (value != null && value.isValidEmail) {
//       _email = NewProjectValidation(value, null);
//     } else {
//       _email = NewProjectValidation(value, 'Enter a valid email address');
//     }
//     notifyListeners();
//   }

//   bool get validate {
//     return _projectName.error == null &&
//         _collName.error == null &&
//         _collNum.error == null &&
//         _email.error == null;
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
