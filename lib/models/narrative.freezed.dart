// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'narrative.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NarrativeModel {
  int get id => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get site => throw _privateConstructorUsedError;
  String get narrative => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NarrativeModelCopyWith<NarrativeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NarrativeModelCopyWith<$Res> {
  factory $NarrativeModelCopyWith(
          NarrativeModel value, $Res Function(NarrativeModel) then) =
      _$NarrativeModelCopyWithImpl<$Res>;
  $Res call({int id, String date, String site, String narrative});
}

/// @nodoc
class _$NarrativeModelCopyWithImpl<$Res>
    implements $NarrativeModelCopyWith<$Res> {
  _$NarrativeModelCopyWithImpl(this._value, this._then);

  final NarrativeModel _value;
  // ignore: unused_field
  final $Res Function(NarrativeModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? date = freezed,
    Object? site = freezed,
    Object? narrative = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      site: site == freezed
          ? _value.site
          : site // ignore: cast_nullable_to_non_nullable
              as String,
      narrative: narrative == freezed
          ? _value.narrative
          : narrative // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_NarrativeModelCopyWith<$Res>
    implements $NarrativeModelCopyWith<$Res> {
  factory _$$_NarrativeModelCopyWith(
          _$_NarrativeModel value, $Res Function(_$_NarrativeModel) then) =
      __$$_NarrativeModelCopyWithImpl<$Res>;
  @override
  $Res call({int id, String date, String site, String narrative});
}

/// @nodoc
class __$$_NarrativeModelCopyWithImpl<$Res>
    extends _$NarrativeModelCopyWithImpl<$Res>
    implements _$$_NarrativeModelCopyWith<$Res> {
  __$$_NarrativeModelCopyWithImpl(
      _$_NarrativeModel _value, $Res Function(_$_NarrativeModel) _then)
      : super(_value, (v) => _then(v as _$_NarrativeModel));

  @override
  _$_NarrativeModel get _value => super._value as _$_NarrativeModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? date = freezed,
    Object? site = freezed,
    Object? narrative = freezed,
  }) {
    return _then(_$_NarrativeModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      site: site == freezed
          ? _value.site
          : site // ignore: cast_nullable_to_non_nullable
              as String,
      narrative: narrative == freezed
          ? _value.narrative
          : narrative // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_NarrativeModel implements _NarrativeModel {
  const _$_NarrativeModel(
      {required this.id,
      required this.date,
      required this.site,
      required this.narrative});

  @override
  final int id;
  @override
  final String date;
  @override
  final String site;
  @override
  final String narrative;

  @override
  String toString() {
    return 'NarrativeModel(id: $id, date: $date, site: $site, narrative: $narrative)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NarrativeModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality().equals(other.site, site) &&
            const DeepCollectionEquality().equals(other.narrative, narrative));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(site),
      const DeepCollectionEquality().hash(narrative));

  @JsonKey(ignore: true)
  @override
  _$$_NarrativeModelCopyWith<_$_NarrativeModel> get copyWith =>
      __$$_NarrativeModelCopyWithImpl<_$_NarrativeModel>(this, _$identity);
}

abstract class _NarrativeModel implements NarrativeModel {
  const factory _NarrativeModel(
      {required final int id,
      required final String date,
      required final String site,
      required final String narrative}) = _$_NarrativeModel;

  @override
  int get id;
  @override
  String get date;
  @override
  String get site;
  @override
  String get narrative;
  @override
  @JsonKey(ignore: true)
  _$$_NarrativeModelCopyWith<_$_NarrativeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
