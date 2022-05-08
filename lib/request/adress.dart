import 'package:flutter/material.dart';
import 'package:grpc_rocket/dialog/show.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdressPanel extends StatefulWidget {
  const AdressPanel({Key? key}) : super(key: key);

  @override
  State<AdressPanel> createState() => _AdressPanelState();
}

class _AdressPanelState extends State<AdressPanel> {
  var controller = TextEditingController();

  saveAdress() async {
    var prefs = await SharedPreferences.getInstance();
    var adresses = prefs.getStringList('adresses') ?? [];
    if (!adresses.contains(controller.text) && controller.text != "") {
      adresses.add(controller.text);
    }
    prefs.setStringList('adresses', adresses);
    showNotification(context, NotificationType.adressSaved);
  }

  loadAdress() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'service adress',
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.upload_rounded),
                onPressed: () {
                  saveAdress();
                },
              ),
              IconButton(
                icon: const Icon(Icons.save_rounded),
                onPressed: () {
                  saveAdress();
                },
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
        onChanged: (text) async {
          var prefs = await SharedPreferences.getInstance();
          prefs.setString('adress', text);
        },
      ),
    );
  }
}
