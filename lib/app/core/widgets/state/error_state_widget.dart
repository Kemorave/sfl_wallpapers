import 'package:sfl/app/core/failur.dart';
import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({Key? key, this.failur}) : super(key: key);
  final Failur? failur;
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'ErrorStateWidget is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
