import 'package:flutter/material.dart';

class Individualchatpage extends StatelessWidget {
  const Individualchatpage({super.key, required this.name, required this.img});
  final String name;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 233, 223, 190),
          leadingWidth: 25,
          title: Row(
            children: [
              CircleAvatar(backgroundImage: AssetImage(img)),
              const SizedBox(
                width: 25,
              ),
              Text(name),
            ],
          ),
          actions: [
            SizedBox(
                height: 30,
                width: 30,
                child: Image.asset("assets/img/video.png")),
            const SizedBox(
              width: 25,
            )
          ],
        ),
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width - 5,
              child: Image.asset(
                "assets/img/chatbackground.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.send_outlined),
                      hintText: "Message here...",
                      enabledBorder: OutlineInputBorder(),
                      border: OutlineInputBorder()),
                ),
              ),
            )
          ],
        ));
  }
}
