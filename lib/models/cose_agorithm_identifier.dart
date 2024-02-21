import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum COSEAlgorithmIdentifier {
  ES256(-7),
  ES384(-35),
  ES512(-36),
  EdDSA(-8);

  const COSEAlgorithmIdentifier(this.value,);

  final int value;
}
