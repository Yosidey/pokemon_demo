import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pokemon_demo/libraries/components/my_text.dart';
import 'package:pokemon_demo/libraries/data/app_data.dart';

class LinearStat extends StatelessWidget {
  const LinearStat({super.key, required this.name, required this.baseStat, required this.secondary});

  final String name;
  final int baseStat;
  final Color secondary;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: MyText(
          text: ability[name] ?? "",
          bold: true,
        )),
        const Gap(8),
        Expanded(
          flex: 9,
          child: Stack(
            alignment: Alignment.center,
            children: [
              LinearProgressIndicator(
                  value: baseStat / 100, minHeight: 32, borderRadius: BorderRadius.circular(16), color: secondary, backgroundColor: Colors.grey),
              MyText(text: "$baseStat%", bold: true, font: 16, color: Colors.white)
            ],
          ),
        ),
      ],
    );
  }
}
