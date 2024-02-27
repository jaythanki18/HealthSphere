class Pharmacy {
  final String name;
  final String address;
  final String openingHours;
  final double ratings;
  final String imageUrl;
  final String city;

  Pharmacy({
    required this.name,
    required this.address,
    required this.openingHours,
    required this.ratings,
    required this.imageUrl,
    required this.city,
  });
}

List<Pharmacy> dummyPharmacies = [
  Pharmacy(
    name: 'ABC Pharmacy',
    address: '123 Main Street',
    openingHours: '9:00 AM - 6:00 PM',
    ratings: 4.5,
    imageUrl:
    'https://deliveritpharmacy.com/wp-content/uploads/2023/08/XSX1.jpg',
    city: 'New York',
  ),
  Pharmacy(
    name: 'XYZ Pharmacy',
    address: '456 Elm Street',
    openingHours: '10:00 AM - 7:00 PM',
    ratings: 3.8,
    imageUrl:
    'https://deliveritpharmacy.com/wp-content/uploads/2023/08/BEDFORD-LOCATION-PIN.jpg',
    city: 'Los Angeles',
  ),
  Pharmacy(
    name: 'PharmaCare',
    address: '789 Oak Street',
    openingHours: '8:30 AM - 5:30 PM',
    ratings: 4.2,
    imageUrl:
    'https://forwardpharmacywi.com/wp-content/uploads/2021/09/DSC_7706.jpg.webp',
    city: 'Chicago',
  ),
];
