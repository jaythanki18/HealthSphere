import 'package:flutter/material.dart';
import 'package:sgp_project_6/Pharmacist/addPharmacy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgp_project_6/Posts/PostScreen.dart';
import 'package:sgp_project_6/utils/search.dart';
import 'package:sgp_project_6/utils/showPharmacy.dart';

import '../APIs/Pharmacy/getAllPharmacyAPI.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // debugPrint(widget.token);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),

      ),
      body: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [

                      Colors.grey,
                      Color.fromRGBO(184, 184, 184, 0.4),
                      Colors.white

                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                height: 90,
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Image.asset('assets/addPharmacy.png',height: 50,width: 50,),
                    ),
                    Center(
                      child: Text(
                        "Add Pharmacy",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Color.fromRGBO(9, 31, 87, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        )
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPharmacy()));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [

                      Colors.grey,
                      Color.fromRGBO(184, 184, 184, 0.4),
                      Colors.white

                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                height: 90,
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Image.asset('assets/pills.png',height: 50,width: 50,),
                    ),
                    Center(
                      child: Text(
                          "Show Pharmacy",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(9, 31, 87, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          )
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () async {
                        final api = PharmacyAPI();
                        final pharmacy = await api.fetchPharmacy('', '');
                       print(pharmacy);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowPharmacy()));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [

                      Colors.grey,
                      Color.fromRGBO(184, 184, 184, 0.4),
                      Colors.white

                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                height: 90,
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Image.asset('assets/question.png',height: 50,width: 50,),
                    ),
                    Center(
                      child: Text(
                          "MediQuery",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(9, 31, 87, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          )
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () async {
                     //   Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              IconButton(onPressed: () async {
                final api = PharmacyAPI();
                final pharmacy = await api.fetchPharmacy('', '');
                print(pharmacy);
              }, icon: Icon(Icons.arrow_downward_sharp)),
              // ElevatedButton(onPressed: (){
              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPharmacy()));
              // }, child: Text("Add Pharmacy")),
            ],
          )
      ),
    );
  }
}
