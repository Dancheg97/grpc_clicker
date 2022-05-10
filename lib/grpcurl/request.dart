import 'dart:convert';
import 'dart:io';

const ls = LineSplitter();

Future<String> parseRequst(String protoPath, String msgName) async {
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
        fields[wrapField(splitted[4])] = '{}';
        continue;
      }
      if (splitted[2] == 'repeated') {
        fields[wrapField(splitted[4])] = '[]';
        continue;
      }
      if (splitted[2] == 'optional') {
        splitted.remove(splitted[2]);
      }
      var type = splitted[2];
      if (type == 'float' || type == 'double') {
        fields[wrapField(splitted[3])] = '1.0';
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
        fields[wrapField(splitted[3])] = '1';
        continue;
      }
      if (type == 'bool') {
        fields[wrapField(splitted[3])] = 'false';
        continue;
      }
      if (type == 'string') {
        fields[wrapField(splitted[3])] = '"some_string"';
        continue;
      }
      if (type == 'bytes') {
        fields[wrapField(splitted[3])] = '"aGVsbG8gd29ybGQ="';
        continue;
      }
      fields[wrapField(splitted[3])] = '"?"';
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

String wrapField(String field) {
  return '"' + field + '"';
}
