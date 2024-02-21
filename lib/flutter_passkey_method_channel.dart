import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_passkey_platform_interface.dart';
import 'models/public_key_credential_creation_options.dart';

/// An implementation of [FlutterPasskeyPlatform] that uses method channels.
class MethodChannelFlutterPasskey extends FlutterPasskeyPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_passkey');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> createCredential(
      PublicKeyCredentialCreationOptions options) async {
    final optionsString = jsonEncode(options.toJson());
    final response = await methodChannel
        .invokeMethod<String>('createCredential', {'options': optionsString});

    return response;
  }

  @override
  Future<String?> getCredential(String options) async {
    final response = await methodChannel
        .invokeMethod<String>('getCredential', {'options': options});
    return response;
  }
}
