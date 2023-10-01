import 'dart:developer';

import 'package:app/home.dart';
import 'package:app/register.dart';
import 'package:app/reset_password.dart';
import 'package:app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _fornkey = GlobalKey<FormState>();
  String user ="",email = "",password = "";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordObscured = true;
    void SigninAccount() async {
    if (password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
          "Sigin Sucessfully",style: TextStyle(fontSize: 20),
        ),
        ),
        );
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));
        }
        on FirebaseAuthException catch (e) {
          if (e.code =="User not found") {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text("No user found for that Email",style: TextStyle(fontSize: 20),),
            ),
            );
          }
          else if (e.code =="Wrong Password") {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text("Wrong password provided by user",style: TextStyle(fontSize: 20),),
            ));
          }
        }
        }
        }

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
              child: Form(
                key: _fornkey,
                child: Column(
                 children: [
                   TextFormField(
                    validator:(value) {
                    if (value == null || value.isEmpty) {
                      return "PLease Enter Email";
                    }
                    return null;},keyboardType: TextInputType.emailAddress,controller: emailController,decoration: InputDecoration(filled: true, fillColor: Colors.white,hintText: "Enter your email",prefixIcon: Icon(Icons.email),border:OutlineInputBorder(borderSide:BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(50)),),),
                    ),
                              Container(height: 15,),
                                    TextFormField(
                                      validator:(value) {
                    if (value == null || value.isEmpty) {
                      return "PLease Enter password";
                    }
                    return null;},
                                      obscureText: passwordObscured,keyboardType: TextInputType.emailAddress,controller: passwordController,decoration: InputDecoration( filled: true, fillColor: Colors.white,hintText: "Password",prefixIcon: Icon(Icons.password),suffixIcon: IconButton(onPressed: (){setState(() {
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
                                onPressed: () async{
                                if (_fornkey.currentState!.validate()) {
                                  setState(() {
                                  email = emailController.text;
                                  password = passwordController.text;
                                  SigninAccount();
                                  }
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("New user?",style: TextStyle(color: Colors.black,fontSize: 14),),
                              TextButton(onPressed: (){Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => const Register(),
                                    ),);}, child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),))
                            ],
                          ),
               
                          
              ],),
              ),
             ),
            ],
        ),
      ),
    );
  }
}