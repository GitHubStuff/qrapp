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
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    Either<Failure, QRCodeDTO> result = await GetSocketExceptionService().qrSeed();
    expect(result.isLeft(), true);
    result.fold((fail) {
      expect(Left(Failure('No Internet connectin')), fail);
    }, (qrCodeDTO) {});
  });
}
