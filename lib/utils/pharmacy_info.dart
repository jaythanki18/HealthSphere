import 'package:flutter/material.dart';
import 'pharmacy.dart';

class PharmacyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pharmacy pharmacy =
    ModalRoute.of(context)!.settings.arguments as Pharmacy;

    return Scaffold(
      appBar: AppBar(
        title: Text(pharmacy.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${pharmacy.name}'),
            Text('Address: ${pharmacy.address}'),
            Text('Opening Hours: ${pharmacy.openingHours}'),
            Text('Ratings: ${pharmacy.ratings}'),
          ],
        ),
      ),
    );
  }
}
