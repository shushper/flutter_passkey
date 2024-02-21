import 'package:flutter/services.dart';

import 'flutter_passkey_platform_interface.dart';
import 'models/public_key_credential_creation_options.dart';

class FlutterPasskey {
  Future<String?> getPlatformVersion() {
    return FlutterPasskeyPlatform.instance.getPlatformVersion();
  }

  Future<String> createCredential(
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
}
