import 'dart:convert';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgp_project_6/Widgets/RoundButton.dart';

import '../APIs/Doctor/doctorRegisterAPI.dart';
import '../Models/Doctor/doctorRegisterModel.dart';

class DoctorRegister extends StatefulWidget {
  const DoctorRegister({Key? key}) : super(key: key);


  @override
  State<DoctorRegister> createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister> {
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
  String doctor_id = "0";
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
    final Size screenSize = MediaQuery.of(context).size;
    // Get the screen width
    final double screenWidth = screenSize.width;
    // Get the screen height
    final double screenHeight = screenSize.height;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Register Doctor'),
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
                          child: Image.asset(
                              "assets/add.png"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Container(
                      child: Text(
                        "Register Doctor",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(9, 31, 87, 1),
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
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
                          } else if (passNonNullValue.length < 6) {
                            return ("Password Must be more than 5 characters");
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
                          } else if (passNonNullValue.length < 6) {
                            return ("Password Must be more than 5 characters");
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
                        debugPrint(nameController.text);
                        debugPrint(emailController.text);
                        debugPrint(mobileController.text);
                        debugPrint(passwordController.text);
                        debugPrint(_selectedImage.toString());

                        if (passwordController.text !=
                            password2Controller.text) {
                          var snackBar = SnackBar(
                            content: Text("Password doesn't match"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      //   DoctorRegisterModel data = await DoctorRegisterAPI().register(nameController.text, mobileController.text, emailController.text, doctor_id, File(_selectedImage.toString()), );
                      //   if (formKey.currentState!.validate() && data.message != null && data.message == "User created successfully") {
                      //     var snackBar = SnackBar(
                      //       content: Text(data.message!),
                      //     );
                      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(e_emailid: email.text.toString(),)));
                      //   } else {
                      //     var snackBar = SnackBar(
                      //       content: Text(data.message!),
                      //     );
                      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      //   }
                       },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> createDoctor() async {
  //   final String apiUrl = "http://192.168.192.8:3000/doctor";
  //   //final Map<String, String> headers = {"Content-Type": "application/json"};
  //   final Map<String, dynamic> body = {
  //     'fullName': nameController.text,
  //     'mobileNumber': mobileController.text,
  //     'email': emailController.text,
  //     'medicalStudent': 0,
  //     'password':passwordController.text
  //   };
  //
  //   try {
  //     final http.Response response = await http.post(
  //       Uri.parse(apiUrl),
  //       //headers: headers,
  //       body: jsonEncode(body),
  //     );
  //     Map<String,dynamic> data = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200) {
  //       // Request was successful
  //       print("API Response: ${response.body}");
  //     } else {
  //       // Request failed with an error code
  //       print("API Error: ${response.statusCode}");
  //       print("API Response: ${response.body}");
  //     }
  //   } catch (error) {
  //     // Handle any exceptions that occurred during the API call
  //     print("Error: $error");
  //   }
  //
  // }

  Future _pickImageFromGallery() async {
    try {
      final returnedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (returnedImage == null) return;
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}
