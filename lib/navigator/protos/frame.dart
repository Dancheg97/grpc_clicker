import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProtosTab extends StatefulWidget {
  const ProtosTab({Key? key}) : super(key: key);

  @override
  State<ProtosTab> createState() => _ProtosTabState();
}

class _ProtosTabState extends State<ProtosTab> {
  Widget prototab = Container();

  loadProtos() async {
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('protos');
    if (protos == null) {
      protos = [];
      prefs.setStringList('protos', []);
    }
    if (protos.isEmpty) {
      setState(() {
        prototab = const AddProto();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadProtos();
  }

  @override
  Widget build(BuildContext context) {
    return prototab;
  }
}

class AddProto extends StatelessWidget {
  const AddProto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.add),
              Text('add new proto'),
            ],
          ),
        ),
      ),
    );
  }
}
