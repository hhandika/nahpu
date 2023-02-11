import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/validation.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/validation_services.dart';

final projectFormValidation = StateNotifierProvider.autoDispose<
    ProjectFormValidationNotifier,
    ProjectFormState>((ref) => ProjectFormValidationNotifier());

class ProjectFormValidationNotifier extends StateNotifier<ProjectFormState> {
  ProjectFormValidationNotifier()
      : super(ProjectFormState(ProjectFormValidation.empty()));

  void validateProjectName(String? value) {
    late ProjectFormField projectNameField;

    ProjectFormValidation form = state.form
        .copyWith(projectName: state.form.projectName.copyWith(value: value));

    if (value == null || value.isEmpty) {
      projectNameField = form.projectName
          .copyWith(errMsg: "Project name is required", isValid: false);
    } else if (value.length < 3) {
      projectNameField = form.projectName
          .copyWith(errMsg: "Project name is too short", isValid: false);
    } else if (value.length > 25) {
      projectNameField = form.projectName
          .copyWith(errMsg: "Project name is too long", isValid: false);
    } else {
      projectNameField = form.projectName.copyWith(errMsg: null, isValid: true);
    }

    state = state.copyWith(form: form.copyWith(projectName: projectNameField));
  }

  void checkProjectNameExists(WidgetRef ref, String name) {
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

  void isEditing() {
    state = state.copyWith(form: ProjectFormValidation.isValid());
  }
}

final personnelFormValidation = StateNotifierProvider.autoDispose<
    PersonnelFormValidationNotifier,
    NewPersonnelFormState>((ref) => PersonnelFormValidationNotifier());

class PersonnelFormValidationNotifier
    extends StateNotifier<NewPersonnelFormState> {
  PersonnelFormValidationNotifier()
      : super(NewPersonnelFormState(NewPersonnelFormValidation.empty()));

  void validateName(String? value) {
    late NewPersonnelFormField nameField;

    NewPersonnelFormValidation form =
        state.form.copyWith(name: state.form.name.copyWith(value: value));

    if (value == null || value.isEmpty) {
      nameField =
          form.name.copyWith(errMsg: "Name is required", isValid: false);
    } else if (!value.isValidName) {
      nameField = form.name.copyWith(errMsg: "Invalid name", isValid: false);
    } else if (value.length < 3) {
      nameField =
          form.name.copyWith(errMsg: "Name is too short", isValid: false);
    } else {
      nameField = form.name.copyWith(errMsg: null, isValid: true);
    }

    state = state.copyWith(form: form.copyWith(name: nameField));
  }

  void validateEmail(String? value) {
    late NewPersonnelFormField emailField;

    NewPersonnelFormValidation form =
        state.form.copyWith(email: state.form.email.copyWith(value: value));

    if (value != null && value.isNotEmpty && !value.isValidEmail) {
      emailField = form.email.copyWith(errMsg: "Invalid email", isValid: false);
    } else {
      emailField = form.email.copyWith(errMsg: null, isValid: true);
    }

    state = state.copyWith(form: form.copyWith(email: emailField));
  }

  void validateInitial(String? value) {
    late NewPersonnelFormField initialField;

    NewPersonnelFormValidation form =
        state.form.copyWith(initial: state.form.initial.copyWith(value: value));

    if (value == null || value.isEmpty) {
      initialField =
          form.initial.copyWith(errMsg: "Initial is required", isValid: false);
    } else {
      initialField = form.initial.copyWith(errMsg: null, isValid: true);
    }

    state = state.copyWith(form: form.copyWith(initial: initialField));
  }

  void validateCollNum(String? value) {
    late NewPersonnelFormField collNumField;

    NewPersonnelFormValidation form =
        state.form.copyWith(collNum: state.form.collNum.copyWith(value: value));

    if (value == null || value.isEmpty) {
      collNumField = form.collNum
          .copyWith(errMsg: "Collector number is required", isValid: false);
    } else if (!value.isValidCollNum) {
      collNumField =
          form.collNum.copyWith(errMsg: "Invalid number", isValid: false);
    } else {
      collNumField = form.collNum.copyWith(errMsg: null, isValid: true);
    }

    state = state.copyWith(form: form.copyWith(collNum: collNumField));
  }

  void isEditing() {
    state = state.copyWith(form: NewPersonnelFormValidation.isValid());
  }
}
