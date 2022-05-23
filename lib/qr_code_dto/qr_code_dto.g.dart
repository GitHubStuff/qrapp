// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QRCodeDTO _$QRCodeDTOFromJson(Map<String, dynamic> json) => QRCodeDTO(
      seed: json['seed'] as String,
      expiresAt: json['expires_at'] as String,
    );

Map<String, dynamic> _$QRCodeDTOToJson(QRCodeDTO instance) => <String, dynamic>{
      'seed': instance.seed,
      'expires_at': instance.expiresAt,
    };
