import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestsTab extends StatefulWidget {
  const TestsTab({Key? key}) : super(key: key);

  @override
  State<TestsTab> createState() => _TestsTabState();
}

class _TestsTabState extends State<TestsTab> {
  // TODO remove clear protos
  removeProtos() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('proto_file_pathes');
    prefs.remove('adresses');
  }

  @override
  void initState() {
    super.initState();
    removeProtos();
  }

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.terminal_rounded,
      size: 112,
    );
  }
}
