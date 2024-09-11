// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Learningpage extends StatelessWidget {
  const Learningpage({super.key});
  static const List verticallst = [
    ["assets/img/learnimg3.webp", "NUMBERS", "(0-9)"],
    ["assets/img/learnimage2.webp", "ALPHABETS", "(A-Z)"],
    ["assets/img/learnimag1.webp", "WORDS", "(eg.World)"],
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
        elevation: 0,
        toolbarHeight: 50,
        leadingWidth: 30,
        scrolledUnderElevation: 0,
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        title: const Text(
          "Learning section",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15),
        itemCount: horizontallst.length,
        itemBuilder: (context, ind) {
          return customhorizontalcard(horizontallst[ind], ind);
        },
      ),
    );
  }

  //  ListView.builder(
  //               padding: const EdgeInsets.symmetric(vertical: 5),
  //               shrinkWrap: true,
  //               itemCount: verticallst.length,
  //               itemBuilder: (context, ind) {
  //                 return customverticalcard(verticallst[ind][0],
  //                     verticallst[ind][1], verticallst[ind][2]);
  //               }),
  // SizedBox(
  //   height: 140,
  //   child: ListView.builder(
  //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  //       shrinkWrap: true,
  //       scrollDirection: Axis.vertical,
  //       itemCount: horizontallst.length,
  //       itemBuilder: (context, ind) {
  //         return customhorizontalcard(horizontallst[ind], ind);
  //       }),
  // ),
  customverticalcard(imgurl, tittle, subtittle) {
    return InkWell(
      onTap: () {},
      child: Center(
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade100,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          height: 100,
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
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }

  customhorizontalcard(imgurl, ind) {
    String level = (ind + 1).toString();
    return InkWell(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            decoration: ShapeDecoration(
                color: const Color.fromARGB(255, 33, 39, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(imgurl),
            ),
          ),
          Center(
            child: Text(
              "CLASS $level",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 28,
                color: Color.fromRGBO(245, 245, 245, 1),
              ),
            ),
          )
        ],
      ),
    );
  }
}
