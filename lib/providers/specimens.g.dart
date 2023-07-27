// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specimens.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$specimenMediaHash() => r'7134f2bc7aa8ba9911a75aa6724e353f35e050f1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef SpecimenMediaRef = AutoDisposeFutureProviderRef<List<MediaData>>;

/// See also [specimenMedia].
@ProviderFor(specimenMedia)
const specimenMediaProvider = SpecimenMediaFamily();

/// See also [specimenMedia].
class SpecimenMediaFamily extends Family<AsyncValue<List<MediaData>>> {
  /// See also [specimenMedia].
  const SpecimenMediaFamily();

  /// See also [specimenMedia].
  SpecimenMediaProvider call({
    required String specimenUuid,
  }) {
    return SpecimenMediaProvider(
      specimenUuid: specimenUuid,
    );
  }

  @override
  SpecimenMediaProvider getProviderOverride(
    covariant SpecimenMediaProvider provider,
  ) {
    return call(
      specimenUuid: provider.specimenUuid,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'specimenMediaProvider';
}

/// See also [specimenMedia].
class SpecimenMediaProvider extends AutoDisposeFutureProvider<List<MediaData>> {
  /// See also [specimenMedia].
  SpecimenMediaProvider({
    required this.specimenUuid,
  }) : super.internal(
          (ref) => specimenMedia(
            ref,
            specimenUuid: specimenUuid,
          ),
          from: specimenMediaProvider,
          name: r'specimenMediaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$specimenMediaHash,
          dependencies: SpecimenMediaFamily._dependencies,
          allTransitiveDependencies:
              SpecimenMediaFamily._allTransitiveDependencies,
        );

  final String specimenUuid;

  @override
  bool operator ==(Object other) {
    return other is SpecimenMediaProvider && other.specimenUuid == specimenUuid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, specimenUuid.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$catalogFmtNotifierHash() =>
    r'9b1919ba48769138f474858cb3c9a9bcd91ad365';

/// See also [CatalogFmtNotifier].
@ProviderFor(CatalogFmtNotifier)
final catalogFmtNotifierProvider =
    AutoDisposeAsyncNotifierProvider<CatalogFmtNotifier, CatalogFmt>.internal(
  CatalogFmtNotifier.new,
  name: r'catalogFmtNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$catalogFmtNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CatalogFmtNotifier = AutoDisposeAsyncNotifier<CatalogFmt>;
String _$specimenEntryHash() => r'882b2dbaf69f7f477f9a0d3b6d319c4274fa7c08';

/// See also [SpecimenEntry].
@ProviderFor(SpecimenEntry)
final specimenEntryProvider = AutoDisposeAsyncNotifierProvider<SpecimenEntry,
    List<SpecimenData>>.internal(
  SpecimenEntry.new,
  name: r'specimenEntryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$specimenEntryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SpecimenEntry = AutoDisposeAsyncNotifier<List<SpecimenData>>;
String _$specimenTypesHash() => r'8c713b8bea707b9e74b5d7bea4df0ef5e8529abd';

/// See also [SpecimenTypes].
@ProviderFor(SpecimenTypes)
final specimenTypesProvider =
    AutoDisposeAsyncNotifierProvider<SpecimenTypes, List<String>>.internal(
  SpecimenTypes.new,
  name: r'specimenTypesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$specimenTypesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SpecimenTypes = AutoDisposeAsyncNotifier<List<String>>;
String _$treatmentOptionsHash() => r'b907834aa65670c7e556ca6ac7d1f225e882bb7e';

/// See also [TreatmentOptions].
@ProviderFor(TreatmentOptions)
final treatmentOptionsProvider =
    AutoDisposeAsyncNotifierProvider<TreatmentOptions, List<String>>.internal(
  TreatmentOptions.new,
  name: r'treatmentOptionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$treatmentOptionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TreatmentOptions = AutoDisposeAsyncNotifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
