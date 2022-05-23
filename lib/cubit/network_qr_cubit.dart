import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'network_qr_state.dart';

class NetworkQrCubit extends Cubit<NetworkQrState> {
  NetworkQrCubit() : super(NetworkQrInitial());

  void download() async {
    
  }
}
