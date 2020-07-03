import 'package:flutter/material.dart';

class CustomBoxDecoration {
  BoxDecoration create(Color bgcolor, double borderRadius) {
    return BoxDecoration(
      color: bgcolor,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFC3DBF7),
          blurRadius: 20,
          offset: Offset(0, 10),
        )
      ],
    );
  }
}
