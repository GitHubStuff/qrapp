// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrapp/classes/failure.dart';
import 'package:qrapp/qr_code_dto/qr_code_dto.dart';
import 'package:qrapp/services/get_service.dart';

void main() {
  test('Socket Error', () async {
    Either<Failure, QRCodeDTO> result = await GetSocketExceptionService().qrSeed();
    expect(result.isLeft(), true);
    result.fold((fail) {
      expect(fail.message, 'No Internet connectin');
    }, (qrCodeDTO) {});
  });

  test('HTTP 404 Error', () async {
    Either<Failure, QRCodeDTO> result = await Get404ExceptionService().qrSeed();
    expect(result.isLeft(), true);
    result.fold((fail) {
      expect(fail.message, 'HTTP 404');
    }, (qrCodeDTO) {});
  });

  test('Bad Data', () async {
    Either<Failure, QRCodeDTO> result = await GetBadDataService().qrSeed();
    expect(result.isLeft(), true);
    result.fold((fail) {
      expect(fail.message.isNotEmpty, true);
    }, (qrCodeDTO) {});
  });

  test('Good Data', () async {
    Either<Failure, QRCodeDTO> result = await GetTestService().qrSeed();
    expect(result.isRight(), true);
    result.fold((fail) {}, (qrCodeDTO) {
      expect(qrCodeDTO.seed, 'sample data');
      expect(qrCodeDTO.expiresAt, '2022-01-01T12:01:02.123T');
    });
  });
}
