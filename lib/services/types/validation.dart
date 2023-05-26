import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation.freezed.dart';

@freezed
class ProjectFormState with _$ProjectFormState {
  const factory ProjectFormState(ProjectFormValidation form) =
      _ProjectFormState;
}

@freezed
class ProjectFormValidation with _$ProjectFormValidation {
  const ProjectFormValidation._();
  const factory ProjectFormValidation({required ProjectFormField projectName}) =
      _ProjectFormValidation;

  factory ProjectFormValidation.empty() => ProjectFormValidation(
        projectName: ProjectFormField(value: null, errMsg: null),
      );

  bool get isValid => projectName.isValid;
}

@freezed
class ProjectFormField with _$ProjectFormField {
  factory ProjectFormField({
    required String? value,
    required String? errMsg,
    @Default(false) bool isValid,
  }) = _ProjectName;
}

@freezed
class NewPersonnelFormState with _$NewPersonnelFormState {
  const factory NewPersonnelFormState(NewPersonnelFormValidation form) =
      _NewPersonnelFormState;
}

@freezed
class NewPersonnelFormValidation with _$NewPersonnelFormValidation {
  const NewPersonnelFormValidation._();
  const factory NewPersonnelFormValidation({
    required NewPersonnelFormField name,
    required NewPersonnelFormField email,
    required NewPersonnelFormField initial,
    required NewPersonnelFormField collNum,
  }) = _NewPersonnelFormValidation;

  factory NewPersonnelFormValidation.empty() => NewPersonnelFormValidation(
      name: NewPersonnelFormField(value: null, errMsg: null),
      email: NewPersonnelFormField(value: null, errMsg: null),
      initial: NewPersonnelFormField(value: null, errMsg: null),
      collNum: NewPersonnelFormField(value: null, errMsg: null));

  bool get isValidCataloger =>
      name.isValid && initial.isValid && collNum.isValid;
  bool get isValid => name.isValid;
}

@freezed
class NewPersonnelFormField with _$NewPersonnelFormField {
  factory NewPersonnelFormField({
    required String? value,
    required String? errMsg,
    @Default(false) bool isValid,
  }) = _NewPersonnelFormField;
}
