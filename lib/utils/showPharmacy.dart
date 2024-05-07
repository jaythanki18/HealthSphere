import 'package:flutter/material.dart';

import '../APIs/Pharmacy/getAllPharmacyAPI.dart';
import '../Models/Pharmacy/getAllPharmacyModel.dart';

class ShowPharmacy extends StatefulWidget {
  const ShowPharmacy({Key? key}) : super(key: key);

  @override
  State<ShowPharmacy> createState() => _ShowPharmacyState();
}

class _ShowPharmacyState extends State<ShowPharmacy> {
  TextEditingController _searchController = TextEditingController();
  List<GetAllPharmacyModel> _pharmacies = [];
  bool _isSearching = false;
  bool _showSearchImage = true;
  bool _searched = false;


  Future<List<GetAllPharmacyModel>> searchAPI() async {
    String searchQuery = _searchController.text;
    String selectedState = 'gujarat';

    List<GetAllPharmacyModel> pharmacies = await PharmacyAPI().fetchPharmacy(searchQuery, selectedState);

    return pharmacies;
  }

  @override
  void initState() {
    super.initState();
    // _pharmacies.addAll();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.teal,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search City Name',
                        ),
                        onChanged: (value) {},
                        onSubmitted: (value) {
                          searchAPI().then((newPharmacies) {
                            setState(() {
                              _pharmacies = newPharmacies;
                            });
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        searchAPI().then((newPharmacies) {
                          setState(() {
                            _pharmacies = newPharmacies;
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: FutureBuilder(
                    future: searchAPI(),
                    builder: (BuildContext context,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }
                      else if(snapshot.hasData){
                        print(snapshot.data);
                        return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              final pharmacy = snapshot.data![index];
                              return Column(
                                children: [
                                //  SizedBox(height: 10,),
                                  Card(
                                    elevation: 4.0,
                                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                    color: Colors.teal.shade50,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(12.0),
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10,right: 10),
                                          child: Image.network(
                                            snapshot.data![0].pharmacyPhoto.toString() ?? '', // Provide a default value here
                                            width: 80.0,
                                            height: 80.0,
                                              errorBuilder: (context, error, stackTrace) => Image.asset('assets/medicine.png')
                                          //  fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        pharmacy.fullName ?? '', // Provide a default value here
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            pharmacy.mobileNumber ?? '', // Provide a default value here
                                            style: TextStyle(color: Colors.grey[600],fontSize: 16,fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            pharmacy.address ?? '', // Provide a default value here
                                            style: TextStyle(color: Colors.grey[600],fontSize: 14,fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 2.0),
                                          Text(
                                            pharmacy.city ?? '', // Provide a default value here
                                            style: TextStyle(color: Colors.grey[600],fontSize: 14,fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 2.0),
                                        ],
                                      ),
                                      onTap: () {
                                        // Navigator.pushNamed(context, '/pharmacy_info', arguments: pharmacy);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }
                        );
                      }
                      else return Text('No data');
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildSearchResults() {
  //   if (_isSearching) {
  //     return CircularProgressIndicator();
  //   } else if (_searched && _pharmacies.isEmpty) {
  //     return Text(
  //       'No results found.',
  //       style: TextStyle(fontSize: 18.0),
  //     );
  //   } else {
  //     return FutureBuilder(
  //         future: PharmacyAPI().fetchPharmacy(_searchController.text, 'gujarat'),
  //         builder: (BuildContext context,snapshot){
  //           if(snapshot.connectionState==ConnectionState.waiting){
  //             return Center(child: CircularProgressIndicator());
  //           }
  //           else if(snapshot.hasData){
  //             return ListView.builder(
  //                 itemCount: snapshot.data?.length,
  //                 itemBuilder: (context,index){
  //                   return Column(
  //                     children: [
  //                       SizedBox(height: 10,),
  //                       Card(
  //                         elevation: 4.0,
  //                         margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  //                         color: Colors.teal.shade50,
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(16.0),
  //                         ),
  //                         child: ListTile(
  //                           contentPadding: EdgeInsets.all(12.0),
  //                           leading: ClipRRect(
  //                             borderRadius: BorderRadius.circular(8.0),
  //                             child: Image.network(
  //                               snapshot.data![index].pharmacyPhoto,
  //                               width: 80.0,
  //                               height: 80.0,
  //                               fit: BoxFit.cover,
  //                             ),
  //                           ),
  //                           title: Text(
  //                             snapshot.data![index].fullName!,
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.teal,
  //                             ),
  //                           ),
  //                           subtitle: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: <Widget>[
  //                               Text(
  //                                 snapshot.data![index].pharmacyNo!,
  //                                 style: TextStyle(color: Colors.grey[600]),
  //                               ),
  //                               SizedBox(height: 4.0),
  //                               Text(
  //                                 snapshot.data![index].address!,
  //                                 style: TextStyle(color: Colors.grey[600]),
  //                               ),
  //                               SizedBox(height: 2.0),
  //                               Text(
  //                                 snapshot.data![index].city!,
  //                                 style: TextStyle(color: Colors.grey[600]),
  //                               ),
  //                               SizedBox(height: 2.0),
  //
  //                             ],
  //                           ),
  //
  //                           onTap: () {
  //                         //    Navigator.pushNamed(context, '/pharmacy_info', arguments: pharmacy);
  //                           },
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //             });
  //           }
  //         }
  //     );
  //   }
  // }


  // Widget _buildPharmacyCard(GetAllPharmacyModel pharmacy) {
  //   return Card(
  //     elevation: 4.0,
  //     margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  //     color: Colors.teal.shade50,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(16.0),
  //     ),
  //     child: ListTile(
  //       contentPadding: EdgeInsets.all(12.0),
  //       leading: ClipRRect(
  //         borderRadius: BorderRadius.circular(8.0),
  //         child: Image.network(
  //           pharmacy.imageUrl,
  //           width: 80.0,
  //           height: 80.0,
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //       title: Text(
  //         pharmacy.name,
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           color: Colors.teal,
  //         ),
  //       ),
  //       subtitle: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           SizedBox(height: 4.0),
  //           Text(
  //             pharmacy.address,
  //             style: TextStyle(color: Colors.grey[600]),
  //           ),
  //           SizedBox(height: 2.0),
  //           Text(
  //             'Opening Hours: ${pharmacy.openingHours}',
  //             style: TextStyle(color: Colors.grey[600]),
  //           ),
  //           SizedBox(height: 2.0),
  //           Row(
  //             children: <Widget>[
  //               Icon(Icons.star, color: Colors.amber),
  //               Text(
  //                 pharmacy.ratings.toString(),
  //                 style: TextStyle(color: Colors.grey[600]),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //       onTap: () {
  //         Navigator.pushNamed(context, '/pharmacy_info', arguments: pharmacy);
  //       },
  //     ),
  //   );
  // }
}
