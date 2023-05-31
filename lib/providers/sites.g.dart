// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sites.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$siteMediaHash() => r'fa651ae49536f275c6344f8c9dfb7eac80c74ac0';

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

typedef SiteMediaRef = AutoDisposeFutureProviderRef<List<dynamic>>;

/// See also [siteMedia].
@ProviderFor(siteMedia)
const siteMediaProvider = SiteMediaFamily();

/// See also [siteMedia].
class SiteMediaFamily extends Family<AsyncValue<List<dynamic>>> {
  /// See also [siteMedia].
  const SiteMediaFamily();

  /// See also [siteMedia].
  SiteMediaProvider call({
    required int siteId,
  }) {
    return SiteMediaProvider(
      siteId: siteId,
    );
  }

  @override
  SiteMediaProvider getProviderOverride(
    covariant SiteMediaProvider provider,
  ) {
    return call(
      siteId: provider.siteId,
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
  String? get name => r'siteMediaProvider';
}

/// See also [siteMedia].
class SiteMediaProvider extends AutoDisposeFutureProvider<List<dynamic>> {
  /// See also [siteMedia].
  SiteMediaProvider({
    required this.siteId,
  }) : super.internal(
          (ref) => siteMedia(
            ref,
            siteId: siteId,
          ),
          from: siteMediaProvider,
          name: r'siteMediaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$siteMediaHash,
          dependencies: SiteMediaFamily._dependencies,
          allTransitiveDependencies: SiteMediaFamily._allTransitiveDependencies,
        );

  final int siteId;

  @override
  bool operator ==(Object other) {
    return other is SiteMediaProvider && other.siteId == siteId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, siteId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions