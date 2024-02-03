import 'package:flutter/material.dart';
import 'package:sgp_project_6/Doctor/doctorLogin.dart';
import 'package:sgp_project_6/Pharmacist/phrmacistLogin.dart';
import 'package:sgp_project_6/User/userLogin.dart';
import 'package:google_fonts/google_fonts.dart';

class AskRole extends StatelessWidget {
  const AskRole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Join with us as a',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(3, 54, 134, 1.0),
                    //fontFamily: 'Raleway',
                  ),
                )
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage('assets/user.png'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "User",
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(3, 54, 134, 1.0),
                            //  fontFamily: 'RobotoMono',
                          ),
                        )
                      ),
                    ],
                  ),
                  onTap: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UserLogin()));
                  }),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        foregroundColor: Colors.white10,
                        backgroundImage: AssetImage('assets/medical.png'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Doctor",
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(3, 54, 134, 1.0),
                            // fontFamily: 'RobotoMono'
                          ),
                        )
                      ),
                    ],
                  ),
                  onTap: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorLogin()));
                  }),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage('assets/pharmacist.png'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Pharmacist",
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(3, 54, 134, 1.0),
                              fontFamily: 'RobotoMono'
                          ),
                        )
                      ),
                    ],
                  ),
                  onTap: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PharmacistLogin()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
