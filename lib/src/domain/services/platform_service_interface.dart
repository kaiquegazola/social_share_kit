import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class PlatformServiceInterface extends PlatformInterface {
  PlatformServiceInterface() : super(token: _token);

  static final Object _token = Object();

  Future<Map<String, bool>> getAvailableApps();
  Future<T> share<T>(Map<String, dynamic> arguments);
}
