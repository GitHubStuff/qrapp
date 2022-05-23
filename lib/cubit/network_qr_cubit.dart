import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'network_qr_state.dart';

class NetworkQrCubit extends Cubit<NetworkQrState> {
  NetworkQrCubit() : super(NetworkQrInitial());

  void download() async {}
}
