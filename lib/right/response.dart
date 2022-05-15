import 'package:flutter/material.dart';
import 'package:grpc_clicker/colors.dart';
import 'package:grpc_clicker/providers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ResponseTab extends StatelessWidget {
  const ResponseTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ResponseProvider>(
      builder: (context, response, child) {
        if (response.response.error == 'wait') {
          return AnimatedSwitcher(
            switchInCurve: Curves.ease,
            duration: const Duration(milliseconds: 377),
            child: Column(
              key: UniqueKey(),
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitSpinningLines(
                  size: 72,
                  color: Palette.black,
                ),
                const Text('processing'),
              ],
            ),
          );
        }
        if (response.response.error == '' && response.response.result == '') {
          return AnimatedSwitcher(
            switchInCurve: Curves.ease,
            duration: const Duration(milliseconds: 377),
            child: Column(
              key: UniqueKey(),
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.album,
                  color: Palette.blackQ,
                  size: 72,
                ),
                const Text('gRPC response'),
              ],
            ),
          );
        }
        if (response.response.error == '') {
          return AnimatedSwitcher(
            switchInCurve: Curves.ease,
            duration: const Duration(milliseconds: 377),
            child: Column(
              key: UniqueKey(),
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.album_sharp,
                          size: 16,
                          color: Palette.black,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Success',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      expands: true,
                      maxLines: null,
                      controller: TextEditingController(
                        text: response.response.result,
                      ),
                      keyboardType: TextInputType.multiline,
                      textAlignVertical: TextAlignVertical.top,
                      cursorColor: Palette.black,
                      decoration: InputDecoration(
                        hintText: 'gRPC response',
                        contentPadding: const EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Palette.black, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Palette.black, width: 0.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return AnimatedSwitcher(
          switchInCurve: Curves.ease,
          duration: const Duration(milliseconds: 377),
          child: Column(
            key: UniqueKey(),
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 16,
                        color: Palette.black,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Error',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    expands: true,
                    maxLines: null,
                    controller: TextEditingController(
                      text: response.response.error,
                    ),
                    keyboardType: TextInputType.multiline,
                    textAlignVertical: TextAlignVertical.top,
                    cursorColor: Palette.black,
                    decoration: InputDecoration(
                      hintText: 'gRPC request',
                      contentPadding: const EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Palette.black, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Palette.black, width: 0.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
