import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nahpu/providers/database.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/database/project_queries.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/utility_services.dart';
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
  Future<ProjectForm> _fetch() {
    return Future.value(ProjectForm.empty());
  }

  @override
  FutureOr<ProjectForm> build() {
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

      if (!value.isValidProjectName) {
        return ProjectForm(
            projectName:
                ProjectFormField(errMsg: "Invalid characters", isValid: false));
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
}

@freezed
class PersonnelForm with _$PersonnelForm {
  const PersonnelForm._();

  const factory PersonnelForm({
    required PersonnelFormField name,
    required PersonnelFormField email,
    required PersonnelFormField initial,
    required PersonnelFormField collNum,
  }) = _PersonnelForm;

  factory PersonnelForm.empty() => PersonnelForm(
        name: PersonnelFormField(errMsg: null, isValid: false),
        email: PersonnelFormField(errMsg: null, isValid: true),
        initial: PersonnelFormField(errMsg: null, isValid: false),
        collNum: PersonnelFormField(errMsg: null, isValid: false),
      );

  bool get isValidCataloger =>
      name.isValid && email.isValid && initial.isValid && collNum.isValid;

  bool get isValidOther => name.isValid && email.isValid;
}

@freezed
class PersonnelFormField with _$PersonnelFormField {
  factory PersonnelFormField({
    required String? errMsg,
    @Default(false) bool isValid,
  }) = _PersonnelFormField;
}

@riverpod
class PersonnelFormValidator extends _$PersonnelFormValidator {
  Future<PersonnelForm> _fetch() {
    return Future.value(PersonnelForm.empty());
  }

  @override
  FutureOr<PersonnelForm> build() {
    return _fetch();
  }

  Future<void> validateAll(PersonnelFormCtrModel formCtr) async {
    await validateName(formCtr.nameCtr.text);
    await validateEmail(formCtr.emailCtr.text);
    await validateInitial(formCtr.initialCtr.text);
    await validateCollNum(formCtr.collectorNumCtr.text);
  }

  Future<void> validateName(String? value) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (value == null || value.isEmpty || state.value == null) {
        return state.value!
            .copyWith(name: PersonnelFormField(errMsg: null, isValid: false));
      }

      if (value.length < 3) {
        return state.value!.copyWith(
            name: PersonnelFormField(
                errMsg: "Name is too short", isValid: false));
      }

      if (!value.isValidName) {
        return state.value!.copyWith(
            name: PersonnelFormField(
                errMsg: "Invalid characters", isValid: false));
      }

      return state.value!
          .copyWith(name: PersonnelFormField(errMsg: null, isValid: true));
    });
  }

  Future<void> validateEmail(String? value) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // We allow email to be empty by default it is set to valid
      if (value == null || value.isEmpty || state.value == null) {
        return PersonnelForm.empty();
      }

      if (!value.isValidEmail) {
        return state.value!.copyWith(
            email: PersonnelFormField(
                errMsg: "Invalid email address", isValid: false));
      }

      return state.value!
          .copyWith(email: PersonnelFormField(errMsg: null, isValid: true));
    });
  }

  Future<void> validateInitial(String? value) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (value == null || value.isEmpty || state.value == null) {
        return state.value!.copyWith(
            initial: PersonnelFormField(errMsg: null, isValid: false));
      }

      if (value.length < 2) {
        return state.value!.copyWith(
            initial: PersonnelFormField(
                errMsg: "Initial is too short", isValid: false));
      }

      if (!value.isValidInitial) {
        return state.value!.copyWith(
            initial: PersonnelFormField(
                errMsg: "Invalid characters", isValid: false));
      }

      return state.value!
          .copyWith(initial: PersonnelFormField(errMsg: null, isValid: true));
    });
  }

  Future<void> validateCollNum(String? value) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (value == null || value.isEmpty || state.value == null) {
        return state.value!.copyWith(
            collNum: PersonnelFormField(errMsg: null, isValid: false));
      }

      if (!value.isValidCollNum) {
        return state.value!.copyWith(
            collNum: PersonnelFormField(
                errMsg: "Invalid collector number", isValid: false));
      }

      return state.value!
          .copyWith(collNum: PersonnelFormField(errMsg: null, isValid: true));
    });
  }
}

// final personnelFormValidation = StateNotifierProvider.autoDispose<
//     PersonnelFormValidationNotifier,
//     NewPersonnelFormState>((ref) => PersonnelFormValidationNotifier());

// class PersonnelFormValidationNotifier
//     extends StateNotifier<NewPersonnelFormState> {
//   PersonnelFormValidationNotifier()
//       : super(NewPersonnelFormState(NewPersonnelFormValidation.empty()));

//   void validateAll(PersonnelFormCtrModel personnelCtr) {
//     validateName(personnelCtr.nameCtr.text);
//     validateEmail(personnelCtr.emailCtr.text);
//     validateInitial(personnelCtr.initialCtr.text);
//     validateCollNum(personnelCtr.nextCollectorNumCtr.text);
//   }

//   void validateName(String? value) {
//     late NewPersonnelFormField nameField;

//     NewPersonnelFormValidation form =
//         state.form.copyWith(name: state.form.name.copyWith(value: value));

//     if (value == null || value.isEmpty) {
//       nameField =
//           form.name.copyWith(errMsg: "Name is required", isValid: false);
//     } else if (!value.isValidName) {
//       nameField = form.name.copyWith(errMsg: "Invalid name", isValid: false);
//     } else if (value.length < 3) {
//       nameField =
//           form.name.copyWith(errMsg: "Name is too short", isValid: false);
//     } else {
//       nameField = form.name.copyWith(errMsg: null, isValid: true);
//     }

//     state = state.copyWith(form: form.copyWith(name: nameField));
//   }

//   void validateEmail(String? value) {
//     late NewPersonnelFormField emailField;

//     NewPersonnelFormValidation form =
//         state.form.copyWith(email: state.form.email.copyWith(value: value));

//     if (value != null && value.isNotEmpty && !value.isValidEmail) {
//       emailField = form.email.copyWith(errMsg: "Invalid email", isValid: false);
//     } else {
//       emailField = form.email.copyWith(errMsg: null, isValid: true);
//     }

//     state = state.copyWith(form: form.copyWith(email: emailField));
//   }

//   void validateInitial(String? value) {
//     late NewPersonnelFormField initialField;

//     NewPersonnelFormValidation form =
//         state.form.copyWith(initial: state.form.initial.copyWith(value: value));

//     if (value == null || value.isEmpty) {
//       initialField =
//           form.initial.copyWith(errMsg: "Initial is required", isValid: false);
//     } else {
//       initialField = form.initial.copyWith(errMsg: null, isValid: true);
//     }

//     state = state.copyWith(form: form.copyWith(initial: initialField));
//   }

//   void validateCollNum(String? value) {
//     late NewPersonnelFormField collNumField;

//     NewPersonnelFormValidation form =
//         state.form.copyWith(collNum: state.form.collNum.copyWith(value: value));

//     if (value == null || value.isEmpty) {
//       collNumField = form.collNum
//           .copyWith(errMsg: "Collector number is required", isValid: false);
//     } else if (!value.isValidCollNum) {
//       collNumField =
//           form.collNum.copyWith(errMsg: "Invalid number", isValid: false);
//     } else {
//       collNumField = form.collNum.copyWith(errMsg: null, isValid: true);
//     }

//     state = state.copyWith(form: form.copyWith(collNum: collNumField));
//   }
// }
