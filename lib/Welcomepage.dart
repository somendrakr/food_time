import 'package:flutter/material.dart';
import 'package:food_time/Loginpage.dart';
import 'package:food_time/Signuppage.dart';

class Welcomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          width: MediaQuery.of(context).size.height * 1,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Container(
                  child: Text('Welcome',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.green[900],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Container(
                  width: 300,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Loginpage()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 300,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Signuppage()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ),
            ],
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'images/welcome.jpg',
                  ),
                  fit: BoxFit.fill)),
        ),
      ]),
    );
  }
}
