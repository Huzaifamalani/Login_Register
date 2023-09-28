import 'dart:math';
import 'package:app/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if(email == "" || password == "" || cPassword == "") {
      log("Please fill all the details!" as num);
    }
    else if(password != cPassword) {
      log("Passwords do not match!" as num);
    }
    else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        if(userCredential.user != null) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch(ex) {
        log(ex.code.toString() as num);
      }
    }
  }

  bool passwordObscured = true;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,title: Text("Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),),
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 10, 45, 161),
      body: Center(
        child:  Column( 
          children: [
            Padding(padding: const EdgeInsets.all(50)),
            const SizedBox(height: 50,),
            const Text("Get Started",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
            const Text("by creating a free account",style: TextStyle(fontSize: 15,color: Colors.white),),
            const SizedBox(height: 15,),
             Container(
              width: 350,
              padding: EdgeInsets.all(12),
              child: Column(
               children: [
                 TextField(keyboardType: TextInputType.emailAddress,controller: emailController,decoration: InputDecoration(filled: true, fillColor: Colors.white,hintText: "Email",prefixIcon: Icon(Icons.person),border:OutlineInputBorder(borderSide:BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(50)),),),),
                 Container(height: 15,),
                 TextField(obscureText: passwordObscured,keyboardType: TextInputType.emailAddress,controller: passwordController,decoration: InputDecoration( filled: true, fillColor: Colors.white,hintText: "Password",prefixIcon: Icon(Icons.password),suffixIcon: IconButton(onPressed: (){setState(() {
              passwordObscured = !passwordObscured;
            });}, icon: Icon(passwordObscured? Icons.visibility_off : Icons.visibility)),border:OutlineInputBorder(borderSide:BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(50)),),)),
            Container(height: 15,),
            TextField(obscureText: passwordObscured,keyboardType: TextInputType.emailAddress,controller: cPasswordController,decoration: InputDecoration( filled: true, fillColor: Colors.white,hintText: "Confrim Password",prefixIcon: Icon(Icons.password),suffixIcon: IconButton(onPressed: (){setState(() {
              passwordObscured = !passwordObscured;
            });}, icon: Icon(passwordObscured? Icons.visibility_off : Icons.visibility)),border:OutlineInputBorder(borderSide:BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(50)),),)),
        ],),
             ),
            const SizedBox(height: 5,),
            SizedBox(width: 330, child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size.square(50),
                              backgroundColor: Colors.black,
                              elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child:const Center(
                              child: Text(
                                "Sign up",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w900),
                              ),
                            ),
                            onPressed: () {
                              createAccount();
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
                                  builder: (BuildContext context) => const Login(),
                                  ),);}, child: Text("Log in",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),))
                          ],
                        ),
            ],
        ),
      ),
    );
  }
}