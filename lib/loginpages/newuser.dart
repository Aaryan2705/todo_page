import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn/mainn.dart';
import 'dart:io';

import 'display_page.dart';

void main() {
  runApp(Myuser());
}

class Myuser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime? _selectedDate;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  late ImagePicker _imagePicker;
  PickedFile? _image;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, ImageSource.gallery);
              },
              child: Text('Gallery'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, ImageSource.camera);
              },
              child: Text('Camera'),
            ),
          ],
        );
      },
    );

    if (imageSource != null) {
      final PickedFile? pickedFile = await _imagePicker.getImage(
        source: imageSource,
      );

      if (pickedFile != null && pickedFile.path != null) {
        setState(() {
          _image = pickedFile;
        });
      }
    }
  }

  void _navigateToDisplayPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayPage(
          name: _nameController.text,
          email: _emailController.text,
          dateOfBirth: _selectedDate != null
              ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
              : '',
          phoneNumber: _phoneController.text,
          imagePath: _image?.path ?? '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Register New User',style: TextStyle(fontWeight: FontWeight.bold),)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 700,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.green],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _image != null
                          ? Image.file(File(_image!.path)).image
                          : AssetImage('assets/user_placeholder.png'),
                      child: Opacity(
                        opacity: _image == null ? 1.0 : 0.0,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            controller: TextEditingController(
                              text: _selectedDate != null
                                  ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                                  : '',
                            ),
                            decoration: InputDecoration(labelText: 'Date of Birth'),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppp(),));
                      },
                      child: Text('Show Data'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
