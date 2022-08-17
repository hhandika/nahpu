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
    required String? value,
    required String? errMsg,
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
      projectName: ProjectFormField(value: null, errMsg: null),
      collName: ProjectFormField(value: null, errMsg: null),
      email: ProjectFormField(value: null, errMsg: null),
      collNum: ProjectFormField(value: null, errMsg: null));

  bool get isValid => projectName.errMsg == null && collName.errMsg == null;
  // email.errMsg == null &&
  // collNum.errMsg == null;
}
