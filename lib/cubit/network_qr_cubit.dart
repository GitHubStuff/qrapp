// State management class for network downloads, providing
// inital, returned, error events.
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../classes/failure.dart';
import '../qr_code_dto/qr_code_dto.dart';
import '../services/get_service.dart';

part 'network_qr_state.dart';

class NetworkQrCubit extends Cubit<NetworkQrState> {
  NetworkQrCubit() : super(NetworkQrInitial());

  void download() async {
    final GetService service = Modular.get<GetService>();
    Either<Failure, QRCodeDTO> seedResult = await service.qrSeed();
    seedResult.fold((fail) {
      emit(NetworkFailure(fail));
    }, (qrData) {
      emit(NetworkDownloadedQR(qrData.seed));
    });
  }
}
