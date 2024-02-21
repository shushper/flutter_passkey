import 'package:flutter_passkey/flutter_passkey.dart';
import 'package:flutter_passkey/flutter_passkey_method_channel.dart';
import 'package:flutter_passkey/flutter_passkey_platform_interface.dart';
import 'package:flutter_passkey/models/public_key_credential_creation_options.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPasskeyPlatform
    with MockPlatformInterfaceMixin
    implements FlutterPasskeyPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String> createCredential(PublicKeyCredentialCreationOptions options) {
    return Future.value('credential');
  }
}

void main() {
  final FlutterPasskeyPlatform initialPlatform =
      FlutterPasskeyPlatform.instance;

  test('$MethodChannelFlutterPasskey is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPasskey>());
  });

  test('getPlatformVersion', () async {
    FlutterPasskey flutterPasskeyPlugin = FlutterPasskey();
    MockFlutterPasskeyPlatform fakePlatform = MockFlutterPasskeyPlatform();
    FlutterPasskeyPlatform.instance = fakePlatform;

    expect(await flutterPasskeyPlugin.getPlatformVersion(), '42');
  });
}
