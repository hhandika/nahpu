// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validation.dart';

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
      _$ProjectFormStateCopyWithImpl<$Res, ProjectFormState>;
  @useResult
  $Res call({ProjectFormValidation form});

  $ProjectFormValidationCopyWith<$Res> get form;
}

/// @nodoc
class _$ProjectFormStateCopyWithImpl<$Res, $Val extends ProjectFormState>
    implements $ProjectFormStateCopyWith<$Res> {
  _$ProjectFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = null,
  }) {
    return _then(_value.copyWith(
      form: null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as ProjectFormValidation,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProjectFormValidationCopyWith<$Res> get form {
    return $ProjectFormValidationCopyWith<$Res>(_value.form, (value) {
      return _then(_value.copyWith(form: value) as $Val);
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
  @useResult
  $Res call({ProjectFormValidation form});

  @override
  $ProjectFormValidationCopyWith<$Res> get form;
}

/// @nodoc
class __$$_ProjectFormStateCopyWithImpl<$Res>
    extends _$ProjectFormStateCopyWithImpl<$Res, _$_ProjectFormState>
    implements _$$_ProjectFormStateCopyWith<$Res> {
  __$$_ProjectFormStateCopyWithImpl(
      _$_ProjectFormState _value, $Res Function(_$_ProjectFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = null,
  }) {
    return _then(_$_ProjectFormState(
      null == form
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
            (identical(other.form, form) || other.form == form));
  }

  @override
  int get hashCode => Object.hash(runtimeType, form);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
      _$ProjectFormValidationCopyWithImpl<$Res, ProjectFormValidation>;
  @useResult
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
class _$ProjectFormValidationCopyWithImpl<$Res,
        $Val extends ProjectFormValidation>
    implements $ProjectFormValidationCopyWith<$Res> {
  _$ProjectFormValidationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectName = null,
    Object? collName = null,
    Object? email = null,
    Object? collNum = null,
  }) {
    return _then(_value.copyWith(
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
      collName: null == collName
          ? _value.collName
          : collName // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
      collNum: null == collNum
          ? _value.collNum
          : collNum // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProjectFormFieldCopyWith<$Res> get projectName {
    return $ProjectFormFieldCopyWith<$Res>(_value.projectName, (value) {
      return _then(_value.copyWith(projectName: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProjectFormFieldCopyWith<$Res> get collName {
    return $ProjectFormFieldCopyWith<$Res>(_value.collName, (value) {
      return _then(_value.copyWith(collName: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProjectFormFieldCopyWith<$Res> get email {
    return $ProjectFormFieldCopyWith<$Res>(_value.email, (value) {
      return _then(_value.copyWith(email: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProjectFormFieldCopyWith<$Res> get collNum {
    return $ProjectFormFieldCopyWith<$Res>(_value.collNum, (value) {
      return _then(_value.copyWith(collNum: value) as $Val);
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
  @useResult
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
    extends _$ProjectFormValidationCopyWithImpl<$Res, _$_ProjectFormValidation>
    implements _$$_ProjectFormValidationCopyWith<$Res> {
  __$$_ProjectFormValidationCopyWithImpl(_$_ProjectFormValidation _value,
      $Res Function(_$_ProjectFormValidation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectName = null,
    Object? collName = null,
    Object? email = null,
    Object? collNum = null,
  }) {
    return _then(_$_ProjectFormValidation(
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
      collName: null == collName
          ? _value.collName
          : collName // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
      collNum: null == collNum
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
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            (identical(other.collName, collName) ||
                other.collName == collName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.collNum, collNum) || other.collNum == collNum));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, projectName, collName, email, collNum);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
      _$ProjectFormFieldCopyWithImpl<$Res, ProjectFormField>;
  @useResult
  $Res call({String? value, String? errMsg, bool isValid});
}

/// @nodoc
class _$ProjectFormFieldCopyWithImpl<$Res, $Val extends ProjectFormField>
    implements $ProjectFormFieldCopyWith<$Res> {
  _$ProjectFormFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? errMsg = freezed,
    Object? isValid = null,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      errMsg: freezed == errMsg
          ? _value.errMsg
          : errMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProjectNameCopyWith<$Res>
    implements $ProjectFormFieldCopyWith<$Res> {
  factory _$$_ProjectNameCopyWith(
          _$_ProjectName value, $Res Function(_$_ProjectName) then) =
      __$$_ProjectNameCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? value, String? errMsg, bool isValid});
}

/// @nodoc
class __$$_ProjectNameCopyWithImpl<$Res>
    extends _$ProjectFormFieldCopyWithImpl<$Res, _$_ProjectName>
    implements _$$_ProjectNameCopyWith<$Res> {
  __$$_ProjectNameCopyWithImpl(
      _$_ProjectName _value, $Res Function(_$_ProjectName) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? errMsg = freezed,
    Object? isValid = null,
  }) {
    return _then(_$_ProjectName(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      errMsg: freezed == errMsg
          ? _value.errMsg
          : errMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      isValid: null == isValid
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
            (identical(other.value, value) || other.value == value) &&
            (identical(other.errMsg, errMsg) || other.errMsg == errMsg) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, errMsg, isValid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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

/// @nodoc
mixin _$NewPersonnelFormState {
  NewPersonnelFormValidation get form => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewPersonnelFormStateCopyWith<NewPersonnelFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewPersonnelFormStateCopyWith<$Res> {
  factory $NewPersonnelFormStateCopyWith(NewPersonnelFormState value,
          $Res Function(NewPersonnelFormState) then) =
      _$NewPersonnelFormStateCopyWithImpl<$Res, NewPersonnelFormState>;
  @useResult
  $Res call({NewPersonnelFormValidation form});

  $NewPersonnelFormValidationCopyWith<$Res> get form;
}

/// @nodoc
class _$NewPersonnelFormStateCopyWithImpl<$Res,
        $Val extends NewPersonnelFormState>
    implements $NewPersonnelFormStateCopyWith<$Res> {
  _$NewPersonnelFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = null,
  }) {
    return _then(_value.copyWith(
      form: null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as NewPersonnelFormValidation,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NewPersonnelFormValidationCopyWith<$Res> get form {
    return $NewPersonnelFormValidationCopyWith<$Res>(_value.form, (value) {
      return _then(_value.copyWith(form: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_NewPersonnelFormStateCopyWith<$Res>
    implements $NewPersonnelFormStateCopyWith<$Res> {
  factory _$$_NewPersonnelFormStateCopyWith(_$_NewPersonnelFormState value,
          $Res Function(_$_NewPersonnelFormState) then) =
      __$$_NewPersonnelFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({NewPersonnelFormValidation form});

  @override
  $NewPersonnelFormValidationCopyWith<$Res> get form;
}

/// @nodoc
class __$$_NewPersonnelFormStateCopyWithImpl<$Res>
    extends _$NewPersonnelFormStateCopyWithImpl<$Res, _$_NewPersonnelFormState>
    implements _$$_NewPersonnelFormStateCopyWith<$Res> {
  __$$_NewPersonnelFormStateCopyWithImpl(_$_NewPersonnelFormState _value,
      $Res Function(_$_NewPersonnelFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = null,
  }) {
    return _then(_$_NewPersonnelFormState(
      null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as NewPersonnelFormValidation,
    ));
  }
}

/// @nodoc

class _$_NewPersonnelFormState implements _NewPersonnelFormState {
  const _$_NewPersonnelFormState(this.form);

  @override
  final NewPersonnelFormValidation form;

  @override
  String toString() {
    return 'NewPersonnelFormState(form: $form)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewPersonnelFormState &&
            (identical(other.form, form) || other.form == form));
  }

  @override
  int get hashCode => Object.hash(runtimeType, form);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewPersonnelFormStateCopyWith<_$_NewPersonnelFormState> get copyWith =>
      __$$_NewPersonnelFormStateCopyWithImpl<_$_NewPersonnelFormState>(
          this, _$identity);
}

abstract class _NewPersonnelFormState implements NewPersonnelFormState {
  const factory _NewPersonnelFormState(final NewPersonnelFormValidation form) =
      _$_NewPersonnelFormState;

  @override
  NewPersonnelFormValidation get form;
  @override
  @JsonKey(ignore: true)
  _$$_NewPersonnelFormStateCopyWith<_$_NewPersonnelFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NewPersonnelFormValidation {
  NewPersonnelFormField get name => throw _privateConstructorUsedError;
  NewPersonnelFormField get email => throw _privateConstructorUsedError;
  NewPersonnelFormField get initial => throw _privateConstructorUsedError;
  NewPersonnelFormField get collNum => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewPersonnelFormValidationCopyWith<NewPersonnelFormValidation>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewPersonnelFormValidationCopyWith<$Res> {
  factory $NewPersonnelFormValidationCopyWith(NewPersonnelFormValidation value,
          $Res Function(NewPersonnelFormValidation) then) =
      _$NewPersonnelFormValidationCopyWithImpl<$Res,
          NewPersonnelFormValidation>;
  @useResult
  $Res call(
      {NewPersonnelFormField name,
      NewPersonnelFormField email,
      NewPersonnelFormField initial,
      NewPersonnelFormField collNum});

  $NewPersonnelFormFieldCopyWith<$Res> get name;
  $NewPersonnelFormFieldCopyWith<$Res> get email;
  $NewPersonnelFormFieldCopyWith<$Res> get initial;
  $NewPersonnelFormFieldCopyWith<$Res> get collNum;
}

/// @nodoc
class _$NewPersonnelFormValidationCopyWithImpl<$Res,
        $Val extends NewPersonnelFormValidation>
    implements $NewPersonnelFormValidationCopyWith<$Res> {
  _$NewPersonnelFormValidationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? initial = null,
    Object? collNum = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as NewPersonnelFormField,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as NewPersonnelFormField,
      initial: null == initial
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as NewPersonnelFormField,
      collNum: null == collNum
          ? _value.collNum
          : collNum // ignore: cast_nullable_to_non_nullable
              as NewPersonnelFormField,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NewPersonnelFormFieldCopyWith<$Res> get name {
    return $NewPersonnelFormFieldCopyWith<$Res>(_value.name, (value) {
      return _then(_value.copyWith(name: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NewPersonnelFormFieldCopyWith<$Res> get email {
    return $NewPersonnelFormFieldCopyWith<$Res>(_value.email, (value) {
      return _then(_value.copyWith(email: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NewPersonnelFormFieldCopyWith<$Res> get initial {
    return $NewPersonnelFormFieldCopyWith<$Res>(_value.initial, (value) {
      return _then(_value.copyWith(initial: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NewPersonnelFormFieldCopyWith<$Res> get collNum {
    return $NewPersonnelFormFieldCopyWith<$Res>(_value.collNum, (value) {
      return _then(_value.copyWith(collNum: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_NewPersonnelFormValidationCopyWith<$Res>
    implements $NewPersonnelFormValidationCopyWith<$Res> {
  factory _$$_NewPersonnelFormValidationCopyWith(
          _$_NewPersonnelFormValidation value,
          $Res Function(_$_NewPersonnelFormValidation) then) =
      __$$_NewPersonnelFormValidationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NewPersonnelFormField name,
      NewPersonnelFormField email,
      NewPersonnelFormField initial,
      NewPersonnelFormField collNum});

  @override
  $NewPersonnelFormFieldCopyWith<$Res> get name;
  @override
  $NewPersonnelFormFieldCopyWith<$Res> get email;
  @override
  $NewPersonnelFormFieldCopyWith<$Res> get initial;
  @override
  $NewPersonnelFormFieldCopyWith<$Res> get collNum;
}

/// @nodoc
class __$$_NewPersonnelFormValidationCopyWithImpl<$Res>
    extends _$NewPersonnelFormValidationCopyWithImpl<$Res,
        _$_NewPersonnelFormValidation>
    implements _$$_NewPersonnelFormValidationCopyWith<$Res> {
  __$$_NewPersonnelFormValidationCopyWithImpl(
      _$_NewPersonnelFormValidation _value,
      $Res Function(_$_NewPersonnelFormValidation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? initial = null,
    Object? collNum = null,
  }) {
    return _then(_$_NewPersonnelFormValidation(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as NewPersonnelFormField,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as NewPersonnelFormField,
      initial: null == initial
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as NewPersonnelFormField,
      collNum: null == collNum
          ? _value.collNum
          : collNum // ignore: cast_nullable_to_non_nullable
              as NewPersonnelFormField,
    ));
  }
}

/// @nodoc

class _$_NewPersonnelFormValidation extends _NewPersonnelFormValidation {
  const _$_NewPersonnelFormValidation(
      {required this.name,
      required this.email,
      required this.initial,
      required this.collNum})
      : super._();

  @override
  final NewPersonnelFormField name;
  @override
  final NewPersonnelFormField email;
  @override
  final NewPersonnelFormField initial;
  @override
  final NewPersonnelFormField collNum;

  @override
  String toString() {
    return 'NewPersonnelFormValidation(name: $name, email: $email, initial: $initial, collNum: $collNum)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewPersonnelFormValidation &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.initial, initial) || other.initial == initial) &&
            (identical(other.collNum, collNum) || other.collNum == collNum));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, email, initial, collNum);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewPersonnelFormValidationCopyWith<_$_NewPersonnelFormValidation>
      get copyWith => __$$_NewPersonnelFormValidationCopyWithImpl<
          _$_NewPersonnelFormValidation>(this, _$identity);
}

abstract class _NewPersonnelFormValidation extends NewPersonnelFormValidation {
  const factory _NewPersonnelFormValidation(
          {required final NewPersonnelFormField name,
          required final NewPersonnelFormField email,
          required final NewPersonnelFormField initial,
          required final NewPersonnelFormField collNum}) =
      _$_NewPersonnelFormValidation;
  const _NewPersonnelFormValidation._() : super._();

  @override
  NewPersonnelFormField get name;
  @override
  NewPersonnelFormField get email;
  @override
  NewPersonnelFormField get initial;
  @override
  NewPersonnelFormField get collNum;
  @override
  @JsonKey(ignore: true)
  _$$_NewPersonnelFormValidationCopyWith<_$_NewPersonnelFormValidation>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NewPersonnelFormField {
  String? get value => throw _privateConstructorUsedError;
  String? get errMsg => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewPersonnelFormFieldCopyWith<NewPersonnelFormField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewPersonnelFormFieldCopyWith<$Res> {
  factory $NewPersonnelFormFieldCopyWith(NewPersonnelFormField value,
          $Res Function(NewPersonnelFormField) then) =
      _$NewPersonnelFormFieldCopyWithImpl<$Res, NewPersonnelFormField>;
  @useResult
  $Res call({String? value, String? errMsg, bool isValid});
}

/// @nodoc
class _$NewPersonnelFormFieldCopyWithImpl<$Res,
        $Val extends NewPersonnelFormField>
    implements $NewPersonnelFormFieldCopyWith<$Res> {
  _$NewPersonnelFormFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? errMsg = freezed,
    Object? isValid = null,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      errMsg: freezed == errMsg
          ? _value.errMsg
          : errMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewPersonnelFormFieldCopyWith<$Res>
    implements $NewPersonnelFormFieldCopyWith<$Res> {
  factory _$$_NewPersonnelFormFieldCopyWith(_$_NewPersonnelFormField value,
          $Res Function(_$_NewPersonnelFormField) then) =
      __$$_NewPersonnelFormFieldCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? value, String? errMsg, bool isValid});
}

/// @nodoc
class __$$_NewPersonnelFormFieldCopyWithImpl<$Res>
    extends _$NewPersonnelFormFieldCopyWithImpl<$Res, _$_NewPersonnelFormField>
    implements _$$_NewPersonnelFormFieldCopyWith<$Res> {
  __$$_NewPersonnelFormFieldCopyWithImpl(_$_NewPersonnelFormField _value,
      $Res Function(_$_NewPersonnelFormField) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? errMsg = freezed,
    Object? isValid = null,
  }) {
    return _then(_$_NewPersonnelFormField(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      errMsg: freezed == errMsg
          ? _value.errMsg
          : errMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_NewPersonnelFormField implements _NewPersonnelFormField {
  _$_NewPersonnelFormField(
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
    return 'NewPersonnelFormField(value: $value, errMsg: $errMsg, isValid: $isValid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewPersonnelFormField &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.errMsg, errMsg) || other.errMsg == errMsg) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, errMsg, isValid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewPersonnelFormFieldCopyWith<_$_NewPersonnelFormField> get copyWith =>
      __$$_NewPersonnelFormFieldCopyWithImpl<_$_NewPersonnelFormField>(
          this, _$identity);
}

abstract class _NewPersonnelFormField implements NewPersonnelFormField {
  factory _NewPersonnelFormField(
      {required final String? value,
      required final String? errMsg,
      final bool isValid}) = _$_NewPersonnelFormField;

  @override
  String? get value;
  @override
  String? get errMsg;
  @override
  bool get isValid;
  @override
  @JsonKey(ignore: true)
  _$$_NewPersonnelFormFieldCopyWith<_$_NewPersonnelFormField> get copyWith =>
      throw _privateConstructorUsedError;
}
