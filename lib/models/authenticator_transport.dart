import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.kebab)
enum AuthenticatorTransport {
  usb,
  nfc,
  ble,
  smartCard,
  hybrid,
  internal
}