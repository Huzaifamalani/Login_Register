import 'dart:developer';

import 'package:app/home.dart';
import 'package:app/register.dart';
import 'package:app/reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordObscured = true;
void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(email == "" || password == "") {
      log("Please fill all the fields!");
    }
    else {

      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        if(userCredential.user != null) {
            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Home()),
  );

        }
      } on FirebaseAuthException catch(ex) {
        log(ex.code.toString());
      }
    }
    emailController.clear();
    passwordController.clear();
  }  // bool emailvalid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/?=^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
  @override
  
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 10, 45, 161),
      body: Center(
        child:  Column( 
          children: [
            Padding(padding: const EdgeInsets.all(20)),
            const Image(width:250,height: 250, image: AssetImage(
              "assets/images/login.png",
              ),
              ),
            const Text("Welcome back",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
            const Text("sign in to access your account",style: TextStyle(fontSize: 15,color: Colors.white),),
            const SizedBox(height: 15,),
             Container(
              width: 350,
              padding: EdgeInsets.all(12),
              child: Column(
               children: [
                 TextField(keyboardType: TextInputType.emailAddress,controller: emailController,decoration: InputDecoration(filled: true, fillColor: Colors.white,hintText: "Enter your email",prefixIcon: Icon(Icons.email),border:OutlineInputBorder(borderSide:BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(50)),),),),
                            Container(height: 15,),
                                  TextField(obscureText: passwordObscured,keyboardType: TextInputType.emailAddress,controller: passwordController,decoration: InputDecoration( filled: true, fillColor: Colors.white,hintText: "Password",prefixIcon: Icon(Icons.password),suffixIcon: IconButton(onPressed: (){setState(() {
              passwordObscured = !passwordObscured;
            });}, icon: Icon(passwordObscured? Icons.visibility_off : Icons.visibility)),border:OutlineInputBorder(borderSide:BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(50)),),)),
                        Container(
              width: MediaQuery.of(context).size.width,
              height: 35,
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => const Reset(),
                                  ),);
                }, child: const Text(
                  "forget password",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.right,
                  ),
                ),
            ),
            SizedBox(width: 350, child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size.square(50),
                              backgroundColor: Colors.black,
                              elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: const Text(
                              "Sign in",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w900),
                            ),
                            onPressed: () {
                              login();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?",style: TextStyle(color: Colors.black,fontSize: 14),),
                            TextButton(onPressed: (){Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => const Register(),
                                  ),);}, child: Text("Register now",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),))
                          ],
                        ),
 
            
],),
             ),
            ],
        ),
      ),
    );
  }
}