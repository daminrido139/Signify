import 'package:flutter/material.dart';
import 'package:signify/Student/pages/individualchatpage.dart';

class Chatpage extends StatelessWidget {
  const Chatpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leadingWidth: 35,
        backgroundColor: const Color.fromARGB(255, 233, 223, 190),
        title: const Text(
          "Communities",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Icon(Icons.more_vert_outlined),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          customTextfield("Search"),
          customlist("Kabilan", "hello", "assets/img/kabi.jpeg", context),
          customlist("Damin Rido", "hi", "assets/img/rido.jpeg", context),
          customlist(
              "Damin Risho", "Good morning", "assets/img/risho.jpeg", context),
          customlist("Swathi", "ok", "assets/img/swa.jpeg", context),
          customlist("Anushiya", "bye bye", "assets/img/anu.jpeg", context),
          customlist("Praveena", "how are you", "assets/img/pra.jpeg", context),
          customlist("Priya", "hi praveena", "assets/img/priya.jpeg", context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 233, 223, 190),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget customTextfield(String subtittle) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 50,
          ),
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: subtittle,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.black),
              ),
            ),
          ),
        ));
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
}
