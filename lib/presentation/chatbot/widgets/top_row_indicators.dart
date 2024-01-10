import 'package:flutter/material.dart';

class TopRowIndicators extends StatelessWidget {
  const TopRowIndicators({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('AlbertoCV GPT3.5'),
          Text('V.1'),
        ],
      ),
    );
  }
}
