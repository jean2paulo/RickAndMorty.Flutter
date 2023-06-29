import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DefaultLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 100, 
        child: Center(
          child: CircularProgressIndicator()
        )
      );
  }
}
