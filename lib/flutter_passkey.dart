
import 'flutter_passkey_platform_interface.dart';

class FlutterPasskey {
  Future<String?> getPlatformVersion() {
    return FlutterPasskeyPlatform.instance.getPlatformVersion();
  }
}
