import 'package:flutter/material.dart';
import 'Donor_detalis.dart';
import 'dbhelper.dart';

class DonorList extends StatefulWidget {
  @override
  _DonorListState createState() => _DonorListState();
}

class _DonorListState extends State<DonorList> {
  List<Map<String, dynamic>> _donors = [];
  List<Map<String, dynamic>> _filteredDonors = [];
  TextEditingController _searchController = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<void> _loadDonors() async {
    final donors = await DatabaseHelper().getDonors();
    setState(() {
      _donors = donors;
      _filteredDonors = donors; // Initialize filtered list with all donors
    });
  }

  void _filterDonors(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredDonors = _donors;
      });
    } else {
      setState(() {
        _filteredDonors = _donors.where((donor) {
          final name = donor['name'].toString().toLowerCase();

          final bloodGroup = donor['sex'].toString().toLowerCase();
          return name.contains(query.toLowerCase()) ||
              bloodGroup.contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDonors();
    _searchController.addListener(() {
      _filterDonors(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(title: Text('Registered Donors')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search donors...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _filteredDonors.length,
              itemBuilder: (context, index) {
                final donor = _filteredDonors[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    style: ListTileStyle.drawer,
                    leading: Icon(Icons.person, color: Colors.white),
                    title: Text(
                      'Donor Name: ${donor['name']}',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    subtitle: Text(
                      'Phone: ${donor['phone']}, Email: ${donor['email']}, '
                          'Sex: ${donor['sex1']}, Blood Group: ${donor['sex']}, '
                          'Last Donated: ${donor['last date']}',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed: () async {
                        final donorId = donor['id']; // Get the donor's ID
                        await databaseHelper.deleteDonor(donorId); // Delete the donor
                        _loadDonors(); // Refresh the donor list
                      },
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                        return DonorDetails(donor:donor);
                      }));
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 5);
              },
            ),
          ),
        ],
      ),
    );
  }
}
