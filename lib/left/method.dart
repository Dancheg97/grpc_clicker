import 'package:flutter/material.dart';
import 'package:grpc_rocket/colors.dart';
import 'package:grpc_rocket/grpcurl.dart';

class MethodTab extends StatelessWidget {
  final ProtoMethod method;
  const MethodTab({
    Key? key,
    required this.method,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextButton(
        onPressed: () async {
          
        },
        child: SizedBox(
          width: 225,
          child: Row(
            children: [
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Palette.white,
                size: 12,
              ),
              const SizedBox(width: 6),
              Text(
                method.protoName,
                style: TextStyle(color: Palette.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
