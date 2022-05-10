import 'dart:convert';
import 'dart:io';

import 'package:grpc_rocket/dialog/show.dart';

const ls = LineSplitter();

class ProtoService {
  final String name;
  final String fullName;
  List<ProtoMethod> methods;
  ProtoService(
    this.name,
    this.methods,
    this.fullName,
  );
}

class ProtoMethod {
  final String name;
  final String fullName;
  final String inMessage;
  final String outMessage;
  final String protoPath;
  ProtoMethod({
    required this.name,
    required this.fullName,
    required this.inMessage,
    required this.outMessage,
    required this.protoPath,
  });
}

Future<List<ProtoService>> parseProto(context, String path) async {
  // TODO find service error
  var callResult = await Process.run(
    'grpcurl',
    ['-import-path', '/', '-proto', path, 'describe'],
  );
  if (callResult.exitCode != 0) {
    showNotification(context, NotificationType.protoParseError);
    return [];
  }
  String apiFullName = '';
  List<String> lines = ls.convert("${callResult.stdout}");
  List<ProtoService> services = [];
  ProtoService currentService = ProtoService('', [], '');
  for (var line in lines) {
    if (line.endsWith(' is a service:')) {
      apiFullName = line.replaceAll(' is a service:', '');
      if (apiFullName.contains('.')) {
        apiFullName = apiFullName.split('.')[0];
      }
    }
    if (line.contains('service') && line.contains('{')) {
      var name = line.replaceAll('service ', '').replaceAll(' {', '');
      if (currentService.name != '') {
        services.add(currentService);
      }
      currentService = ProtoService(name, [], '$apiFullName$name');
    }
    if (line.contains('rpc') && line.contains('returns')) {
      var name = line.substring(
        line.indexOf('rpc') + 4,
        line.indexOf('(') - 1,
      );
      var inmsg = line.substring(
        line.indexOf('(') + 2,
        line.indexOf(')') - 1,
      );
      var outmsg = line.substring(
        line.indexOf(' returns ( ') + 11,
        line.indexOf(');') - 1,
      );
      currentService.methods.add(
        ProtoMethod(
          name: name,
          fullName: '$apiFullName.${currentService.name}/$name',
          inMessage: inmsg,
          outMessage: outmsg,
          protoPath: path,
        ),
      );
    }
  }
  services.add(currentService);
  return services;
}
