import 'package:flutter/material.dart';
import 'package:signify/ui/Student/individualchatpage.dart';
import 'package:signify/entry.dart';

class HomepageTeacher extends StatelessWidget {
  const HomepageTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 60,
        leading: const Row(
          children: [
            SizedBox(
              width: 20,
            ),
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/img/teacher.jpeg"),
            ),
          ],
        ),
        title: const GradientText(
          'Leviosa',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          gradient: LinearGradient(
              colors: [Color.fromRGBO(228, 212, 156, 1), Color(0xffad9c00)]),
        ),
      ),
      body: Column(
        children: [
          customsearch(),
          customlist("Kabilan", "hello", "assets/img/kabi.jpeg", context),
          customlist("Damin Rido", "hi", "assets/img/rido.jpeg", context),
          customlist(
              "Damin Risho", "Good morning", "assets/img/risho.jpeg", context),
          customlist("Swathi", "ok", "assets/img/swa.jpeg", context),
          customlist("Anisha", "bye bye", "assets/img/anu.jpeg", context),
          customlist("Praveena", "how are you", "assets/img/pra.jpeg", context),
          customlist("Priya", "hi praveena", "assets/img/priya.jpeg", context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 243, 227, 173),
        child: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
      ),
    );
  }

  Widget customsearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              prefixIcon: Icon(Icons.search),
              hintText: "Search")),
    );
  }
}

Widget customlist(txt, subtxt, img, BuildContext context) {
  return ListTile(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Individualchatpage(
                    name: txt,
                    img: img,
                  )));
    },
    leading: CircleAvatar(
      radius: 30,
      backgroundImage: AssetImage(img),
    ),
    title: Text(
      txt,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      subtxt,
      style: const TextStyle(color: Colors.grey),
    ),
    trailing: const Text("2.00 pm"),
  );
}
