import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signify/router_constants.dart';
import 'package:signify/services/auth_service.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset("assets/img/loginimg.webp"),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.36,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  emailTextField(),
                  const SizedBox(
                    height: 7,
                  ),
                  passwordTextField(),
                  const SizedBox(
                    height: 45,
                  ),
                  custombutton(),
                  const SizedBox(
                    height: 40,
                  ),
                  Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(
                          indent: 30,
                          endIndent: 30,
                        ),
                      ),
                      Positioned(
                        left: 175,
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.asset("assets/img/asian-flower.png")),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 75,
                      ),
                      SizedBox(
                          width: 40,
                          height: 30,
                          child: Image.asset("assets/img/facebook.png")),
                      const SizedBox(
                        width: 50,
                      ),
                      SizedBox(
                          width: 50,
                          height: 40,
                          child: Image.asset("assets/img/google.png")),
                      const SizedBox(
                        width: 50,
                      ),
                      SizedBox(
                          width: 50,
                          height: 40,
                          child: Image.asset("assets/img/twitter.png")),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget emailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            "Email",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                      0.1,
                      0.5,
                      0.7,
                      0.9
                    ],
                    colors: [
                      Color.fromRGBO(228, 247, 211, 1),
                      Color.fromARGB(255, 234, 240, 206),
                      Color.fromARGB(255, 243, 215, 197),
                      Color.fromARGB(255, 219, 228, 243)
                    ]),
              ),
              child: TextField(
                controller: emailController,
                obscureText: true,
                decoration: InputDecoration(
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
            )),
      ],
    );
  }

  Widget passwordTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            "Password",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                      0.1,
                      0.5,
                      0.7,
                      0.9
                    ],
                    colors: [
                      Color.fromRGBO(228, 247, 211, 1),
                      Color.fromARGB(255, 234, 240, 206),
                      Color.fromARGB(255, 243, 215, 197),
                      Color.fromARGB(255, 219, 228, 243)
                    ]),
              ),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
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
            )),
      ],
    );
  }

  Widget custombutton() {
    return InkWell(
      onTap: () async {
        try {
          await AuthService.signInWithEmailAndPassword(
              emailController.text.trim(), passwordController.text.trim());
          context.go(RouterConstants.commonPageRoute);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e.toString(),
              ),
            ),
          );
        }
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 100,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color.fromRGBO(228, 212, 156, 1), Color(0xffad9c00)],
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
            ]

            //     end: Alignment.bottomLeft,
            //     stops: [
            //       0.1,
            //       0.5,
            //       0.7,
            //       0.9
            //     ],
            //     colors: [
            //       Color.fromRGBO(226, 193, 5, 1),
            //       Color.fromARGB(255, 151, 107, 235),
            //       Color.fromARGB(255, 233, 146, 93),
            //       Color.fromARGB(255, 97, 152, 241)
            //     ]),
            ),
        child: const Center(
            child: Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        )),
      ),
    );
  }
}
