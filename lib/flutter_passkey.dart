import 'package:flutter/services.dart';
import 'package:flutter_passkey/models/registration_response.dart';

import 'flutter_passkey_platform_interface.dart';
import 'models/public_key_credential_creation_options.dart';

class FlutterPasskey {

  Future<String?> getPlatformVersion() {
    return FlutterPasskeyPlatform.instance.getPlatformVersion();
  }

  Future<bool> isSupported() async {
    final isSupported = await FlutterPasskeyPlatform.instance
        .getPlatformVersion()
        .then((osVersion) {
      if (osVersion == null) {
        return false;
      }
      final list = osVersion.split(' ');
      final version = int.tryParse(list[1].split('.').first) ?? 0;
      switch (list.first) {
        case 'iOS':
          return (version >= 15);
        case 'Android':
          return (version >= 9);
        default:
          return false;
      }
    });
    return isSupported;
  }


  Future<RegistrationResponse> createCredential(
    PublicKeyCredentialCreationOptions options,
  ) async {
    final response =
        await FlutterPasskeyPlatform.instance.createCredential(options);
    if (response == null) {
      throw PlatformException(
          code: "null-response",
          message: "Unable to get response from Passkey.");
    }
    return response;
  }

  Future<String> getCredential(String options) async {
    final response =
        await FlutterPasskeyPlatform.instance.getCredential(options);
    if (response == null) {
      throw PlatformException(
          code: "null-response",
          message: "Unable to get response from Passkey.");
    }
    return response;
  }
}
