import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DesignationProfilePage/Student.dart';
import 'DesignationProfilePage/Teacher.dart';
import 'DesignationProfilePage/Council.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socail_network_flutter/services/Database.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  ProfilePage({@required this.uid});
  @override
  _ProfilePagestate createState() => _ProfilePagestate();
}

class _ProfilePagestate extends State<ProfilePage> {
  static DatabaseMethods databaseMethods = new DatabaseMethods();
  String designation;

  getUserData() async {
    print('User id in profile: ${widget.uid}');
    List<DocumentSnapshot> documents =
        await databaseMethods.findUserById(widget.uid);
    if (!mounted) return;
    setState(() {
      designation = documents[0]['designation'];
    });
  }

  handleFields(designation) {
    switch (designation) {
      case 'Student':
        return StudentProfile(uid: widget.uid);
      case 'Teacher':
        return TeacherProfile(uid: widget.uid);
      case 'Council':
        return CouncilProfile(uid: widget.uid);
      default:
        return Center(child: Container());
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text('Profile', style: TextStyle(color: Colors.black)),
      ),
      body: handleFields(designation),
    );
  }
}
