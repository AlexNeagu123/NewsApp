import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner extends StatelessWidget {
  const Spinner({super.key});

  @override
  build(BuildContext context) {
    return const Center(
        child: SpinKitRing(
      color: Colors.blue,
      size: 30,
      lineWidth: 4,
      duration: Duration(milliseconds: 1000),
    ));
  }
}
