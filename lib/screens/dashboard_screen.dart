import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_providers.dart';
import '../Widgets/UI/custom_shape.dart';
import '../Widgets/partition/main_drawer.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double _height;
  double _width;
  String _token;

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProviders>(context, listen: false);
    _token = authData.token;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      drawer: MainDrawer(),
      body: Container(
        height: _height,
        width: _width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
            ],
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _height / 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[400], Colors.blueAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _height / 3.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[400], Colors.blueAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.25,
          child: ClipPath(
            clipper: CustomShapeClipper3(),
            child: Container(
              height: _height / 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[400], Colors.blueAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40, right: 40, top: _height / 3.75),
          child: Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 8,
            child: Container(
              child: TextFormField(
                cursorColor: Colors.blue[200],
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon:
                      Icon(Icons.search, color: Colors.blue[300], size: 30),
                  hintText: "What're you looking for?",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
        ),
        Container(
          //color: Colors.blue,
          margin: EdgeInsets.only(left: 20, right: 20, top: _height / 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Opacity(
                opacity: 0.5,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState.openDrawer();
                    },
                    child: Image.asset(
                      'assets/images/menubutton.png',
                      height: _height / 40,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  height: _height / 20,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          print('Editing location');
                        },
                        child: Icon(
                          Icons.edit_location,
                          color: Colors.white,
                          size: _height / 40,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(_token,
                            style: TextStyle(
                                color: Colors.white, fontSize: _height / 50),
                            // overflow: TextOverflow.fade,
                            softWrap: false),
                      ),
                    ],
                  ),
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: _height / 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
