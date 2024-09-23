import 'package:flutter/material.dart';

class Texttosign extends StatefulWidget {
  const Texttosign({super.key});

  @override
  State<Texttosign> createState() => _TexttosignState();
}

class _TexttosignState extends State<Texttosign> {
  String data = "hello";
  final _controller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Text/voice to Sign"),
          backgroundColor: const Color.fromARGB(255, 233, 223, 190),
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: data.length == 1
                      ? Image.asset(
                          "assets/ISL_Gifs/$data.jpg",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Text(
                                "Sry No Image Found....",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            );
                          },
                        )
                      : Image.asset(
                          "assets/ISL_Gifs/$data.gif",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Text(
                                "Sry No Image Found....",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            );
                          },
                        )),
              const SizedBox(
                height: 15,
              ),
              Image.asset("assets/img/voice.png"),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    autofocus: true,
                    controller: _controller,
                    decoration: InputDecoration(
                        hintText: "Enter the text",
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 233, 223, 190),
                                width: 3)),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.black)),
                        prefixIcon: const Icon(Icons.text_fields_outlined),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                data = _controller.text;
                              });
                            },
                            icon: const Icon(Icons.send)))),
              ),
            ],
          ),
        ));
  }
}
