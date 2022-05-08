import 'dart:io';

import 'package:grpc_rocket/dialog/show.dart';

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
  if (callResult.exitCode == 0) {
    showNotification(context, NotificationType.protoParseError);
    return [];
  }
  var output = "${callResult.stderr}";
  print(output);
  return [];
}
