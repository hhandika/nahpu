// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narrative.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$narrativeMediaHash() => r'2590b064ddd1667c284ae7c5af4f27dc25eaeadb';

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

typedef NarrativeMediaRef = AutoDisposeFutureProviderRef<List<MediaData>>;

/// See also [narrativeMedia].
@ProviderFor(narrativeMedia)
const narrativeMediaProvider = NarrativeMediaFamily();

/// See also [narrativeMedia].
class NarrativeMediaFamily extends Family<AsyncValue<List<MediaData>>> {
  /// See also [narrativeMedia].
  const NarrativeMediaFamily();

  /// See also [narrativeMedia].
  NarrativeMediaProvider call({
    required int narrativeId,
  }) {
    return NarrativeMediaProvider(
      narrativeId: narrativeId,
    );
  }

  @override
  NarrativeMediaProvider getProviderOverride(
    covariant NarrativeMediaProvider provider,
  ) {
    return call(
      narrativeId: provider.narrativeId,
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
  String? get name => r'narrativeMediaProvider';
}

/// See also [narrativeMedia].
class NarrativeMediaProvider
    extends AutoDisposeFutureProvider<List<MediaData>> {
  /// See also [narrativeMedia].
  NarrativeMediaProvider({
    required this.narrativeId,
  }) : super.internal(
          (ref) => narrativeMedia(
            ref,
            narrativeId: narrativeId,
          ),
          from: narrativeMediaProvider,
          name: r'narrativeMediaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$narrativeMediaHash,
          dependencies: NarrativeMediaFamily._dependencies,
          allTransitiveDependencies:
              NarrativeMediaFamily._allTransitiveDependencies,
        );

  final int narrativeId;

  @override
  bool operator ==(Object other) {
    return other is NarrativeMediaProvider && other.narrativeId == narrativeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, narrativeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$narrativeEntryHash() => r'42820d2e5f2c0f1d10e306b74ced76e1ed236df2';

/// See also [NarrativeEntry].
@ProviderFor(NarrativeEntry)
final narrativeEntryProvider = AutoDisposeAsyncNotifierProvider<NarrativeEntry,
    List<NarrativeData>>.internal(
  NarrativeEntry.new,
  name: r'narrativeEntryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$narrativeEntryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NarrativeEntry = AutoDisposeAsyncNotifier<List<NarrativeData>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
