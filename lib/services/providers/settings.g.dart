// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingHash() => r'8d3ecafee3305b91918d38dce44046849a6590d1';

/// See also [setting].
@ProviderFor(setting)
final settingProvider = Provider<SharedPreferences>.internal(
  setting,
  name: r'settingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$settingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SettingRef = ProviderRef<SharedPreferences>;
String _$themeSettingHash() => r'65dc8dedd68a34209f4f3d469ca61b3f9bb06e91';

/// See also [ThemeSetting].
@ProviderFor(ThemeSetting)
final themeSettingProvider =
    AsyncNotifierProvider<ThemeSetting, ThemeMode>.internal(
  ThemeSetting.new,
  name: r'themeSettingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$themeSettingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeSetting = AsyncNotifier<ThemeMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
