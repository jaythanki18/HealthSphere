import 'dart:convert';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:sgp_project_6/Pharmacist/pharmacistRegister.dart';
import '../APIs/Pharmacist/pharmacistLoginAPI.dart';
import '../Models/Pharmacist/pharmacistLoginModel.dart';
import '../Widgets/RoundButton.dart';
import '../utils/dashboard.dart';

class PharmacistLogin extends StatefulWidget {
  const PharmacistLogin({Key? key}) : super(key: key);

  @override
  State<PharmacistLogin> createState() => _PharmacistLoginState();
}

class _PharmacistLoginState extends State<PharmacistLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obsecure = true;
  final formKey = GlobalKey<FormState>();
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;
    // Get the screen width
    final double screenWidth = screenSize.width;
    // Get the screen height
    final double screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: screenHeight * 0.5,
                    width: screenWidth * 0.9,
                    child: Image.asset("assets/login.jpg"),
                  ),
                  Text(
                    "Welcome",
                    style: GoogleFonts.raleway(
                      //merriweather
                      textStyle: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(62, 86, 115, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                                .hasMatch(value)) {
                          return 'Enter a valid email';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        labelText: "Email",
                        labelStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color.fromRGBO(62, 86, 115, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: obsecure,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid password';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        labelText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obsecure = !obsecure;
                            });
                          },
                          icon: Icon(Icons.visibility),
                        ),
                        labelStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color.fromRGBO(62, 86, 115, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RoundButton(
                    title: "Pharmacist Login",
                    onTap: () async {
                     PharmacistLoginModel data = await PharmacistLoginAPI().pharmacistLogin(emailController.text, passwordController.text,"pharmacist");
                      if (formKey.currentState!.validate() && data.token!=null) {
                        debugPrint(data.token);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));
                      }
                   //   Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));
                      // Add login logic here
                    },
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword(op: pword.text.toString(),)));
                          },
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(color: Colors.grey[400],fontSize: 12,fontWeight: FontWeight.bold),
                          ))),
                  Container(
                    width: 500,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PharmacistRegister()));
                        },
                        child: Text(
                            "Don't have an account? Sign Up",
                            style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.teal,fontSize: 18),)
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              width: 1.0,
                              color: Colors.teal,
                            )
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
