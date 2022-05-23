// Screen that requests a network call for a QRCode and displays
// 1 - progress indicator
// 2 - any network errors that occur
// 3 - transfers to screen that will render the QRCode object returned
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:qrapp/cubit/network_qr_cubit.dart';

import 'qr_generator.dart';

class NetworkQR extends StatelessWidget {
  static const route = '/NetworkQR';

  NetworkQR({Key? key}) : super(key: key);

  final NetworkQrCubit cubit = NetworkQrCubit();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Network QR Value'),
        ),
        body: Center(
          child: BlocBuilder<NetworkQrCubit, NetworkQrState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is NetworkQrInitial) {
                cubit.download();
              }
              if (state is NetworkDownloadedQR) {
                Future.delayed(const Duration(milliseconds: 150), () async {
                  await Modular.to.pushNamed(QRGenerator.route, arguments: state.qrData);
                  Modular.to.pop();
                });
              }

              if (state is NetworkFailure) {
                return Text(state.failure.toString());
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      );
}
