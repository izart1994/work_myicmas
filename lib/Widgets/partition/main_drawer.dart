import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_providers.dart';
import '../../screens/coordinatorinfo_screen.dart';
import '../../screens/coordinatorinfo_screen_search.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _nameAdmin;
    double _height;

    final authData = Provider.of<AuthProviders>(context, listen: false);
    _nameAdmin = authData.nameAdmin;
    _height = MediaQuery.of(context).size.height;

    return Drawer(
      child: Column(
        children: <Widget>[
          Opacity(
            opacity: 0.75,
            child: Container(
              height: _height / 6,
              padding: EdgeInsets.only(top: _height / 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[600], Colors.blueAccent],
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.black,
                  ),
                  radius: 30,
                  backgroundColor: Colors.white,
                ),
                title: Text("Administrator"),
                subtitle: Text(
                  _nameAdmin,
                  style: TextStyle(fontSize: 13),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Laman Utama'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Maklumat Penyelaras"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CoordinatorInfoScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Maklumat Penyelaras Carian"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CoordinatorInfoScreenSearch.routeName);
            },
          ),
        ],
      ),
    );
  }
}
