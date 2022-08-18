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
    late ProjectFormField projectNameField;

    ProjectFormValidation form = state.form
        .copyWith(projectName: state.form.projectName.copyWith(value: value));

    if (value == null || value.isEmpty) {
      projectNameField =
          form.projectName.copyWith(errMsg: "Project name is required");
    } else if (value.length < 3) {
      projectNameField =
          form.projectName.copyWith(errMsg: "Project name is too short");
    } else {
      projectNameField = form.projectName.copyWith(errMsg: null, isValid: true);
    }

    state = state.copyWith(form: form.copyWith(projectName: projectNameField));
  }

  void checkProjectNameExists(WidgetRef ref, String? name) {
    ref.watch(databaseProvider).getProjectByName(name).then((value) => {
          if (value != null)
            {
              state = state.copyWith(
                  form: state.form.copyWith(
                      projectName: state.form.projectName.copyWith(
                          value: name,
                          errMsg: "Project name already exists",
                          isValid: false)))
            }
        });
  }

  void validateCollName(String? value) {
    late ProjectFormField collNameField;

    ProjectFormValidation form = state.form
        .copyWith(collName: state.form.collName.copyWith(value: value));

    if (value == null || value.isEmpty) {
      collNameField =
          form.collName.copyWith(errMsg: "Collector name is required");
    } else if (!value.isValidName) {
      collNameField = form.collName.copyWith(errMsg: "Invalid name");
    } else if (value.length < 3) {
      collNameField =
          form.collName.copyWith(errMsg: "Collector name is too short");
    } else {
      collNameField = form.collName.copyWith(errMsg: null, isValid: true);
    }

    state = state.copyWith(form: form.copyWith(collName: collNameField));
  }

  void validateEmail(String? value) {
    late ProjectFormField emailField;

    ProjectFormValidation form =
        state.form.copyWith(email: state.form.email.copyWith(value: value));

    if (value == null || value.isEmpty) {
      emailField = form.email.copyWith(errMsg: "Email is required");
    } else if (!value.isValidEmail) {
      emailField = form.email.copyWith(errMsg: "Invalid email");
    } else {
      emailField = form.email.copyWith(errMsg: null, isValid: true);
    }

    state = state.copyWith(form: form.copyWith(email: emailField));
  }

  void validateCollNum(String? value) {
    late ProjectFormField collNumField;

    ProjectFormValidation form =
        state.form.copyWith(collNum: state.form.collNum.copyWith(value: value));

    if (value == null || value.isEmpty) {
      collNumField =
          form.collNum.copyWith(errMsg: "Collector number is required");
    } else if (!value.isValidCollNum) {
      collNumField = form.collNum.copyWith(errMsg: "Invalid number");
    } else {
      collNumField = form.collNum.copyWith(errMsg: null, isValid: true);
    }

    state = state.copyWith(form: form.copyWith(collNum: collNumField));
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
