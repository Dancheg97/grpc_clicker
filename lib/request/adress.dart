import 'package:awesome_dialog/awesome_dialog.dart';
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
    if (controller.text == "") {
      showNotification(context, NotificationType.adressEmpty);
      return;
    }
    if (adresses.contains(controller.text)) {
      showNotification(context, NotificationType.adressExists);
      return;
    }
    adresses.add(controller.text);
    prefs.setStringList('adresses', adresses);
    showNotification(context, NotificationType.adressSaved);
  }

  loadAdress() async {
    var prefs = await SharedPreferences.getInstance();
    var adresses = prefs.getStringList('adresses') ?? [];
    List<Widget> buttons = [];
    buttons.add(Text(
      'Choose adress to load',
      style: Theme.of(context).textTheme.titleMedium,
    ));
    for (var adress in adresses) {
      buttons.add(AdressButton(
        text: adress,
        controller: controller,
      ));
    }
    AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: buttons,
        ),
      ),
      width: dialogWidth,
      showCloseIcon: showCloseIcon,
    ).show();
  }

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
                  loadAdress();
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

class AdressButton extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  const AdressButton({
    Key? key,
    required this.text,
    required this.controller,
  }) : super(key: key);

  @override
  State<AdressButton> createState() => _AdressButtonState();
}

class _AdressButtonState extends State<AdressButton> {
  Widget currentWidget = Container();

  @override
  void initState() {
    currentWidget = RemovableAdressButton(
      controller: widget.controller,
      text: widget.text,
      fold: () {
        setState(() {
          currentWidget = Container();
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      child: currentWidget,
      duration: const Duration(milliseconds: 377),
    );
  }
}

class RemovableAdressButton extends StatelessWidget {
  final Function fold;
  const RemovableAdressButton({
    Key? key,
    required this.controller,
    required this.text,
    required this.fold,
  }) : super(key: key);

  final TextEditingController controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 4, 2, 4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                controller.text = text;
                Navigator.pop(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              var prefs = await SharedPreferences.getInstance();
              var adresses = prefs.getStringList('adresses') ?? [];
              adresses.remove(text);
              prefs.setStringList('adresses', adresses);
              fold();
            },
            color: Theme.of(context).hintColor,
            icon: const Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}
