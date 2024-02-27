import 'dart:convert';
import 'dart:io';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgp_project_6/APIs/Pharmacy/createPharmacyAPI.dart';
import 'package:sgp_project_6/Models/Pharmacy/createPharmacyModel.dart';
import '../Widgets/RoundButton.dart';
import '../utils/dashboard.dart';

class AddPharmacy extends StatefulWidget {
  const AddPharmacy({Key? key}) : super(key: key);

  @override
  State<AddPharmacy> createState() => _AddPharmacyState();
}

class _AddPharmacyState extends State<AddPharmacy> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController pharmacy_no = TextEditingController();
  TextEditingController pharmacist_id = TextEditingController();
  TextEditingController country=TextEditingController();
  TextEditingController state=TextEditingController();
  TextEditingController city=TextEditingController();
  TextEditingController address=TextEditingController();
  String email = "";
  String phone = "";
  String password = "";
  String name = "";
  String photo = "";
  String addressStr="";
  int medicalStudent = 0;
  String pharmacy_num="";
  int pharmacistid=0;
  bool obsecure1 = true;
  bool obsecure2 = true;
  final formKey = GlobalKey<FormState>();
  File? _selectedImage;
  File? _selectedPdf;

  late String countryValue;
  late String stateValue;
  late String cityValue;

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
      //   title: Text('Register Pharmacist'),
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
                        "Add Pharmacy",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(9, 31, 87, 1),
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _selectedPdf != null
                            ? ElevatedButton.icon(
                          onPressed: _pickPdf,
                          icon: Icon(Icons.picture_as_pdf,
                              size: 35.0, color: Colors.red),
                          label: SizedBox(
                            width: 200,
                            height: 50,
                            child: Center(
                              child: Text(
                                _selectedPdf!.path
                                    .split('/')
                                    .last, // Show only filename
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                        )
                            : ElevatedButton.icon(
                          onPressed: _pickPdf,
                          icon: Icon(
                            Icons.picture_as_pdf,
                            size: 35.0,
                            color: Colors.red,
                          ),
                          label: SizedBox(
                              width: 200,
                              height: 50,
                              child: Center(
                                  child: Text(
                                    'Attach Pharmacy certificate',
                                    style: TextStyle(color: Colors.black),
                                  ))),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                        ),
                        SizedBox(height: 20.0),
                      ],
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
                          pharmacy_num = value;
                          setState(() {});
                        },
                        controller: pharmacy_no,
                        keyboardType: TextInputType.text,
                        validator: (value) {},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                          labelText: "Pharmacy Number",
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
                      pharmacistid = value as int;
                      setState(() {});
                    },
                    controller: pharmacist_id,
                    keyboardType: TextInputType.text,
                    validator: (value) {},
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      labelText: "Pharmacist Id",
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
                      child:  CountryStateCityPicker(
                          country: country,
                          state: state,
                          city: city,
                          dialogColor: Colors.grey[200],
                          textFieldDecoration: InputDecoration(
                            hintStyle: TextStyle(color: Color.fromRGBO(62, 86, 115, 1),fontWeight: FontWeight.bold),
                              focusColor: Color.fromRGBO(62, 86, 115, 1),
                              fillColor: Colors.grey[200],
                              filled: true,
                              suffixIcon: const Icon(Icons.arrow_downward_rounded,color: Color.fromRGBO(62, 86, 115, 1)),
                              border: const OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(10))))
                      ),
                    ),
                    SizedBox(height: 10,),
                Container(
                  child: TextFormField(
                    onChanged: (value) {
                      addressStr = value;
                      setState(() {});
                    },
                    controller: address,
                    keyboardType: TextInputType.text,
                    validator: (value) {},
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      labelText: "Address",
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
                    SizedBox(height: 10,),
                    RoundButton(
                      title: "Create Pharmacy",
                      onTap: () async {
                        CreatePharmacyModel data = await CreatePharmacyAPI().create(nameController.text, mobileController.text, emailController.text, pharmacy_no.text.toString(),pharmacist_id.text, address.text,city.text,state.text,File(_selectedImage.toString()), File(_selectedPdf.toString()));
                        if (formKey.currentState!.validate() && data.message != null && data.message == "Pharmacy created successfully") {
                          var snackBar = SnackBar(
                            content: Text(data.message!),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));
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
        ),
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
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future _pickPdf() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) {
        return;
      }
      setState(() {
        _selectedPdf = File(result.files.single.path!);
      });
    } catch (e) {
      print("Error in pick pdf: $e");
    }
  }

  String getFormattedFilePath(String filePath) {
    final filename =
        filePath.split('/').last; // Handle Windows paths more robustly
    return '$filename';
  }
}
