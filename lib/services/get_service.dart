import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:qrapp/qr_code_dto/qr_code_dto.dart';

import '../classes/failure.dart';

abstract class GetService {
  Future<Either<Failure, QRCodeDTO>> qrSeed({String? url});
}

class GetTestService extends GetService {
  @override
  Future<Either<Failure, QRCodeDTO>> qrSeed({String? url}) async {
    await Future.delayed(const Duration(seconds: 1));
    String jsonString = '{"seed":"sample data", "expires_at":"2022-01-01T12:01:02.123T"}';
    try {
      Map<String, dynamic> json = jsonDecode(jsonString);
      return Right(QRCodeDTO.fromJson(json));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

class GetBadDataService extends GetService {
  @override
  Future<Either<Failure, QRCodeDTO>> qrSeed({String? url}) async {
    String jsonString = '[{"seed":"sample data", "expires_at":"2022-01-01T12:01:02.123T"}';
    try {
      Map<String, dynamic> json = jsonDecode(jsonString);
      return Right(QRCodeDTO.fromJson(json));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

class GetSocketExceptionService extends GetService {
  @override
  Future<Either<Failure, QRCodeDTO>> qrSeed({String? url}) async {
    return Left(Failure('No Internet connectin'));
  }
}

class Get404ExceptionService extends GetService {
  @override
  Future<Either<Failure, QRCodeDTO>> qrSeed({String? url}) async {
    return Left(Failure('HTTP 404'));
  }
}
