import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class Writtingpard extends StatelessWidget {
  const Writtingpard({super.key});

  @override
  Widget build(BuildContext context) {
    final SignatureController _controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.red,
      exportBackgroundColor: Colors.blue,
    );

    return Scaffold(
        body: Column(
      children: [
        Container(
          child: Signature(
            controller: _controller,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 170,
            backgroundColor: Colors.blue.shade100,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            _controller.clear();
          },
          child: const Text(
            "Clear",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    ));
  }
}
