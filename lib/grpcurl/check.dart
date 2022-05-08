import 'dart:io';

Future<bool> checkProto(String path) async {
  var callResult = await Process.run(
    'grpcurl',
    ['-import-path', '/', '-proto', path, 'describe'],
  );
  if (callResult.exitCode == 0) {
    return true;
  }
  return false;
}
