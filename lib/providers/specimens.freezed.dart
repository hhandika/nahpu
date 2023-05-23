// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'specimens.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpecimenType {
  List<String> get typeList => throw _privateConstructorUsedError;
  List<String> get preservationList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpecimenTypeCopyWith<SpecimenType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpecimenTypeCopyWith<$Res> {
  factory $SpecimenTypeCopyWith(
          SpecimenType value, $Res Function(SpecimenType) then) =
      _$SpecimenTypeCopyWithImpl<$Res, SpecimenType>;
  @useResult
  $Res call({List<String> typeList, List<String> preservationList});
}

/// @nodoc
class _$SpecimenTypeCopyWithImpl<$Res, $Val extends SpecimenType>
    implements $SpecimenTypeCopyWith<$Res> {
  _$SpecimenTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typeList = null,
    Object? preservationList = null,
  }) {
    return _then(_value.copyWith(
      typeList: null == typeList
          ? _value.typeList
          : typeList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preservationList: null == preservationList
          ? _value.preservationList
          : preservationList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SpecimenTypeCopyWith<$Res>
    implements $SpecimenTypeCopyWith<$Res> {
  factory _$$_SpecimenTypeCopyWith(
          _$_SpecimenType value, $Res Function(_$_SpecimenType) then) =
      __$$_SpecimenTypeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> typeList, List<String> preservationList});
}

/// @nodoc
class __$$_SpecimenTypeCopyWithImpl<$Res>
    extends _$SpecimenTypeCopyWithImpl<$Res, _$_SpecimenType>
    implements _$$_SpecimenTypeCopyWith<$Res> {
  __$$_SpecimenTypeCopyWithImpl(
      _$_SpecimenType _value, $Res Function(_$_SpecimenType) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typeList = null,
    Object? preservationList = null,
  }) {
    return _then(_$_SpecimenType(
      typeList: null == typeList
          ? _value._typeList
          : typeList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preservationList: null == preservationList
          ? _value._preservationList
          : preservationList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_SpecimenType implements _SpecimenType {
  const _$_SpecimenType(
      {required final List<String> typeList,
      required final List<String> preservationList})
      : _typeList = typeList,
        _preservationList = preservationList;

  final List<String> _typeList;
  @override
  List<String> get typeList {
    if (_typeList is EqualUnmodifiableListView) return _typeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typeList);
  }

  final List<String> _preservationList;
  @override
  List<String> get preservationList {
    if (_preservationList is EqualUnmodifiableListView)
      return _preservationList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preservationList);
  }

  @override
  String toString() {
    return 'SpecimenType(typeList: $typeList, preservationList: $preservationList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SpecimenType &&
            const DeepCollectionEquality().equals(other._typeList, _typeList) &&
            const DeepCollectionEquality()
                .equals(other._preservationList, _preservationList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_typeList),
      const DeepCollectionEquality().hash(_preservationList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SpecimenTypeCopyWith<_$_SpecimenType> get copyWith =>
      __$$_SpecimenTypeCopyWithImpl<_$_SpecimenType>(this, _$identity);
}

abstract class _SpecimenType implements SpecimenType {
  const factory _SpecimenType(
      {required final List<String> typeList,
      required final List<String> preservationList}) = _$_SpecimenType;

  @override
  List<String> get typeList;
  @override
  List<String> get preservationList;
  @override
  @JsonKey(ignore: true)
  _$$_SpecimenTypeCopyWith<_$_SpecimenType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TissueID {
  String get prefix => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TissueIDCopyWith<TissueID> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TissueIDCopyWith<$Res> {
  factory $TissueIDCopyWith(TissueID value, $Res Function(TissueID) then) =
      _$TissueIDCopyWithImpl<$Res, TissueID>;
  @useResult
  $Res call({String prefix, int number});
}

/// @nodoc
class _$TissueIDCopyWithImpl<$Res, $Val extends TissueID>
    implements $TissueIDCopyWith<$Res> {
  _$TissueIDCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prefix = null,
    Object? number = null,
  }) {
    return _then(_value.copyWith(
      prefix: null == prefix
          ? _value.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TissueIDCopyWith<$Res> implements $TissueIDCopyWith<$Res> {
  factory _$$_TissueIDCopyWith(
          _$_TissueID value, $Res Function(_$_TissueID) then) =
      __$$_TissueIDCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String prefix, int number});
}

/// @nodoc
class __$$_TissueIDCopyWithImpl<$Res>
    extends _$TissueIDCopyWithImpl<$Res, _$_TissueID>
    implements _$$_TissueIDCopyWith<$Res> {
  __$$_TissueIDCopyWithImpl(
      _$_TissueID _value, $Res Function(_$_TissueID) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prefix = null,
    Object? number = null,
  }) {
    return _then(_$_TissueID(
      prefix: null == prefix
          ? _value.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_TissueID implements _TissueID {
  _$_TissueID({required this.prefix, required this.number});

  @override
  final String prefix;
  @override
  final int number;

  @override
  String toString() {
    return 'TissueID(prefix: $prefix, number: $number)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TissueID &&
            (identical(other.prefix, prefix) || other.prefix == prefix) &&
            (identical(other.number, number) || other.number == number));
  }

  @override
  int get hashCode => Object.hash(runtimeType, prefix, number);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TissueIDCopyWith<_$_TissueID> get copyWith =>
      __$$_TissueIDCopyWithImpl<_$_TissueID>(this, _$identity);
}

abstract class _TissueID implements TissueID {
  factory _TissueID({required final String prefix, required final int number}) =
      _$_TissueID;

  @override
  String get prefix;
  @override
  int get number;
  @override
  @JsonKey(ignore: true)
  _$$_TissueIDCopyWith<_$_TissueID> get copyWith =>
      throw _privateConstructorUsedError;
}
