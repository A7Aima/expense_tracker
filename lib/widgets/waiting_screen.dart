import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  final BoxConstraints constrains;

  const WaitingScreen({
    this.constrains,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "No transactions added yet!",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 20),
        Container(
          height: constrains.maxHeight * 0.6,
          child: Image.asset(
            "assets/images/waiting.png",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
