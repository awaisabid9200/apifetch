import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimi extends StatelessWidget {
  const LoadingAnimi({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.beat(color: Colors.blue,size: 100),
    );
  }
}
