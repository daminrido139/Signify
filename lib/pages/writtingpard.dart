import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class Writtingpard extends StatelessWidget {
  const Writtingpard({super.key});

  @override
  Widget build(BuildContext context) {
    final SignatureController controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.red,
      exportBackgroundColor: Colors.blue,
    );

    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Signature(
            controller: controller,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 270,
            backgroundColor: const Color.fromARGB(255, 233, 223, 190),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            controller.clear();
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
