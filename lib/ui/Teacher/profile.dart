// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class ProfilePageTeacher extends StatelessWidget {
  const ProfilePageTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            customcontainer(context), // const Center(
            //   child: CircleAvatar(
            //     radius: 60,
            //     backgroundImage: AssetImage(
            //       "assets/img/profileimage.jpg",
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.blue.shade100),
            //     onPressed: () {},
            //     child: const Text(
            //       "Edit Profile",
            //       style: TextStyle(color: Colors.black),
            //     )),
            const SizedBox(
              height: 10,
            ),
            customlisttile(
                "Profile",
                const Icon(
                  Icons.person,
                  size: 30,
                )),
            customlisttile(
                "Settings",
                const Icon(
                  Icons.settings,
                  size: 30,
                )),
            customlisttile(
                "Terms and conditions",
                const Icon(
                  Icons.safety_check,
                  size: 30,
                )),
            customlisttile(
                "Privacys and Policis",
                const Icon(
                  Icons.privacy_tip,
                  size: 30,
                )),
            const SizedBox(
              height: 30,
            ),
            customlogout(context)
          ],
        ),
      ),
    );
  }

  Widget customlisttile(titlename, icon) {
    return ListTile(
      minTileHeight: 80,
      onTap: () {},
      leading: icon,
      title: Text(titlename),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }

  Widget customlogout(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color.fromRGBO(228, 212, 156, 1), Color(0xffad9c00)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
            child: Text(
          "Logout",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }

  Widget customcontainer(BuildContext context) {
    return Container(
      height: 240,
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(228, 212, 156, 1),
              Color.fromARGB(255, 233, 223, 190)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 253, 249, 227),
          boxShadow: [
            BoxShadow(
                color:
                    const Color.fromARGB(255, 241, 228, 190).withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                    "assets/img/teacher.jpeg",
                  ),
                ),
              ),
              const Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Anisha S",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      "K.L.Institute For The Deaf",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 290),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xffad9c00)),
                      minimumSize: const Size(150, 40),
                      // foregroundColor: Colors.green
                      backgroundColor: const Color.fromARGB(255, 236, 234, 234),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Share Profile",
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              const SizedBox(
                width: 10,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 290),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xffad9c00)),
                      minimumSize: const Size(150, 40),
                      // foregroundColor: Colors.green
                      backgroundColor: Colors.blue[100],
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.black),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
