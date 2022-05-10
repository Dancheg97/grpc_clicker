import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class CallResult {
  final String result;
  final String error;
  CallResult({
    required this.result,
    required this.error,
  });
}

Future<CallResult> sendRequst() async {
  var prefs = await SharedPreferences.getInstance();
  var adress = prefs.getString('adress')!;
  var req = prefs.getString('req')!;
  var proto = prefs.getString('proto')!;
  var method = prefs.getString('method')!;
  var sendResult = await Process.run(
    'grpcurl',
    [
      '-import-path',
      '/',
      '-proto',
      proto,
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
