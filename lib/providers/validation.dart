import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nahpu/providers/database.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/project_queries.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/validation.dart';
import 'package:nahpu/services/utility_services.dart';
import 'package:nahpu/services/validation_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'validation.g.dart';
part 'validation.freezed.dart';

@freezed
class ProjectForm with _$ProjectForm {
  const ProjectForm._();

  const factory ProjectForm({
    required ProjectFormField projectName,
  }) = _ProjectForm;

  factory ProjectForm.empty() => ProjectForm(
        projectName: ProjectFormField(errMsg: null, isValid: false),
      );

  bool get isValid => projectName.isValid;
}

@freezed
class ProjectFormField with _$ProjectFormField {
  factory ProjectFormField({
    required String? errMsg,
    @Default(false) bool isValid,
  }) = _ProjectName;
}

@riverpod
class ProjectFormValidator extends _$ProjectFormValidator {
  Stream<ProjectForm> _fetch() {
    return Stream.fromFuture(Future.value(ProjectForm.empty()));
  }

  @override
  Stream<ProjectForm> build() {
    return _fetch();
  }

  Future<void> validateProjectName(String? value) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (value == null || value.isEmpty) {
        return ProjectForm(
            projectName: ProjectFormField(errMsg: null, isValid: false));
      }

      if (value.length < 3) {
        return ProjectForm(
            projectName: ProjectFormField(
                errMsg: "Project name is too short", isValid: false));
      }

      if (value.length > 25) {
        return ProjectForm(
            projectName: ProjectFormField(
                errMsg: "Project name is too long", isValid: false));
      }

      return ProjectForm(
          projectName: ProjectFormField(errMsg: null, isValid: true));
    });
  }

  Future<void> checkProjectNameExists(String? value) async {
    if (value == null && value!.isEmpty) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      List<ProjectData?> data =
          await ProjectQuery(ref.read(databaseProvider)).getAllProjects();
      if (data.isEmpty) {
        return ProjectForm(
            projectName: ProjectFormField(errMsg: null, isValid: true));
      }

      bool isMatch = _findMatching(data, value);
      if (isMatch) {
        return ProjectForm(
            projectName: ProjectFormField(
                errMsg: "Project name already exists", isValid: false));
      }
      return ProjectForm(
          projectName: ProjectFormField(errMsg: null, isValid: true));
    });
  }

  bool _findMatching(List<ProjectData?> data, String value) {
    List<String> projectNames =
        data.map((e) => e != null ? e.name : "").toList();
    bool isMatch = isListContains(projectNames, value);
    return isMatch;
  }

  Future<void> validateAll(ProjectFormCtrModel projectCtr) async {
    await validateProjectName(projectCtr.projectNameCtr.text);
  }
}

final personnelFormValidation = StateNotifierProvider.autoDispose<
    PersonnelFormValidationNotifier,
    NewPersonnelFormState>((ref) => PersonnelFormValidationNotifier());

class PersonnelFormValidationNotifier
    extends StateNotifier<NewPersonnelFormState> {
  PersonnelFormValidationNotifier()
      : super(NewPersonnelFormState(NewPersonnelFormValidation.empty()));

  void validateAll(PersonnelFormCtrModel personnelCtr) {
    validateName(personnelCtr.nameCtr.text);
    validateEmail(personnelCtr.emailCtr.text);
    validateInitial(personnelCtr.initialCtr.text);
    validateCollNum(personnelCtr.nextCollectorNumCtr.text);
  }

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
}
