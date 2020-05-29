import 'package:flutter/material.dart';
import 'package:crud/users.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
            ),
            ListTile(
              selected: true,
              leading: Icon(
                Icons.perm_identity,
                size: 25.0,
              ),
              title: Text(
                'Users',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserDataTable()),
                );
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
