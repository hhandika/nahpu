// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProjectFormState {
  ProjectFormValidation get form => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectFormStateCopyWith<ProjectFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectFormStateCopyWith<$Res> {
  factory $ProjectFormStateCopyWith(
          ProjectFormState value, $Res Function(ProjectFormState) then) =
      _$ProjectFormStateCopyWithImpl<$Res>;
  $Res call({ProjectFormValidation form});

  $ProjectFormValidationCopyWith<$Res> get form;
}

/// @nodoc
class _$ProjectFormStateCopyWithImpl<$Res>
    implements $ProjectFormStateCopyWith<$Res> {
  _$ProjectFormStateCopyWithImpl(this._value, this._then);

  final ProjectFormState _value;
  // ignore: unused_field
  final $Res Function(ProjectFormState) _then;

  @override
  $Res call({
    Object? form = freezed,
  }) {
    return _then(_value.copyWith(
      form: form == freezed
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as ProjectFormValidation,
    ));
  }

  @override
  $ProjectFormValidationCopyWith<$Res> get form {
    return $ProjectFormValidationCopyWith<$Res>(_value.form, (value) {
      return _then(_value.copyWith(form: value));
    });
  }
}

/// @nodoc
abstract class _$$_ProjectFormStateCopyWith<$Res>
    implements $ProjectFormStateCopyWith<$Res> {
  factory _$$_ProjectFormStateCopyWith(
          _$_ProjectFormState value, $Res Function(_$_ProjectFormState) then) =
      __$$_ProjectFormStateCopyWithImpl<$Res>;
  @override
  $Res call({ProjectFormValidation form});

  @override
  $ProjectFormValidationCopyWith<$Res> get form;
}

/// @nodoc
class __$$_ProjectFormStateCopyWithImpl<$Res>
    extends _$ProjectFormStateCopyWithImpl<$Res>
    implements _$$_ProjectFormStateCopyWith<$Res> {
  __$$_ProjectFormStateCopyWithImpl(
      _$_ProjectFormState _value, $Res Function(_$_ProjectFormState) _then)
      : super(_value, (v) => _then(v as _$_ProjectFormState));

  @override
  _$_ProjectFormState get _value => super._value as _$_ProjectFormState;

  @override
  $Res call({
    Object? form = freezed,
  }) {
    return _then(_$_ProjectFormState(
      form == freezed
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as ProjectFormValidation,
    ));
  }
}

/// @nodoc

class _$_ProjectFormState implements _ProjectFormState {
  const _$_ProjectFormState(this.form);

  @override
  final ProjectFormValidation form;

  @override
  String toString() {
    return 'ProjectFormState(form: $form)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectFormState &&
            const DeepCollectionEquality().equals(other.form, form));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(form));

  @JsonKey(ignore: true)
  @override
  _$$_ProjectFormStateCopyWith<_$_ProjectFormState> get copyWith =>
      __$$_ProjectFormStateCopyWithImpl<_$_ProjectFormState>(this, _$identity);
}

abstract class _ProjectFormState implements ProjectFormState {
  const factory _ProjectFormState(final ProjectFormValidation form) =
      _$_ProjectFormState;

  @override
  ProjectFormValidation get form;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectFormStateCopyWith<_$_ProjectFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProjectFormValidation {
  ProjectFormField get projectName => throw _privateConstructorUsedError;
  ProjectFormField get collName => throw _privateConstructorUsedError;
  ProjectFormField get email => throw _privateConstructorUsedError;
  ProjectFormField get collNum => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectFormValidationCopyWith<ProjectFormValidation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectFormValidationCopyWith<$Res> {
  factory $ProjectFormValidationCopyWith(ProjectFormValidation value,
          $Res Function(ProjectFormValidation) then) =
      _$ProjectFormValidationCopyWithImpl<$Res>;
  $Res call(
      {ProjectFormField projectName,
      ProjectFormField collName,
      ProjectFormField email,
      ProjectFormField collNum});

  $ProjectFormFieldCopyWith<$Res> get projectName;
  $ProjectFormFieldCopyWith<$Res> get collName;
  $ProjectFormFieldCopyWith<$Res> get email;
  $ProjectFormFieldCopyWith<$Res> get collNum;
}

/// @nodoc
class _$ProjectFormValidationCopyWithImpl<$Res>
    implements $ProjectFormValidationCopyWith<$Res> {
  _$ProjectFormValidationCopyWithImpl(this._value, this._then);

  final ProjectFormValidation _value;
  // ignore: unused_field
  final $Res Function(ProjectFormValidation) _then;

  @override
  $Res call({
    Object? projectName = freezed,
    Object? collName = freezed,
    Object? email = freezed,
    Object? collNum = freezed,
  }) {
    return _then(_value.copyWith(
      projectName: projectName == freezed
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
      collName: collName == freezed
          ? _value.collName
          : collName // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
      collNum: collNum == freezed
          ? _value.collNum
          : collNum // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
    ));
  }

  @override
  $ProjectFormFieldCopyWith<$Res> get projectName {
    return $ProjectFormFieldCopyWith<$Res>(_value.projectName, (value) {
      return _then(_value.copyWith(projectName: value));
    });
  }

  @override
  $ProjectFormFieldCopyWith<$Res> get collName {
    return $ProjectFormFieldCopyWith<$Res>(_value.collName, (value) {
      return _then(_value.copyWith(collName: value));
    });
  }

  @override
  $ProjectFormFieldCopyWith<$Res> get email {
    return $ProjectFormFieldCopyWith<$Res>(_value.email, (value) {
      return _then(_value.copyWith(email: value));
    });
  }

  @override
  $ProjectFormFieldCopyWith<$Res> get collNum {
    return $ProjectFormFieldCopyWith<$Res>(_value.collNum, (value) {
      return _then(_value.copyWith(collNum: value));
    });
  }
}

/// @nodoc
abstract class _$$_ProjectFormValidationCopyWith<$Res>
    implements $ProjectFormValidationCopyWith<$Res> {
  factory _$$_ProjectFormValidationCopyWith(_$_ProjectFormValidation value,
          $Res Function(_$_ProjectFormValidation) then) =
      __$$_ProjectFormValidationCopyWithImpl<$Res>;
  @override
  $Res call(
      {ProjectFormField projectName,
      ProjectFormField collName,
      ProjectFormField email,
      ProjectFormField collNum});

  @override
  $ProjectFormFieldCopyWith<$Res> get projectName;
  @override
  $ProjectFormFieldCopyWith<$Res> get collName;
  @override
  $ProjectFormFieldCopyWith<$Res> get email;
  @override
  $ProjectFormFieldCopyWith<$Res> get collNum;
}

/// @nodoc
class __$$_ProjectFormValidationCopyWithImpl<$Res>
    extends _$ProjectFormValidationCopyWithImpl<$Res>
    implements _$$_ProjectFormValidationCopyWith<$Res> {
  __$$_ProjectFormValidationCopyWithImpl(_$_ProjectFormValidation _value,
      $Res Function(_$_ProjectFormValidation) _then)
      : super(_value, (v) => _then(v as _$_ProjectFormValidation));

  @override
  _$_ProjectFormValidation get _value =>
      super._value as _$_ProjectFormValidation;

  @override
  $Res call({
    Object? projectName = freezed,
    Object? collName = freezed,
    Object? email = freezed,
    Object? collNum = freezed,
  }) {
    return _then(_$_ProjectFormValidation(
      projectName: projectName == freezed
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
      collName: collName == freezed
          ? _value.collName
          : collName // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
      collNum: collNum == freezed
          ? _value.collNum
          : collNum // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
    ));
  }
}

/// @nodoc

class _$_ProjectFormValidation extends _ProjectFormValidation {
  const _$_ProjectFormValidation(
      {required this.projectName,
      required this.collName,
      required this.email,
      required this.collNum})
      : super._();

  @override
  final ProjectFormField projectName;
  @override
  final ProjectFormField collName;
  @override
  final ProjectFormField email;
  @override
  final ProjectFormField collNum;

  @override
  String toString() {
    return 'ProjectFormValidation(projectName: $projectName, collName: $collName, email: $email, collNum: $collNum)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectFormValidation &&
            const DeepCollectionEquality()
                .equals(other.projectName, projectName) &&
            const DeepCollectionEquality().equals(other.collName, collName) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.collNum, collNum));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(projectName),
      const DeepCollectionEquality().hash(collName),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(collNum));

  @JsonKey(ignore: true)
  @override
  _$$_ProjectFormValidationCopyWith<_$_ProjectFormValidation> get copyWith =>
      __$$_ProjectFormValidationCopyWithImpl<_$_ProjectFormValidation>(
          this, _$identity);
}

abstract class _ProjectFormValidation extends ProjectFormValidation {
  const factory _ProjectFormValidation(
      {required final ProjectFormField projectName,
      required final ProjectFormField collName,
      required final ProjectFormField email,
      required final ProjectFormField collNum}) = _$_ProjectFormValidation;
  const _ProjectFormValidation._() : super._();

  @override
  ProjectFormField get projectName;
  @override
  ProjectFormField get collName;
  @override
  ProjectFormField get email;
  @override
  ProjectFormField get collNum;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectFormValidationCopyWith<_$_ProjectFormValidation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProjectFormField {
  String? get value => throw _privateConstructorUsedError;
  String? get errMsg => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectFormFieldCopyWith<ProjectFormField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectFormFieldCopyWith<$Res> {
  factory $ProjectFormFieldCopyWith(
          ProjectFormField value, $Res Function(ProjectFormField) then) =
      _$ProjectFormFieldCopyWithImpl<$Res>;
  $Res call({String? value, String? errMsg, bool isValid});
}

/// @nodoc
class _$ProjectFormFieldCopyWithImpl<$Res>
    implements $ProjectFormFieldCopyWith<$Res> {
  _$ProjectFormFieldCopyWithImpl(this._value, this._then);

  final ProjectFormField _value;
  // ignore: unused_field
  final $Res Function(ProjectFormField) _then;

  @override
  $Res call({
    Object? value = freezed,
    Object? errMsg = freezed,
    Object? isValid = freezed,
  }) {
    return _then(_value.copyWith(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      errMsg: errMsg == freezed
          ? _value.errMsg
          : errMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      isValid: isValid == freezed
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_ProjectNameCopyWith<$Res>
    implements $ProjectFormFieldCopyWith<$Res> {
  factory _$$_ProjectNameCopyWith(
          _$_ProjectName value, $Res Function(_$_ProjectName) then) =
      __$$_ProjectNameCopyWithImpl<$Res>;
  @override
  $Res call({String? value, String? errMsg, bool isValid});
}

/// @nodoc
class __$$_ProjectNameCopyWithImpl<$Res>
    extends _$ProjectFormFieldCopyWithImpl<$Res>
    implements _$$_ProjectNameCopyWith<$Res> {
  __$$_ProjectNameCopyWithImpl(
      _$_ProjectName _value, $Res Function(_$_ProjectName) _then)
      : super(_value, (v) => _then(v as _$_ProjectName));

  @override
  _$_ProjectName get _value => super._value as _$_ProjectName;

  @override
  $Res call({
    Object? value = freezed,
    Object? errMsg = freezed,
    Object? isValid = freezed,
  }) {
    return _then(_$_ProjectName(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      errMsg: errMsg == freezed
          ? _value.errMsg
          : errMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      isValid: isValid == freezed
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ProjectName implements _ProjectName {
  _$_ProjectName(
      {required this.value, required this.errMsg, this.isValid = false});

  @override
  final String? value;
  @override
  final String? errMsg;
  @override
  @JsonKey()
  final bool isValid;

  @override
  String toString() {
    return 'ProjectFormField(value: $value, errMsg: $errMsg, isValid: $isValid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectName &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.errMsg, errMsg) &&
            const DeepCollectionEquality().equals(other.isValid, isValid));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(errMsg),
      const DeepCollectionEquality().hash(isValid));

  @JsonKey(ignore: true)
  @override
  _$$_ProjectNameCopyWith<_$_ProjectName> get copyWith =>
      __$$_ProjectNameCopyWithImpl<_$_ProjectName>(this, _$identity);
}

abstract class _ProjectName implements ProjectFormField {
  factory _ProjectName(
      {required final String? value,
      required final String? errMsg,
      final bool isValid}) = _$_ProjectName;

  @override
  String? get value;
  @override
  String? get errMsg;
  @override
  bool get isValid;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectNameCopyWith<_$_ProjectName> get copyWith =>
      throw _privateConstructorUsedError;
}
