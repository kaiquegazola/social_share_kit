import 'dart:io';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:social_share_kit/src/domain/services/platform_service_interface.dart';

/// An implementation of [PlatformServiceInterface] that uses method
/// channels to provide information.
class MethodChannelPlatformService extends PlatformServiceInterface {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('social_share_kit');

  @override
  Future<Map<String, bool>> getAvailableApps() async {
    final availableApps = await methodChannel.invokeMapMethod<String, bool>(
      'getAvailableApps',
    );
    if (availableApps != null) {
      return availableApps;
    }
    return {};
  }

  @override
  Future<T> share<T>(Map<String, dynamic> arguments) async {
    final shared = await methodChannel.invokeMethod<T>('share', arguments);
    if (shared == null) {
      throw Exception("MethodChannelPlatformService can't share $arguments");
    }
    return shared;
  }

  @override
  Future<String?> getMd5Signature() async {
    if (Platform.isAndroid) {
      return methodChannel.invokeMethod<String?>(
        'getMd5Signature',
      );
    } else {
      return null;
    }
  }
}
