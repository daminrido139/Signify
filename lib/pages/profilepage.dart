import 'package:flutter/material.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                  "assets/img/profileimage.jpg",
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade100),
                onPressed: () {},
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(color: Colors.black),
                )),
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
              height: 70,
            ),
            customlogout()
          ],
        ),
      ),
    );
  }

  Widget customlisttile(titlename, icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ListTile(
        leading: icon,
        title: Text(titlename),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget customlogout() {
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
          child: Text(
        "Logout",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      )),
    );
  }
}
