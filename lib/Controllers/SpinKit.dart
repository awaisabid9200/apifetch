import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomSpinner extends StatefulWidget {
  final Color color;
  final double size;

  CustomSpinner({this.color = Colors.blue, this.size = 50.0});

  @override
  _CustomSpinnerState createState() => _CustomSpinnerState();
}

class _CustomSpinnerState extends State<CustomSpinner> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitPulse(
        color: widget.color,
        size: widget.size,
      ),
    );
  }
}
