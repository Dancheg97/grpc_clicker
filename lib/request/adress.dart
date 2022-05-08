import 'package:flutter/material.dart';

class AdressPanel extends StatefulWidget {
  const AdressPanel({Key? key}) : super(key: key);

  @override
  State<AdressPanel> createState() => _AdressPanelState();
}

class _AdressPanelState extends State<AdressPanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'service adress',
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        
      ),
    );
  }
}
