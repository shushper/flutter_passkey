import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_passkey/models/public_key_credential_request_options.dart';

import 'flutter_passkey_platform_interface.dart';
import 'models/authentication_response.dart';
import 'models/public_key_credential_creation_options.dart';
import 'models/registration_response.dart';

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
  Future<RegistrationResponse?> createCredential(
      PublicKeyCredentialCreationOptions options) async {
    final optionsString = jsonEncode(options.toJson());
    final response = await methodChannel
        .invokeMethod<String>('createCredential', {'options': optionsString});

    if (response != null) {
      return RegistrationResponse.fromJson(jsonDecode(response));
    } else {
      return null;
    }
  }

  @override
  Future<AuthenticationResponse?> getCredential(
      PublicKeyCredentialRequestOptions options) async {
    final optionsString = jsonEncode(options.toJson());
    print('MethodChannelFlutterPasskey get credential');
    print(optionsString);
    final response = await methodChannel
        .invokeMethod<String>('getCredential', {'options': optionsString});

    if (response != null) {
      return AuthenticationResponse.fromJson(jsonDecode(response));
    } else {
      return null;
    }
  }
}
