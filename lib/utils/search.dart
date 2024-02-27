import 'package:flutter/material.dart';
import 'pharmacy.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Pharmacy> _pharmacies = [];
  bool _isSearching = false;
  bool _showSearchImage = true;
  bool _searched = false;

  @override
  void initState() {
    super.initState();

    _pharmacies.addAll(dummyPharmacies);
  }

  @override
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
                          _searchPharmacies();
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _searchPharmacies();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: Center(
                  child: _buildSearchResults(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_isSearching) {
      return CircularProgressIndicator();
    } else if (_searched && _pharmacies.isEmpty) {
      return Text(
        'No results found.',
        style: TextStyle(fontSize: 18.0),
      );
    } else {
      return ListView.builder(
        itemCount: _pharmacies.length,
        itemBuilder: (context, index) {
          return _buildPharmacyCard(_pharmacies[index]);
        },
      );
    }
  }

  void _searchPharmacies() async {
    setState(() {
      _isSearching = true;
      _searched = true;
      _pharmacies.clear();
    });

    String searchTerm = _searchController.text.trim().toLowerCase();

    await Future.delayed(Duration(milliseconds: 500));

    List<Pharmacy> filteredPharmacies = dummyPharmacies
        .where((pharmacy) => pharmacy.city.toLowerCase().contains(searchTerm))
        .toList();

    setState(() {
      _isSearching = false;
      _pharmacies.addAll(filteredPharmacies);
    });
  }

  Widget _buildPharmacyCard(Pharmacy pharmacy) {
    return Card(
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
          child: Image.network(
            pharmacy.imageUrl,
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          pharmacy.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 4.0),
            Text(
              pharmacy.address,
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 2.0),
            Text(
              'Opening Hours: ${pharmacy.openingHours}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 2.0),
            Row(
              children: <Widget>[
                Icon(Icons.star, color: Colors.amber),
                Text(
                  pharmacy.ratings.toString(),
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, '/pharmacy_info', arguments: pharmacy);
        },
      ),
    );
  }
}
