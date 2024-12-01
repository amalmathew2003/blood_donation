import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dbhelper.dart';

class DonorForm extends StatefulWidget {
  @override
  _DonorFormState createState() => _DonorFormState();
}

class _DonorFormState extends State<DonorForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateController = TextEditingController();
  String? _sex;
  String? _sex1;

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _saveDonor() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> donor = {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'sex': _sex,
        'sex1': _sex1,
        // 'last date': _dateController.text,

      };

      try {
        await DatabaseHelper().insertDonor(donor);
        Navigator.pop(context, true);
      } catch (e) {
        print('Error saving donor: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save donor. Please try again.')),
        );
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Donor')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter a phone number' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter an email' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Blood Group',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    items: [
                      'A+',
                      'A-',
                      'B+',
                      'B-',
                      'AB+',
                      'AB-',
                      'O+',
                      'O-',
                    ]
                        .map((label) =>
                        DropdownMenuItem(child: Text(label), value: label))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _sex = value;
                      });
                    },
                    validator: (value) =>
                    value == null ? 'Please select a blood group' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Sex',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    items: ['Male', 'Female', 'Others']
                        .map((label) =>
                        DropdownMenuItem(child: Text(label), value: label))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        _sex1 = v;
                      });
                    },
                    validator: (value) =>
                    value == null ? 'Please select a gender' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Donation Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: _pickDate,
                      ),
                    ),
                    readOnly: true,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please select a date'
                        : null,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveDonor,

                  child: Text('Save Donor'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
