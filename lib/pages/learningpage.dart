import 'package:flutter/material.dart';

class Learningpage extends StatelessWidget {
  const Learningpage({super.key});
  static const List verticallst = [
    "assets/img/learnimg3.webp",
    "assets/img/learnimage2.webp",
    "assets/img/learnimag1.webp"
  ];
  static const List horizontallst = [
    "assets/img/class1.webp",
    "assets/img/learnimg3.webp",
    "assets/img/learnimage2.webp",
    "assets/img/learnimag1.webp",
    "assets/img/learnimg3.webp",
    "assets/img/learnimage2.webp",
    "assets/img/learnimag1.webp"
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
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: horizontallst.length,
                itemBuilder: (context, ind) {
                  return customhorizontalcard(horizontallst[ind]);
                }),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: verticallst.length,
                itemBuilder: (context, ind) {
                  return customverticalcard(verticallst[ind]);
                }),
          ),
        ],
      ),
    );
  }

  customverticalcard(imgurl) {
    return Center(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all()),
                child: Image.asset(imgurl)),
          ),
          const Text("data")
        ],
      ),
    );
  }

  customhorizontalcard(imgurl) {
    return Center(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(imgurl)),
            ),
          ),
          const Text("data")
        ],
      ),
    );
  }
}
