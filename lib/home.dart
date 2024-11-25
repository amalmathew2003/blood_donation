
import 'package:flutter/material.dart';

import 'dbhelper.dart';


class DonorList extends StatefulWidget {
  @override
  _DonorListState createState() => _DonorListState();
}

class _DonorListState extends State<DonorList> {
  List<Map<String, dynamic>> _donors = [];

  Future<void> _loadDonors() async {
    final donors = await DatabaseHelper().getDonors();
    setState(() {
      _donors = donors;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDonors();
  }
  DatabaseHelper databaseHelper=DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(title: Text('Registered Donors')),
      body: ListView.separated(
        itemCount: _donors.length,
        itemBuilder: (context, index) {
          final donor = _donors[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile( tileColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              style: ListTileStyle.drawer,
              leading: Icon(Icons.person,color: Colors.white,),
              title: Text('Donor Name:${donor['name']}',style: TextStyle(color: Colors.white,fontSize: 20),),
              subtitle: Text('Phone number::${donor['phone']},             Email :${donor['email']},                       sex:${donor['sex1']},                                   ''blood group:${donor['sex']},                      ''donated date:${donor['last date']}',style: TextStyle(color: Colors.white,fontSize: 17)),
              trailing:  IconButton(
                icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () async {
            final donorId = donor['id']; // Get the donor's ID
            await databaseHelper.deleteDonor(donorId); // Delete the donor from the database
            _loadDonors(); // Refresh the donor list
            },
            ),
            ),
          );
        }, separatorBuilder: (BuildContext context, int index) {
          return SizedBox();
      },
      ),
    );
  }
}