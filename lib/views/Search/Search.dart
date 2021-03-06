import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'Widgets/ListUsers.dart';
import 'Widgets/UserSearch.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DatabaseMethods _databaseMethods = new DatabaseMethods();

  Future _userDocumentSnapshots;

  @override
  void initState() {
    super.initState();
    _userDocumentSnapshots = _databaseMethods.getAllUserDocumentSnapshot();
  }

  Future<void> _refreshPage() async {
    setState(() {
      _userDocumentSnapshots = _databaseMethods.getAllUserDocumentSnapshot();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: UserSearch(
                      userDocumentSnapshots: _userDocumentSnapshots));
            },
          )
        ],
        title: Center(
          child: Text(
            'Search',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        child: RefreshIndicator(
          child: FutureBuilder(
              future: _userDocumentSnapshots,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text("Loading..."),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        return ListUsers(
                          id: snapshot.data[index].data['id'],
                          displayName: snapshot.data[index].data['displayName'],
                          photoUrl: snapshot.data[index].data['photoUrl'],
                          designation: snapshot.data[index].data['designation'],
                          email: snapshot.data[index].data['email'],
                        );
                      });
                }
              }),
          onRefresh: _refreshPage,
        ),
      ),
    );
  }
}
