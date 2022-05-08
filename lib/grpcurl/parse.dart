import 'dart:convert';
import 'dart:io';

import 'package:grpc_rocket/dialog/show.dart';

const ls = LineSplitter();

class ProtoElem {
  final bool isService;
  final String name;
  ProtoElem({
    required this.isService,
    required this.name,
  });
}

Future<List<ProtoElem>> parseProto(context, String path) async {
  var callResult = await Process.run(
    'grpcurl',
    ['-import-path', '/', '-proto', path, 'describe'],
  );
  if (callResult.exitCode != 0) {
    showNotification(context, NotificationType.protoParseError);
    return [];
  }
  List<ProtoElem> protoElems = [];
  List<String> lines = ls.convert("${callResult.stdout}");
  for (var line in lines) {
    if (line.contains('service') && line.contains('{')) {
      var name = line.replaceAll('service ', '').replaceAll(' {', '');
      protoElems.add(ProtoElem(isService: true, name: name));
      continue;
    }
    if (line.contains('rpc') && line.contains('returns')) {
      var name = line.substring(line.indexOf('rpc') + 4, line.indexOf('(') - 1);
      protoElems.add(ProtoElem(isService: false, name: name));
    }
  }
  return [];
}
