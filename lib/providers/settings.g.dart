// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingHash() => r'12f9fc2dbc3bc3609c897968592bb564823b1811';

/// See also [setting].
@ProviderFor(setting)
final settingProvider = AutoDisposeProvider<SharedPreferences>.internal(
  setting,
  name: r'settingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$settingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SettingRef = AutoDisposeProviderRef<SharedPreferences>;
String _$tissueIDNotifierHash() => r'a6f5548a57150755cc9270453593df469b480b5f';

/// See also [TissueIDNotifier].
@ProviderFor(TissueIDNotifier)
final tissueIDNotifierProvider =
    AutoDisposeAsyncNotifierProvider<TissueIDNotifier, TissueID>.internal(
  TissueIDNotifier.new,
  name: r'tissueIDNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tissueIDNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TissueIDNotifier = AutoDisposeAsyncNotifier<TissueID>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
