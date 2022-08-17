import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';

@freezed
class ProjectFormState with _$ProjectFormState {
  const factory ProjectFormState(ProjectFormValidation form) =
      _ProjectFormState;
}

@freezed
class ProjectFormField with _$ProjectFormField {
  factory ProjectFormField({
    required String? fieldValue,
    @Default('') String errMsg,
    @Default(false) bool isValid,
  }) = _ProjectName;
}

@freezed
class ProjectFormValidation with _$ProjectFormValidation {
  const ProjectFormValidation._();
  const factory ProjectFormValidation(
      {required ProjectFormField projectName,
      required ProjectFormField collName,
      required ProjectFormField email,
      required ProjectFormField collNum}) = _ProjectFormValidation;

  factory ProjectFormValidation.empty() => ProjectFormValidation(
      projectName: ProjectFormField(fieldValue: ''),
      collName: ProjectFormField(fieldValue: ''),
      email: ProjectFormField(fieldValue: ''),
      collNum: ProjectFormField(fieldValue: ''));

  bool get isValid =>
      projectName.isValid &&
      collName.isValid &&
      email.isValid &&
      collNum.isValid;
}
