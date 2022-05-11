import 'dart:convert';
import 'dart:io';

const ls = LineSplitter();

class Grpcurl {
  static Future<bool> check(String path) async {
    var callResult = await Process.run(
      'grpcurl',
      ['-import-path', '/', '-proto', path, 'describe'],
    );
    if (callResult.exitCode == 0) {
      return true;
    }
    return false;
  }

  static Future<ProtoServices> parseProto(context, String path) async {
    var callResult = await Process.run(
      'grpcurl',
      ['-import-path', '/', '-proto', path, 'describe'],
    );
    if (callResult.exitCode != 0) {
      return ProtoServices(callResult.stderr, []);
    }
    String apiFullName = '';
    List<String> lines = ls.convert("${callResult.stdout}");
    List<ProtoService> services = [];
    ProtoService currentService = ProtoService('', '', []);
    for (var line in lines) {
      if (line.endsWith(' is a service:')) {
        apiFullName = line.replaceAll(' is a service:', '');
        if (apiFullName.contains('.')) {
          apiFullName = apiFullName.split('.')[0];
        }
      }
      if (line.contains('service') && line.contains('{')) {
        var name = line.replaceAll('service ', '').replaceAll(' {', '');
        if (currentService.showName != '') {
          services.add(currentService);
        }
        currentService = ProtoService(name, '$apiFullName$name', []);
      }
      if (line.contains('rpc') && line.contains('returns')) {
        currentService.methods.add(ProtoMethod(
          protoName: line.substring(
            line.indexOf('rpc') + 4,
            line.indexOf('(') - 1,
          ),
          inMessage: line.substring(
            line.indexOf('(') + 2,
            line.indexOf(')') - 1,
          ),
          outMessage: line.substring(
            line.indexOf(' returns ( ') + 11,
            line.indexOf(');') - 1,
          ),
          protoPath: path,
        ));
      }
    }
    services.add(currentService);
    return ProtoServices('', services);
  }

  static Future<String> parseMessage(String protoPath, String msgName) async {
    if (msgName == '.google.protobuf.Empty') {
      return '';
    }
    var callResult = await Process.run(
      'grpcurl',
      ['-import-path', '/', '-proto', protoPath, 'describe', msgName],
    );
    if (callResult.exitCode != 0) {
      return '';
    }
    Map<String, String> fields = {};
    List<String> lines = ls.convert("${callResult.stdout}");
    for (var line in lines) {
      if (line.contains('=') && line.contains(';')) {
        var splitted = line.split(' ');
        if (splitted[2].contains('map')) {
          fields[_wrapField(splitted[4])] = '{}';
          continue;
        }
        if (splitted[2] == 'repeated') {
          fields[_wrapField(splitted[4])] = '[]';
          continue;
        }
        if (splitted[2] == 'optional') {
          splitted.remove(splitted[2]);
        }
        var type = splitted[2];
        if (type == 'float' || type == 'double') {
          fields[_wrapField(splitted[3])] = '1.0';
          continue;
        }
        var integers = [
          'int32',
          'int64',
          'uint32',
          'uint64',
          'sint32',
          'sint64',
          'fixed32',
          'fixed64',
          'sfixed32',
          'sfixed64',
        ];
        if (integers.contains(type)) {
          fields[_wrapField(splitted[3])] = '1';
          continue;
        }
        if (type == 'bool') {
          fields[_wrapField(splitted[3])] = 'false';
          continue;
        }
        if (type == 'string') {
          fields[_wrapField(splitted[3])] = '"some_string"';
          continue;
        }
        if (type == 'bytes') {
          fields[_wrapField(splitted[3])] = '"aGVsbG8gd29ybGQ="';
          continue;
        }
        fields[_wrapField(splitted[3])] = '"?"';
      }
    }
    var resultString = '{\n';
    fields.forEach((key, value) {
      resultString += '    ' + key + ': ' + value + ',\n';
    });
    resultString = resultString.substring(0, resultString.length - 2);
    resultString += '\n}';
    return resultString;
  }

  static Future<CallResult> sendRequest(
    String path,
    String req,
    String adress,
    String method,
  ) async {
    var sendResult = await Process.run(
      'grpcurl',
      [
        '-import-path',
        '/',
        '-proto',
        path,
        '-d',
        req,
        '-plaintext',
        adress,
        method
      ],
    );
    return CallResult(
      result: '${sendResult.stdout}',
      error: '${sendResult.stderr}',
    );
  }

  static String _wrapField(String field) {
    return '"' + field + '"';
  }
}

class ProtoServices {
  final String error;
  final List<ProtoService> services;
  ProtoServices(
    this.error,
    this.services,
  );
}

class ProtoService {
  final String showName;
  final String protoName;
  List<ProtoMethod> methods;
  ProtoService(
    this.showName,
    this.protoName,
    this.methods,
  );
}

class ProtoMethod {
  final String protoName;
  final String inMessage;
  final String outMessage;
  final String protoPath;
  ProtoMethod({
    required this.protoName,
    required this.inMessage,
    required this.outMessage,
    required this.protoPath,
  });
}

class CallResult {
  final String result;
  final String error;
  CallResult({
    required this.result,
    required this.error,
  });
}
