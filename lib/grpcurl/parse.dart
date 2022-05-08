import 'dart:convert';
import 'dart:io';

import 'package:grpc_rocket/dialog/show.dart';

const ls = LineSplitter();

class ProtoService {
  final String name;
  List<ProtoMethod> methods;
  ProtoService(this.name, this.methods);
}

class ProtoMethod {
  final String name;
  final String inMessage;
  final String outMessage;
  ProtoMethod(this.name, this.inMessage, this.outMessage);
}

Future<List<ProtoService>> parseProto(context, String path) async {
  var callResult = await Process.run(
    'grpcurl',
    ['-import-path', '/', '-proto', path, 'describe'],
  );
  if (callResult.exitCode != 0) {
    showNotification(context, NotificationType.protoParseError);
    return [];
  }
  List<String> lines = ls.convert("${callResult.stdout}");
  List<ProtoService> services = [];
  ProtoService currentService = ProtoService('', []);
  for (var line in lines) {
    if (line.contains('service') && line.contains('{')) {
      var name = line.replaceAll('service ', '').replaceAll(' {', '');
      if (currentService.name != '') {
        services.add(currentService);
      }
      currentService = ProtoService(name, []);
    }
    if (line.contains('rpc') && line.contains('returns')) {
      var name = line.substring(
        line.indexOf('rpc') + 4,
        line.indexOf('(') - 1,
      );
      var inmsg = line
          .substring(
            line.indexOf('(') + 2,
            line.indexOf(')') - 1,
          )
          .split('.');
      var outmsg = line
          .substring(
            line.indexOf(' returns ( ') + 11,
            line.indexOf(');') - 1,
          )
          .split('.');
      currentService.methods.add(ProtoMethod(name, inmsg.last, outmsg.last));
    }
  }
  services.add(currentService);
  return services;
}
