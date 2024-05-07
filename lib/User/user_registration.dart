import 'dart:convert';
import 'dart:io';
import 'package:sgp_project_6/Models/User/userRegisterModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgp_project_6/User/userLogin.dart';
import 'package:sgp_project_6/utils/dashboard.dart';
import '../APIs/User/userRegisterAPI.dart';
import '../Widgets/RoundButton.dart';
import 'package:http/http.dart' as http;

class UserRegister extends StatefulWidget {
  const UserRegister({Key? key}) : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  String email = "";
  String phone = "";
  String password = "";
  String name = "";
  String photo = "";
  int medicalStudent = 0;
  bool obsecure1 = true;
  bool obsecure2 = true;
  final formKey = GlobalKey<FormState>();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    // Get the screen width
    final double screenWidth = screenSize.width;
    // Get the screen height
    final double screenHeight = screenSize.height;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Register User'),
      //   backgroundColor: Color.fromRGBO(3, 54, 134, 1.0),
      // ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: Container(
                        height: screenHeight * 0.25,
                        width: screenWidth * 0.4,
                        decoration: BoxDecoration(color: Colors.white),
                        child: _selectedImage != null
                            ? Image.file(
                          _selectedImage!,
                          fit: BoxFit.fitHeight,

                        )
                            : Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Image.asset("assets/add.png"),
                        ),
                      ),

                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Container(
                      child: Text(
                        "Register User",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(9, 31, 87, 1),
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      //width: 77.94.w,
                      // height: 5.92.h,
                      child: TextFormField(
                        onChanged: (value) {
                          name = value;
                          setState(() {});
                        },
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                          labelText: "Full name",
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
                      //width: 77.94.w,
                      // height: 5.92.h,
                      child: TextFormField(
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                  .hasMatch(value!)) {
                            return 'Enter correct email';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                          labelText: "Email Id",
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
                      //width: 77.94.w,
                      // height: 5.92.h,
                      child: TextFormField(
                        onChanged: (value) {
                          phone = value;
                          setState(() {});
                        },
                        controller: mobileController,
                        keyboardType: TextInputType.number,
                        validator: (value) {},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                          labelText: "Mobile number",
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
                      // width: 77.94.w,
                      // height: 5.92.h,
                      child: TextFormField(
                        onChanged: (value) {
                          password = value;
                          setState(() {});
                        },
                        controller: passwordController,
                        obscureText: obsecure1,
                        keyboardType: TextInputType.text,
                        validator: (PassCurrentValue) {
                          var passNonNullValue = PassCurrentValue ?? "";
                          if (passNonNullValue.isEmpty) {
                            return ("Password is required");
                          }
                          return null;
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
                                Icon(Icons.visibility);
                                obsecure1 == true
                                    ? obsecure1 = false
                                    : obsecure1 = true;
                              });
                            },
                            icon: Icon(Icons.visibility_off),
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
                    Container(
                      // width: 77.94.w,
                      // height: 5.92.h,
                      child: TextFormField(
                        onChanged: (value) {
                          password = value;
                          setState(() {});
                        },
                        controller: password2Controller,
                        obscureText: obsecure2,
                        keyboardType: TextInputType.text,
                        validator: (PassCurrentValue) {
                          var passNonNullValue = PassCurrentValue ?? "";
                          if (passNonNullValue.isEmpty) {
                            return ("Password is required");
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                          labelText: "Confirm Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                Icon(Icons.visibility);
                                obsecure2 == true
                                    ? obsecure2 = false
                                    : obsecure2 = true;
                              });
                            },
                            icon: Icon(Icons.visibility_off),
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
                      title: "Register",
                      onTap: () async {
                        if (passwordController.text != password2Controller.text) {
                          var snackBar = SnackBar(
                            content: Text("Password doesn't matches"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }

                        UserRegisterModel data = await UserRegisterAPI().register(nameController.text, mobileController.text, emailController.text, "0", passwordController.text,_selectedImage!);
                        if (formKey.currentState!.validate() && data.message!=null && data.message == "User registered successfully") {
                          var snackBar = SnackBar(
                            content: Text(data.message!),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                         //  Navigator.push(context, MaterialPageRoute(builder: (context)=>UserLogin()));
                        } else {
                          var snackBar = SnackBar(
                            content: Text(data.message!),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                       },
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }

  Future _pickImageFromGallery() async {
  try {
    final returnedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
      debugPrint("user_photo: "+_selectedImage.toString());
    });
  } catch (e) {
    print('Error picking image: $e');
  }
}
}
