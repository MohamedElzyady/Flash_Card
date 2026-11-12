import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final String? family;
  final double?hight;
  const CustomText({
    super.key,
    required this.text,
    this.size,
    this.color,
    this.weight,
    this.family, this.hight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
        fontFamily: family,
        height: hight
      ),
    );
  }
}
