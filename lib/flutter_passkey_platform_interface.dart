import 'package:flutter_passkey/models/public_key_credential_creation_options.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_passkey_method_channel.dart';
import 'models/registration_response.dart';

abstract class FlutterPasskeyPlatform extends PlatformInterface {
  /// Constructs a FlutterPasskeyPlatform.
  FlutterPasskeyPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPasskeyPlatform _instance = MethodChannelFlutterPasskey();

  /// The default instance of [FlutterPasskeyPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPasskey].
  static FlutterPasskeyPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPasskeyPlatform] when
  /// they register themselves.
  static set instance(FlutterPasskeyPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<RegistrationResponse?> createCredential(PublicKeyCredentialCreationOptions options) {
    throw UnimplementedError(
        'createCredential(String options) has not been implemented.');
  }

  Future<String?> getCredential(String options) {
    throw UnimplementedError(
        'getCredential(String options) has not been implemented.');
  }

}
