import 'package:flutter/material.dart';
import 'dart:io';
import 'package:learn/constant.dart';
import 'package:learn/mainn.dart';
import 'package:learn/todoo.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../appointments.dart';
import '../bottom_navigation.dart';
import '../constant.dart';
import '../mainn.dart';


class DisplayPage extends StatefulWidget {
  final String name;
  final String email;
  final String dateOfBirth;
  final String phoneNumber;
  final String imagePath;

  DisplayPage({
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.imagePath,
  });

  toJson(){
    return {"full name": name, "email":email, "dob": dateOfBirth , "number": phoneNumber , "image": imagePath};
  }

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildUserImage(),
              SizedBox(height: 16),
              Text('Name: ${widget.name}'),
              SizedBox(height: 8),
              Text('Email: ${widget.email}'),
              SizedBox(height: 8),
              Text('Date of Birth: ${widget.dateOfBirth}'),
              SizedBox(height: 8),
              Text('Phone Number: ${widget.phoneNumber}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserImage() {
    if (widget.imagePath.isNotEmpty) {
      final File imageFile = File(widget.imagePath);
      if (imageFile.existsSync()) {
        return Image.file(
          imageFile,
          height: 120,
          width: 120,
        );
      }
    }

    return Image.asset(
      'assets/user_placeholder.png',
      height: 120,
      width: 120,
    );
  }
}
