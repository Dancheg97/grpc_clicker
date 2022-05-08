import 'package:flutter/material.dart';
import 'package:grpc_rocket/grpcurl/add.dart';
import 'package:grpc_rocket/navigator/proto_widget.dart';
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
    var protos = prefs.getStringList('proto_file_pathes');
    if (protos == null) {
      protos = [];
      prefs.setStringList('proto_file_pathes', []);
    }
    if (protos.isEmpty) {
      setState(() {
        prototab = AddProto(
          onPressed: () async {
            var updated = await addNewProto(context);
            if (updated) {
              loadProtos();
            }
          },
        );
      });
      return;
    }
    List<Widget> protosList = [];
    for (var protoPath in protos) {
      protosList.add(ProtoDefinition(
        protoPath: protoPath,
      ));
    }
    protosList.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: AddProto(
        onPressed: () async {
          var updated = await addNewProto(context);
          if (updated) {
            loadProtos();
          }
        },
      ),
    ));
    setState(() {
      prototab = ListView(
        key: UniqueKey(),
        children: protosList,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    loadProtos();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: prototab,
      ),
    );
  }
}

class AddProto extends StatelessWidget {
  final Function onPressed;
  const AddProto({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          onPressed();
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
