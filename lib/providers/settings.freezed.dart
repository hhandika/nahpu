// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
