import 'package:flutter/material.dart';

class DonorDetails extends StatelessWidget {
  final Map<String, dynamic> donor;

  DonorDetails({required this.donor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${donor['name']} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${donor['name']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Phone: ${donor['phone']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Email: ${donor['email']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Sex: ${donor['sex1']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Blood Group: ${donor['sex']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Last Donated: ${donor['last date']}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
