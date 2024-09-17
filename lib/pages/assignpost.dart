import 'package:flutter/material.dart';

class Assignpost extends StatefulWidget {
  const Assignpost({super.key});

  @override
  State<Assignpost> createState() => _AssignpostState();
}

class _AssignpostState extends State<Assignpost> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.red),
              child: TabBar(
                indicator: BoxDecoration(
                  color: Colors.red[800],
                  borderRadius: BorderRadius.circular(20),
                ),
                labelColor: Colors.black,
                dividerColor: Colors.black,
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  Tab(
                    text: "Forthcoming",
                  ),
                  Tab(
                    text: "Forthcoming",
                  ),
                  Tab(
                    text: "Forthcoming",
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                Text("data"),
                Text("data"),
                Text("data"),
                // MyPostTab(),
                // MyReelsTab(),
                // MyTagTab(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
