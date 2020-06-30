import 'package:flutter/material.dart';

class CustomBoxDecoration {
  BoxDecoration create(Color bgcolor, double borderRadius) {
    return BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 2,
            spreadRadius: 1,
            offset: Offset(0, 1),
          )
        ]);
  }
}
