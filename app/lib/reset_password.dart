import 'package:app/login.dart';
import 'package:app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Reset extends StatefulWidget {
  const Reset({super.key});

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  final auth = FirebaseAuth.instance; 
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,title:  Text("Forget Password",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),),
      backgroundColor: const Color.fromARGB(255, 10, 45, 161),
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(50)),
               TextField(controller: emailController,keyboardType: TextInputType.emailAddress,decoration: InputDecoration(filled: true, fillColor: Colors.white,hintText: "Enter Email Id",prefixIcon: Icon(Icons.person),border:OutlineInputBorder(borderSide:BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(50)),),),),
                          const SizedBox(height: 15,),
              SizedBox(width: 350, child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size.square(50),
                                backgroundColor: Colors.black,
                                elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              child: const Text(
                                "forget Password",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w900),
                              ),
                              onPressed: () {
                                auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
                                  Utils().toastMessage("We have sent email to recover password, please check your email");
                                }
                                ).onError((error, stackTrace){
                                  Utils().toastMessage(error.toString());
                                });
                                
                              },
                            ),
                          ),

            ],
          ),
        ),
      ),
    );
  }
}