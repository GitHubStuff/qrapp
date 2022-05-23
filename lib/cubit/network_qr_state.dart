// States around the network call for a the qr seed.
part of 'network_qr_cubit.dart';

@immutable
abstract class NetworkQrState {}

class NetworkQrInitial extends NetworkQrState {}

class NetworkDownloadedQR extends NetworkQrState {
  final String qrData;
  NetworkDownloadedQR(this.qrData);
}

class NetworkFailure extends NetworkQrState {
  final Failure failure;
  NetworkFailure(this.failure);
}
