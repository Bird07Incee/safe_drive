import 'package:components/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: BackgroundApp(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Text(
            "Safe Drive",
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2661FA), fontSize: 36),
          ),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: const TextField(
            decoration: InputDecoration(label: Text('Username')),
          ),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: const TextField(
            decoration: InputDecoration(label: Text('Password')),
            obscureText: true,
          ),
        ),
        Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Forgot Your Password?',
                style: TextStyle(fontSize: 12, color: Color(0xFF2661FA)),
              ),
            )),
        SizedBox(
          height: size.height * 0.03,
        ),
        Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(80))),
                    textStyle: const MaterialStatePropertyAll(TextStyle(color: Colors.white))),
                child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    padding: const EdgeInsets.all(0),
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        gradient: const LinearGradient(colors: [Color.fromARGB(255, 255, 136, 31), Color.fromARGB(255, 255, 177, 41)])),
                    child: const Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    )))),
        Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Don't Have an Account? Sign Up",
                style: TextStyle(fontSize: 12, color: Color(0xFF2661FA), fontWeight: FontWeight.bold),
              ),
            )),
      ],
    ))));
  }
}
