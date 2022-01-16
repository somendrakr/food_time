import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signuppage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  _SignuppageState createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  bool loading = false;
  UserCredential userCredential;
  RegExp regExp = RegExp(Signuppage.pattern);
  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  //GlobalKey<ScaffoldMessengerState> globalKey =
  //GlobalKey<ScaffoldMessengerState>();

  Future sendData() async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      await FirebaseFirestore.instance
          .collection('userData')
          .doc(userCredential.user.uid)
          .set({
        'name': name.text.trim(),
        'lastname': lastname.text.trim(),
        'email': email.text.trim(),
        'password': password.text.trim(),
        'userid': userCredential.user.uid
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      loading = false;
    });
  }

  void validation() {
    if (name.text.trim().isEmpty || name.text.trim() == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('name is empty')));
      return;
    }
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('name is empty')));
      return;
    }
    if (password.text.trim().isEmpty || password.text.trim() == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('name is empty')));
      return;
    }
    if (lastname.text.trim().isEmpty || lastname.text.trim() == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('name is empty')));
      return;
    } else {
      setState(() {
        loading = true;
      });
      sendData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: globalKey,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 150.0, left: 10, right: 10),
          child: Column(
            children: [
              Container(
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'enter the name',
                ),
              ),
              TextFormField(
                controller: lastname,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  hintText: 'enter the Last Name',
                ),
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  labelText: 'Email Id',
                  hintText: 'enter the Email Id',
                ),
              ),
              TextFormField(
                controller: password,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'enter the Password',
                ),
              ),
              loading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          Container(
                            child: ElevatedButton(
                                onPressed: validation,
                                child: Text('cancel'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              child: ElevatedButton(
                                onPressed: validation,
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
