import 'package:flutter/material.dart';

class BuildTopCircle extends StatelessWidget {
  final blueColor = Color(0XFF5e92f3);
  double offSetValue;
  BuildTopCircle({@required this.offSetValue});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Transform.translate(
        offset: Offset(0.0, -MediaQuery.of(context).size.width / offSetValue),
        child: Transform.scale(
          scale: 1.35,
          child: Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: blueColor,
                borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width,
                )),
          ),
        ),
      ),
    );
  }
}
