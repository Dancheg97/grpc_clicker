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

  static Future<ProtoStructure> proto(context, String path) async {
    var callResult = await Process.run(
      'grpcurl',
      ['-import-path', '/', '-proto', path, 'describe'],
    );
    if (callResult.exitCode != 0) {
      return ProtoStructure(
        path: path,
        error: callResult.stderr,
        services: [],
      );
    }
    String apiFullName = '';
    List<String> lines = ls.convert("${callResult.stdout}");
    List<ProtoService> services = [];
    ProtoService currentService = ProtoService(
      showName: '',
      protoName: '',
      methods: [],
    );
    for (var line in lines) {
      if (line.endsWith(' is a service:')) {
        apiFullName = line.replaceAll(' is a service:', '');
        if (apiFullName.contains('.')) {
          var splitted = apiFullName.split('.');
          splitted.remove(splitted.last);
          apiFullName = splitted.join('.');
        }
      }
      if (line.contains('service') && line.contains('{')) {
        var name = line.replaceAll('service ', '').replaceAll(' {', '');
        if (currentService.showName != '') {
          services.add(currentService);
        }
        currentService = ProtoService(
          showName: name,
          protoName: '$apiFullName.$name',
          methods: [],
        );
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
    return ProtoStructure(
      path: path,
      error: '',
      services: services,
    );
  }

  static Future<ProtoFields> message(String proto, String message) async {
    if (message == '.google.protobuf.Empty') {
      return ProtoFields(error: '', fields: []);
    }
    var callResult = await Process.run(
      'grpcurl',
      ['-import-path', '/', '-proto', proto, 'describe', message],
    );
    if (callResult.exitCode != 0) {
      return ProtoFields(error: callResult.stderr, fields: []);
    }
    var fields = ProtoFields(error: '', fields: []);
    List<String> lines = ls.convert("${callResult.stdout}");
    for (var line in lines) {
      if (line.contains('=') && line.contains(';')) {
        var splitted = line.split(' ');
        if (splitted[2].contains('map')) {
          var key = splitted[2].replaceAll('map<', '').replaceAll(',', '');
          var value = splitted[3].replaceAll('>', '');
          fields.fields.add(ProtoField(
            name: splitted[4],
            type: 'map<$key, $value>',
            fill: '{}',
            optional: false,
          ));
          continue;
        }
        if (splitted[2] == 'repeated') {
          fields.fields.add(ProtoField(
            name: splitted[4],
            type: 'repeated ${splitted[3]}',
            fill: '[]',
            optional: false,
          ));
          continue;
        }
        var isOptional = false;
        if (splitted[2] == 'optional') {
          isOptional = true;
          splitted.remove(splitted[2]);
        }
        var type = splitted[2];
        if (type == 'float' || type == 'double') {
          fields.fields.add(ProtoField(
            name: splitted[3],
            type: type,
            fill: '1.0',
            optional: isOptional,
          ));
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
          fields.fields.add(ProtoField(
            name: splitted[3],
            type: type,
            fill: '1',
            optional: isOptional,
          ));
          continue;
        }
        if (type == 'bool') {
          fields.fields.add(ProtoField(
            name: splitted[3],
            type: type,
            fill: 'false',
            optional: isOptional,
          ));
          continue;
        }
        if (type == 'string') {
          fields.fields.add(ProtoField(
            name: splitted[3],
            type: type,
            fill: '"some string"',
            optional: isOptional,
          ));
          continue;
        }
        if (type == 'bytes') {
          fields.fields.add(ProtoField(
            name: splitted[3],
            type: type,
            fill: '"aGVsbG8gd29ybGQ="',
            optional: isOptional,
          ));
          continue;
        }
        fields.fields.add(ProtoField(
          name: splitted[3],
          type: type,
          fill: '"?"',
          optional: isOptional,
        ));
      }
    }
    return fields;
  }

  static String json(ProtoFields fields) {
    var resultString = '{\n';
    for (var field in fields.fields) {
      resultString += '    "' + field.name + '": ' + field.fill + ',\n';
    }
    resultString = resultString.substring(0, resultString.length - 2);
    resultString += '\n}';
    return resultString;
  }

  static Future<Response> sendRequest({
    required String path,
    required String req,
    required String adress,
    required String method,
  }) async {
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
    return Response(
      result: '${sendResult.stdout}',
      error: '${sendResult.stderr}',
    );
  }
}

class ProtoStructure {
  final String path;
  final List<ProtoService> services;
  final String error;
  ProtoStructure({
    required this.path,
    required this.services,
    required this.error,
  });
}

class ProtoService {
  final String showName;
  final String protoName;
  List<ProtoMethod> methods;
  ProtoService({
    required this.showName,
    required this.protoName,
    required this.methods,
  });
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

class Response {
  final String error;
  final String result;
  Response({
    required this.error,
    required this.result,
  });
}

class ProtoFields {
  final String error;
  final List<ProtoField> fields;
  ProtoFields({
    required this.error,
    required this.fields,
  });
}

class ProtoField {
  final String name;
  final String type;
  final String fill;
  final bool optional;
  ProtoField({
    required this.name,
    required this.type,
    required this.fill,
    required this.optional,
  });
}
