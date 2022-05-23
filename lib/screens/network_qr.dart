import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                Future.delayed(const Duration(milliseconds: 150), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRGenerator(qrString: state.qrData),
                    ),
                  );
                });
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      );
}
