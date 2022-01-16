import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_time/HomePage.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  UserCredential userCredential;
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  Future loginauth() async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wrong password provided for that user.')));
      }
    }
    setState(() {});
  }

  void validation() {
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('name is empty')));
      return;
    }
    if (password.text.trim().isEmpty || password.text.trim() == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('name is empty')));
      return;
    } else {
      setState(() {});
      loginauth();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 180.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Text('Welcome',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.green[900],
                )),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                  icon: Icon(Icons.person_outline),
                  labelText: (' Username'),
                  hintText: 'enter the username'),
            ),
            TextFormField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock_outline),
                  labelText: (' Password'),
                  hintText: 'enter the password'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 130,
                  child: ElevatedButton(
                    onPressed: validation,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
