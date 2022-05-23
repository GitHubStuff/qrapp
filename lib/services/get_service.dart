import 'package:dartz/dartz.dart';
import 'package:qrapp/qr_code_dto/qr_code_dto.dart';

import '../classes/failure.dart';

abstract class GetService {
  Future<Either<Failure, QRCodeDTO>> qrSeed({String? url});
}

class GetSocketExceptionService extends GetService {
  @override
  Future<Either<Failure, QRCodeDTO>> qrSeed({String? url}) async {
    return Left(Failure('No Internet connectin'));
  }
}
