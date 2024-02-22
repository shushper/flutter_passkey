// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_key_credential_descriptor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicKeyCredentialDescriptor _$PublicKeyCredentialDescriptorFromJson(
        Map<String, dynamic> json) =>
    PublicKeyCredentialDescriptor(
      type: $enumDecode(_$PublicKeyCredentialTypeEnumMap, json['type']),
      id: json['id'] as String,
      transports: (json['transports'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$AuthenticatorTransportEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$PublicKeyCredentialDescriptorToJson(
    PublicKeyCredentialDescriptor instance) {
  final val = <String, dynamic>{
    'type': _$PublicKeyCredentialTypeEnumMap[instance.type]!,
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'transports',
      instance.transports
          ?.map((e) => _$AuthenticatorTransportEnumMap[e]!)
          .toList());
  return val;
}

const _$PublicKeyCredentialTypeEnumMap = {
  PublicKeyCredentialType.publicKey: 'public-key',
};

const _$AuthenticatorTransportEnumMap = {
  AuthenticatorTransport.usb: 'usb',
  AuthenticatorTransport.nfc: 'nfc',
  AuthenticatorTransport.ble: 'ble',
  AuthenticatorTransport.smartCard: 'smart-card',
  AuthenticatorTransport.hybrid: 'hybrid',
  AuthenticatorTransport.internal: 'internal',
};
