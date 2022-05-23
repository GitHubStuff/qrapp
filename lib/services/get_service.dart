// Class the defines an HTTP level operation to 'GET' a QRString from the network.
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:qrapp/qr_code_dto/qr_code_dto.dart';

import '../classes/failure.dart';
import '../classes/random_string.dart' as str;

/// Using this abstract class, it is possible to create production (actually http call) or
/// to simulate an HTTP call (see FakeService). For testing, there are classes that
/// implement GetService but return failure/issue objects for Unit Testing without
/// the need to swizzle in http failure scenerios
abstract class GetService {
  Future<Either<Failure, QRCodeDTO>> qrSeed({String? url});
}

/// Uses a randon string generator to simulate data return from a server
class FakeService extends GetService {
  @override
  Future<Either<Failure, QRCodeDTO>> qrSeed({String? url}) async {
    String data = str.getRandomString(15);
    String jsonString = '{"seed":"$data", "expires_at":"2022-01-01T12:01:02.123T"}';
    try {
      Map<String, dynamic> json = jsonDecode(jsonString);
      return Right(QRCodeDTO.fromJson(json));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

/// Class with fixed values to unit test GetService
class GetTestService extends GetService {
  @override
  Future<Either<Failure, QRCodeDTO>> qrSeed({String? url}) async {
    String jsonString = '{"seed":"sample data", "expires_at":"2022-01-01T12:01:02.123T"}';
    try {
      Map<String, dynamic> json = jsonDecode(jsonString);
      return Right(QRCodeDTO.fromJson(json));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

/// Class to simulate Bad Data returned from server
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

/// Class to simulate BadSocket returned from server
class GetSocketExceptionService extends GetService {
  @override
  Future<Either<Failure, QRCodeDTO>> qrSeed({String? url}) async {
    return Left(Failure('No Internet connectin'));
  }
}

/// Class to simulate 404 error returned from server
class Get404ExceptionService extends GetService {
  @override
  Future<Either<Failure, QRCodeDTO>> qrSeed({String? url}) async {
    return Left(Failure('HTTP 404'));
  }
}
