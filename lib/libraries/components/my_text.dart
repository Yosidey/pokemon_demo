import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({super.key, required this.text, this.bold = false, this.font,  this.color});

  final String text;
  final bool bold;
  final double? font;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: font ?? 16, fontWeight: bold ? FontWeight.bold : FontWeight.normal,color: color??Colors.black));
  }
}

class TitleSub extends StatelessWidget {
  const TitleSub({super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText(text: title.toUpperCase(), font: 16, bold: true),
        MyText(text: subTitle.toUpperCase()),
      ],
    );
  }
}
