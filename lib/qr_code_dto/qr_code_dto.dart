// Data Transfer Object (DTO) of class that represents/maps the json string
// retured by the server.
import 'package:json_annotation/json_annotation.dart';

part 'qr_code_dto.g.dart';

@JsonSerializable()
class QRCodeDTO {
  final String seed;
  @JsonKey(name: 'expires_at')
  final String expiresAt;

  QRCodeDTO({required this.seed, required this.expiresAt});

  factory QRCodeDTO.fromJson(Map<String, dynamic> json) => _$QRCodeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$QRCodeDTOToJson(this);
}
