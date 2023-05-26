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
mixin _$ProjectForm {
  ProjectFormField get projectName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectFormCopyWith<ProjectForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectFormCopyWith<$Res> {
  factory $ProjectFormCopyWith(
          ProjectForm value, $Res Function(ProjectForm) then) =
      _$ProjectFormCopyWithImpl<$Res, ProjectForm>;
  @useResult
  $Res call({ProjectFormField projectName});

  $ProjectFormFieldCopyWith<$Res> get projectName;
}

/// @nodoc
class _$ProjectFormCopyWithImpl<$Res, $Val extends ProjectForm>
    implements $ProjectFormCopyWith<$Res> {
  _$ProjectFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectName = null,
  }) {
    return _then(_value.copyWith(
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
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
}

/// @nodoc
abstract class _$$_ProjectFormCopyWith<$Res>
    implements $ProjectFormCopyWith<$Res> {
  factory _$$_ProjectFormCopyWith(
          _$_ProjectForm value, $Res Function(_$_ProjectForm) then) =
      __$$_ProjectFormCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ProjectFormField projectName});

  @override
  $ProjectFormFieldCopyWith<$Res> get projectName;
}

/// @nodoc
class __$$_ProjectFormCopyWithImpl<$Res>
    extends _$ProjectFormCopyWithImpl<$Res, _$_ProjectForm>
    implements _$$_ProjectFormCopyWith<$Res> {
  __$$_ProjectFormCopyWithImpl(
      _$_ProjectForm _value, $Res Function(_$_ProjectForm) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectName = null,
  }) {
    return _then(_$_ProjectForm(
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as ProjectFormField,
    ));
  }
}

/// @nodoc

class _$_ProjectForm extends _ProjectForm {
  const _$_ProjectForm({required this.projectName}) : super._();

  @override
  final ProjectFormField projectName;

  @override
  String toString() {
    return 'ProjectForm(projectName: $projectName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectForm &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, projectName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectFormCopyWith<_$_ProjectForm> get copyWith =>
      __$$_ProjectFormCopyWithImpl<_$_ProjectForm>(this, _$identity);
}

abstract class _ProjectForm extends ProjectForm {
  const factory _ProjectForm({required final ProjectFormField projectName}) =
      _$_ProjectForm;
  const _ProjectForm._() : super._();

  @override
  ProjectFormField get projectName;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectFormCopyWith<_$_ProjectForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProjectFormField {
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
abstract class _$$_ProjectNameCopyWith<$Res>
    implements $ProjectFormFieldCopyWith<$Res> {
  factory _$$_ProjectNameCopyWith(
          _$_ProjectName value, $Res Function(_$_ProjectName) then) =
      __$$_ProjectNameCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? errMsg, bool isValid});
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
    Object? errMsg = freezed,
    Object? isValid = null,
  }) {
    return _then(_$_ProjectName(
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
  _$_ProjectName({required this.errMsg, this.isValid = false});

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectName &&
            (identical(other.errMsg, errMsg) || other.errMsg == errMsg) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errMsg, isValid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectNameCopyWith<_$_ProjectName> get copyWith =>
      __$$_ProjectNameCopyWithImpl<_$_ProjectName>(this, _$identity);
}

abstract class _ProjectName implements ProjectFormField {
  factory _ProjectName({required final String? errMsg, final bool isValid}) =
      _$_ProjectName;

  @override
  String? get errMsg;
  @override
  bool get isValid;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectNameCopyWith<_$_ProjectName> get copyWith =>
      throw _privateConstructorUsedError;
}
