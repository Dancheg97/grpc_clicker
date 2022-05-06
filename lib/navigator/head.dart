import 'package:flutter/material.dart';

class HeadSwitch extends StatelessWidget {
  final Function() goToApis;
  final Function() goToHistory;
  final Function() goToTests;
  const HeadSwitch({
    Key? key,
    required this.goToApis,
    required this.goToHistory,
    required this.goToTests,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CutomButton(
            onPressed: goToApis,
            text: "API's",
          ),
          CutomButton(
            onPressed: goToApis,
            text: "history",
          ),
          CutomButton(
            onPressed: goToApis,
            text: "tests",
          ),
        ],
      ),
    );
  }
}

class CutomButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const CutomButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 15.4),
        ),
      ),
    );
  }
}
