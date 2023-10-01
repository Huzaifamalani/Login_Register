import 'dart:math';
import 'package:app/home.dart';
import 'package:app/login.dart';
import 'package:app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _fornkey = GlobalKey<FormState>();
  String user ="",email = "",password = "";
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void createAccount() async {
    if (password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
          "Sigup Sucessfully",style: TextStyle(fontSize: 20),
        ),
        ),
        );
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));
        }
        on FirebaseAuthException catch (e) {
          if (e.code =="week password") {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text("Password Provided is too week",style: TextStyle(fontSize: 20),),
            ),
            );
          }
          else if (e.code =="email-already-in-use") {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text("Account already exists",style: TextStyle(fontSize: 20),),
            ));
          }
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
      body: Form(
        key: _fornkey,
        child: Column( 
          children: [
            Padding(padding: const EdgeInsets.all(50)),
            const SizedBox(height: 50,),
            const Text("Get Started",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
            const Text("by creating a free account",style: TextStyle(fontSize: 15,color: Colors.white),),
            const SizedBox(height: 15,),
             Container(
              width: 350,
              padding: EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                 children: [
                  TextFormField(
                    validator:(value) {
                    if (value == null || value.isEmpty) {
                      return "PLease Enter User Name";
                    }
                    return null;
                  },keyboardType: TextInputType.emailAddress,controller: userController,decoration: InputDecoration(filled: true, fillColor: Colors.white,hintText: "User",prefixIcon: Icon(Icons.person),border:OutlineInputBorder(borderSide:BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(50)),),),),
                   Container(height: 15,),
                   TextFormField(
                    validator:(value) {
                    if (value == null || value.isEmpty) {
                      return "PLease Enter User Name";
                    }
                    return null;},
                    keyboardType: TextInputType.emailAddress,controller: emailController,decoration: InputDecoration(filled: true, fillColor: Colors.white,hintText: "Email",prefixIcon: Icon(Icons.email),border:OutlineInputBorder(borderSide:BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(50)),),),),
                   Container(height: 15,),
                   TextFormField(
                    validator:(value) {
                    if (value == null || value.isEmpty) {
                      return "PLease Enter Password";
                    }
                    return null;
                    },
                    obscureText: passwordObscured,keyboardType: TextInputType.emailAddress,controller: passwordController,decoration: InputDecoration( filled: true, fillColor: Colors.white,hintText: "Password",prefixIcon: Icon(Icons.password),suffixIcon: IconButton(onPressed: (){setState(() {
                passwordObscured = !passwordObscured;
                         });}, icon: Icon(passwordObscured? Icons.visibility_off : Icons.visibility)),border:OutlineInputBorder(borderSide:BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(50)),),)),
                     ],),
              ),
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
                            onPressed: () async{
                              if (_fornkey.currentState!.validate()) {
                                setState(() {
                                email = emailController.text;
                                user = userController.text;
                                password = passwordController.text;
                                createAccount();
                                });
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
                            Text("Already have an account?",style: TextStyle(color: Colors.black,fontSize: 14),),
                            TextButton(onPressed: (){Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => const Login(),
                                  ),);}, child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),))
                          ],
                        ),
            ],
        ),
      ),
    );
  }
}