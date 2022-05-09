import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grpc_rocket/grpcurl/add.dart';
import 'package:grpc_rocket/grpcurl/parse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProtosTab extends StatefulWidget {
  const ProtosTab({Key? key}) : super(key: key);

  @override
  State<ProtosTab> createState() => _ProtosTabState();
}

class _ProtosTabState extends State<ProtosTab> {
  Widget prototab = Container();

  Widget current = Container();

  Widget getHead(String path) {
    return ProtoHead(name: path.split(Platform.pathSeparator).last);
  }

  Future<Widget> getProto(String path) async {
    List<Widget> elems = [];
    elems.add(const Divider());
    elems.add(getHead(path));
    var services = await parseProto(context, path);
    for (var service in services) {
      elems.add(const Divider());
      elems.add(ProtoServiceTile(name: service.name));
      for (var method in service.methods) {
        elems.add(ProtoServiceTile(
          name: method.name,
        ));
      }
    }
    return Column(
      children: elems,
      mainAxisSize: MainAxisSize.min,
    );
  }

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
      protosList.add(await getProto(protoPath));
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

class ProtoServiceTile extends StatelessWidget {
  final String name;
  const ProtoServiceTile({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.account_tree_rounded,
            size: 14,
            color: Colors.blueGrey[500],
          ),
          const SizedBox(width: 6),
          Text(name),
        ],
      ),
    );
  }
}

class ProtoMethodTile extends StatelessWidget {
  final ProtoMethod method;
  const ProtoMethodTile({
    Key? key,
    required this.method,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 14),
            Icon(
              Icons.send_rounded,
              size: 14,
              color: Colors.blueGrey[500],
            ),
            const SizedBox(width: 6),
            Text(method.name),
          ],
        ),
      ),
    );
  }
}

class ProtoHead extends StatelessWidget {
  final String name;
  const ProtoHead({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
