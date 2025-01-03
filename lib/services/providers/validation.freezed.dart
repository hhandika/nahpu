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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProjectForm {
  ProjectFormField get projectName => throw _privateConstructorUsedError;
  ProjectFormField get existingProject => throw _privateConstructorUsedError;

  /// Create a copy of ProjectForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectFormCopyWith<ProjectForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectFormCopyWith<$Res> {
  factory $ProjectFormCopyWith(
          ProjectForm value, $Res Function(ProjectForm) then) =
      _$ProjectFormCopyWithImpl<$Res, ProjectForm>;
  @useResult
  $Res call({ProjectFormField projectName, ProjectFormField existingProject});

  $ProjectFormFieldCopyWith<$Res> get projectName;
  $ProjectFormFieldCopyWith<$Res> get existingProject;
}

/// @nodoc
class _$ProjectFormCopyWithImpl<$Res, $Val extends ProjectForm>
    implements $ProjectFormCopyWith<$Res> {
  _$ProjectFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectName = null,
    Object? existingProject = null,
  }) {
    return _then(_value.copyWith(
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
      existingProject: null == existingProject
          ? _value.existingProject
          : existingProject // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
    ) as $Val);
  }

  /// Create a copy of ProjectForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProjectFormFieldCopyWith<$Res> get projectName {
    return $ProjectFormFieldCopyWith<$Res>(_value.projectName, (value) {
      return _then(_value.copyWith(projectName: value) as $Val);
    });
  }

  /// Create a copy of ProjectForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProjectFormFieldCopyWith<$Res> get existingProject {
    return $ProjectFormFieldCopyWith<$Res>(_value.existingProject, (value) {
      return _then(_value.copyWith(existingProject: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProjectFormImplCopyWith<$Res>
    implements $ProjectFormCopyWith<$Res> {
  factory _$$ProjectFormImplCopyWith(
          _$ProjectFormImpl value, $Res Function(_$ProjectFormImpl) then) =
      __$$ProjectFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ProjectFormField projectName, ProjectFormField existingProject});

  @override
  $ProjectFormFieldCopyWith<$Res> get projectName;
  @override
  $ProjectFormFieldCopyWith<$Res> get existingProject;
}

/// @nodoc
class __$$ProjectFormImplCopyWithImpl<$Res>
    extends _$ProjectFormCopyWithImpl<$Res, _$ProjectFormImpl>
    implements _$$ProjectFormImplCopyWith<$Res> {
  __$$ProjectFormImplCopyWithImpl(
      _$ProjectFormImpl _value, $Res Function(_$ProjectFormImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectName = null,
    Object? existingProject = null,
  }) {
    return _then(_$ProjectFormImpl(
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
      existingProject: null == existingProject
          ? _value.existingProject
          : existingProject // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
    ));
  }
}

/// @nodoc

class _$ProjectFormImpl extends _ProjectForm {
  const _$ProjectFormImpl(
      {required this.projectName, required this.existingProject})
      : super._();

  @override
  final ProjectFormField projectName;
  @override
  final ProjectFormField existingProject;

  @override
  String toString() {
    return 'ProjectForm(projectName: $projectName, existingProject: $existingProject)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectFormImpl &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            (identical(other.existingProject, existingProject) ||
                other.existingProject == existingProject));
  }

  @override
  int get hashCode => Object.hash(runtimeType, projectName, existingProject);

  /// Create a copy of ProjectForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectFormImplCopyWith<_$ProjectFormImpl> get copyWith =>
      __$$ProjectFormImplCopyWithImpl<_$ProjectFormImpl>(this, _$identity);
}

abstract class _ProjectForm extends ProjectForm {
  const factory _ProjectForm(
      {required final ProjectFormField projectName,
      required final ProjectFormField existingProject}) = _$ProjectFormImpl;
  const _ProjectForm._() : super._();

  @override
  ProjectFormField get projectName;
  @override
  ProjectFormField get existingProject;

  /// Create a copy of ProjectForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectFormImplCopyWith<_$ProjectFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProjectFormField {
  String? get errMsg => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;

  /// Create a copy of ProjectFormField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectFormFieldCopyWith<ProjectFormField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectFormFieldCopyWith<$Res> {
  factory $ProjectFormFieldCopyWith(
          ProjectFormField value, $Res Function(ProjectFormField) then) =
      _$ProjectFormFieldCopyWithImpl<$Res, ProjectFormField>;
  @useResult
  $Res call({String? errMsg, bool isValid});
}

/// @nodoc
class _$ProjectFormFieldCopyWithImpl<$Res, $Val extends ProjectFormField>
    implements $ProjectFormFieldCopyWith<$Res> {
  _$ProjectFormFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectFormField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errMsg = freezed,
    Object? isValid = null,
  }) {
    return _then(_value.copyWith(
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
abstract class _$$ProjectNameImplCopyWith<$Res>
    implements $ProjectFormFieldCopyWith<$Res> {
  factory _$$ProjectNameImplCopyWith(
          _$ProjectNameImpl value, $Res Function(_$ProjectNameImpl) then) =
      __$$ProjectNameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? errMsg, bool isValid});
}

/// @nodoc
class __$$ProjectNameImplCopyWithImpl<$Res>
    extends _$ProjectFormFieldCopyWithImpl<$Res, _$ProjectNameImpl>
    implements _$$ProjectNameImplCopyWith<$Res> {
  __$$ProjectNameImplCopyWithImpl(
      _$ProjectNameImpl _value, $Res Function(_$ProjectNameImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectFormField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errMsg = freezed,
    Object? isValid = null,
  }) {
    return _then(_$ProjectNameImpl(
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

class _$ProjectNameImpl implements _ProjectName {
  _$ProjectNameImpl({required this.errMsg, this.isValid = false});

  @override
  final String? errMsg;
  @override
  @JsonKey()
  final bool isValid;

  @override
  String toString() {
    return 'ProjectFormField(errMsg: $errMsg, isValid: $isValid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectNameImpl &&
            (identical(other.errMsg, errMsg) || other.errMsg == errMsg) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errMsg, isValid);

  /// Create a copy of ProjectFormField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectNameImplCopyWith<_$ProjectNameImpl> get copyWith =>
      __$$ProjectNameImplCopyWithImpl<_$ProjectNameImpl>(this, _$identity);
}

abstract class _ProjectName implements ProjectFormField {
  factory _ProjectName({required final String? errMsg, final bool isValid}) =
      _$ProjectNameImpl;

  @override
  String? get errMsg;
  @override
  bool get isValid;

  /// Create a copy of ProjectFormField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectNameImplCopyWith<_$ProjectNameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PersonnelForm {
  PersonnelFormField get name => throw _privateConstructorUsedError;
  PersonnelFormField get email => throw _privateConstructorUsedError;
  PersonnelFormField get initial => throw _privateConstructorUsedError;
  PersonnelFormField get collNum => throw _privateConstructorUsedError;

  /// Create a copy of PersonnelForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PersonnelFormCopyWith<PersonnelForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonnelFormCopyWith<$Res> {
  factory $PersonnelFormCopyWith(
          PersonnelForm value, $Res Function(PersonnelForm) then) =
      _$PersonnelFormCopyWithImpl<$Res, PersonnelForm>;
  @useResult
  $Res call(
      {PersonnelFormField name,
      PersonnelFormField email,
      PersonnelFormField initial,
      PersonnelFormField collNum});

  $PersonnelFormFieldCopyWith<$Res> get name;
  $PersonnelFormFieldCopyWith<$Res> get email;
  $PersonnelFormFieldCopyWith<$Res> get initial;
  $PersonnelFormFieldCopyWith<$Res> get collNum;
}

/// @nodoc
class _$PersonnelFormCopyWithImpl<$Res, $Val extends PersonnelForm>
    implements $PersonnelFormCopyWith<$Res> {
  _$PersonnelFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PersonnelForm
  /// with the given fields replaced by the non-null parameter values.
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
              as PersonnelFormField,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as PersonnelFormField,
      initial: null == initial
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as PersonnelFormField,
      collNum: null == collNum
          ? _value.collNum
          : collNum // ignore: cast_nullable_to_non_nullable
              as PersonnelFormField,
    ) as $Val);
  }

  /// Create a copy of PersonnelForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PersonnelFormFieldCopyWith<$Res> get name {
    return $PersonnelFormFieldCopyWith<$Res>(_value.name, (value) {
      return _then(_value.copyWith(name: value) as $Val);
    });
  }

  /// Create a copy of PersonnelForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PersonnelFormFieldCopyWith<$Res> get email {
    return $PersonnelFormFieldCopyWith<$Res>(_value.email, (value) {
      return _then(_value.copyWith(email: value) as $Val);
    });
  }

  /// Create a copy of PersonnelForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PersonnelFormFieldCopyWith<$Res> get initial {
    return $PersonnelFormFieldCopyWith<$Res>(_value.initial, (value) {
      return _then(_value.copyWith(initial: value) as $Val);
    });
  }

  /// Create a copy of PersonnelForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PersonnelFormFieldCopyWith<$Res> get collNum {
    return $PersonnelFormFieldCopyWith<$Res>(_value.collNum, (value) {
      return _then(_value.copyWith(collNum: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PersonnelFormImplCopyWith<$Res>
    implements $PersonnelFormCopyWith<$Res> {
  factory _$$PersonnelFormImplCopyWith(
          _$PersonnelFormImpl value, $Res Function(_$PersonnelFormImpl) then) =
      __$$PersonnelFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PersonnelFormField name,
      PersonnelFormField email,
      PersonnelFormField initial,
      PersonnelFormField collNum});

  @override
  $PersonnelFormFieldCopyWith<$Res> get name;
  @override
  $PersonnelFormFieldCopyWith<$Res> get email;
  @override
  $PersonnelFormFieldCopyWith<$Res> get initial;
  @override
  $PersonnelFormFieldCopyWith<$Res> get collNum;
}

/// @nodoc
class __$$PersonnelFormImplCopyWithImpl<$Res>
    extends _$PersonnelFormCopyWithImpl<$Res, _$PersonnelFormImpl>
    implements _$$PersonnelFormImplCopyWith<$Res> {
  __$$PersonnelFormImplCopyWithImpl(
      _$PersonnelFormImpl _value, $Res Function(_$PersonnelFormImpl) _then)
      : super(_value, _then);

  /// Create a copy of PersonnelForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? initial = null,
    Object? collNum = null,
  }) {
    return _then(_$PersonnelFormImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as PersonnelFormField,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as PersonnelFormField,
      initial: null == initial
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as PersonnelFormField,
      collNum: null == collNum
          ? _value.collNum
          : collNum // ignore: cast_nullable_to_non_nullable
              as PersonnelFormField,
    ));
  }
}

/// @nodoc

class _$PersonnelFormImpl extends _PersonnelForm {
  const _$PersonnelFormImpl(
      {required this.name,
      required this.email,
      required this.initial,
      required this.collNum})
      : super._();

  @override
  final PersonnelFormField name;
  @override
  final PersonnelFormField email;
  @override
  final PersonnelFormField initial;
  @override
  final PersonnelFormField collNum;

  @override
  String toString() {
    return 'PersonnelForm(name: $name, email: $email, initial: $initial, collNum: $collNum)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonnelFormImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.initial, initial) || other.initial == initial) &&
            (identical(other.collNum, collNum) || other.collNum == collNum));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, email, initial, collNum);

  /// Create a copy of PersonnelForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonnelFormImplCopyWith<_$PersonnelFormImpl> get copyWith =>
      __$$PersonnelFormImplCopyWithImpl<_$PersonnelFormImpl>(this, _$identity);
}

abstract class _PersonnelForm extends PersonnelForm {
  const factory _PersonnelForm(
      {required final PersonnelFormField name,
      required final PersonnelFormField email,
      required final PersonnelFormField initial,
      required final PersonnelFormField collNum}) = _$PersonnelFormImpl;
  const _PersonnelForm._() : super._();

  @override
  PersonnelFormField get name;
  @override
  PersonnelFormField get email;
  @override
  PersonnelFormField get initial;
  @override
  PersonnelFormField get collNum;

  /// Create a copy of PersonnelForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersonnelFormImplCopyWith<_$PersonnelFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PersonnelFormField {
  String? get errMsg => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;

  /// Create a copy of PersonnelFormField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PersonnelFormFieldCopyWith<PersonnelFormField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonnelFormFieldCopyWith<$Res> {
  factory $PersonnelFormFieldCopyWith(
          PersonnelFormField value, $Res Function(PersonnelFormField) then) =
      _$PersonnelFormFieldCopyWithImpl<$Res, PersonnelFormField>;
  @useResult
  $Res call({String? errMsg, bool isValid});
}

/// @nodoc
class _$PersonnelFormFieldCopyWithImpl<$Res, $Val extends PersonnelFormField>
    implements $PersonnelFormFieldCopyWith<$Res> {
  _$PersonnelFormFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PersonnelFormField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errMsg = freezed,
    Object? isValid = null,
  }) {
    return _then(_value.copyWith(
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
abstract class _$$PersonnelFormFieldImplCopyWith<$Res>
    implements $PersonnelFormFieldCopyWith<$Res> {
  factory _$$PersonnelFormFieldImplCopyWith(_$PersonnelFormFieldImpl value,
          $Res Function(_$PersonnelFormFieldImpl) then) =
      __$$PersonnelFormFieldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? errMsg, bool isValid});
}

/// @nodoc
class __$$PersonnelFormFieldImplCopyWithImpl<$Res>
    extends _$PersonnelFormFieldCopyWithImpl<$Res, _$PersonnelFormFieldImpl>
    implements _$$PersonnelFormFieldImplCopyWith<$Res> {
  __$$PersonnelFormFieldImplCopyWithImpl(_$PersonnelFormFieldImpl _value,
      $Res Function(_$PersonnelFormFieldImpl) _then)
      : super(_value, _then);

  /// Create a copy of PersonnelFormField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errMsg = freezed,
    Object? isValid = null,
  }) {
    return _then(_$PersonnelFormFieldImpl(
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

class _$PersonnelFormFieldImpl implements _PersonnelFormField {
  _$PersonnelFormFieldImpl({required this.errMsg, this.isValid = false});

  @override
  final String? errMsg;
  @override
  @JsonKey()
  final bool isValid;

  @override
  String toString() {
    return 'PersonnelFormField(errMsg: $errMsg, isValid: $isValid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonnelFormFieldImpl &&
            (identical(other.errMsg, errMsg) || other.errMsg == errMsg) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errMsg, isValid);

  /// Create a copy of PersonnelFormField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonnelFormFieldImplCopyWith<_$PersonnelFormFieldImpl> get copyWith =>
      __$$PersonnelFormFieldImplCopyWithImpl<_$PersonnelFormFieldImpl>(
          this, _$identity);
}

abstract class _PersonnelFormField implements PersonnelFormField {
  factory _PersonnelFormField(
      {required final String? errMsg,
      final bool isValid}) = _$PersonnelFormFieldImpl;

  @override
  String? get errMsg;
  @override
  bool get isValid;

  /// Create a copy of PersonnelFormField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersonnelFormFieldImplCopyWith<_$PersonnelFormFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
