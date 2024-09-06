// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Learningpage extends StatelessWidget {
  const Learningpage({super.key});
  static const List verticallst = [
    ["assets/img/learnimg3.webp", "NUMBERS", "(0-9)"],
    ["assets/img/learnimage2.webp", "ALPHABETS", "(A-Z)"],
    ["assets/img/learnimag1.webp", "WORDS", "eg.Hello, World"],
  ];
  static const List horizontallst = [
    "assets/img/class1.jpeg",
    "assets/img/class2.jpeg",
    "assets/img/class3.jpeg",
    "assets/img/class4.jpeg",
    "assets/img/class5.jpeg",
    "assets/img/class6.jpeg",
    "assets/img/class7.jpeg",
    "assets/img/class8.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        leading: const BackButton(),
        title: const Text("Learning section"),
        actions: const [
          Icon(Icons.add_business),
          SizedBox(
            width: 30,
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 140,
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: horizontallst.length,
                itemBuilder: (context, ind) {
                  return customhorizontalcard(horizontallst[ind], ind);
                }),
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 5),
                shrinkWrap: true,
                itemCount: verticallst.length,
                itemBuilder: (context, ind) {
                  return customverticalcard(verticallst[ind][0],
                      verticallst[ind][1], verticallst[ind][2]);
                }),
          ),
        ],
      ),
    );
  }

  customverticalcard(imgurl, tittle, subtittle) {
    return InkWell(
      onTap: () {},
      child: Center(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    height: 130,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all()),
                    child: Image.asset(imgurl)),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Text(
                  tittle,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 22),
                ),
                Text(subtittle)
              ],
            ),
          ],
        ),
      ),
    );
  }

  customhorizontalcard(imgurl, ind) {
    String level = (ind + 1).toString();
    return InkWell(
      onTap: () {},
      child: Center(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(imgurl)),
              ),
            ),
            Text(
              "CLASS$level",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
