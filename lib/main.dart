import 'package:finalblood/reg.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dbhelper.dart';
import 'donner.dart';
import 'home.dart';

void main() => runApp(BloodDonorApp());

class BloodDonorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donor App',
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home: Pagess(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imageList = [
    'assets/images/d1.png', // Ensure these images are added in pubspec.yaml
    'assets/images/d2.jpg',
    'assets/images/d3.jpg',
  ];

  List<Map<String, dynamic>> _donors = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadDonors();
  }

  Future<void> _loadDonors() async {
    final donors = await _databaseHelper.getDonors();
    setState(() {
      _donors = donors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text('Blood Donor App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Add Donor'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorForm()),
                );

              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('View Donors'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorList()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: imageList.map((item) => Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  item,
                  fit: BoxFit.cover,
                  width: 1000,
                ),
              ),
            )).toList(),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  print('Navigating to DonorForm');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DonorForm()),
                  );
                },
                child: Text('Add Donor'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  print('Navigating to DonorList');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DonorList()),
                  );
                },
                child: Text('View Donors'),
              ),
            ],
          ),

          SizedBox(height: 20),
          Expanded(
            child: _donors.isEmpty
                ? Center(
              child: Text(
                'No Donors Available',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
                : ListView.builder(
              itemCount: _donors.length,
              itemBuilder: (context, index) {
                final donor = _donors[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    leading: Icon(Icons.person, color: Colors.white),
                    title: Text(
                      donor['name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(donor['phone'],style: TextStyle(color: Colors.white),),
                    trailing:   IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed: () async {
                        final donorId = donor['id']; // Get the donor's ID
                        await _databaseHelper.deleteDonor(donorId); // Delete the donor from the database
                        _loadDonors(); // Refresh the donor list
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
