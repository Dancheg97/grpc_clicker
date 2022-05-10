import 'package:flutter/material.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.book,
          size: 112,
        ),
        Text(
          'Under development',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
