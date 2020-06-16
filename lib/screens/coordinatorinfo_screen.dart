import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/coordinators_providers.dart';
import '../providers/auth_providers.dart';
import '../Widgets/partition/main_drawer.dart';
import '../Widgets/partition/coordinators_item.dart';

class CoordinatorInfoScreen extends StatefulWidget {
  static const routeName = '/userinfo';

  @override
  _CoordinatorInfoScreenState createState() => _CoordinatorInfoScreenState();
}

class _CoordinatorInfoScreenState extends State<CoordinatorInfoScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var _isInit = true;
  var _isLoading = true;
  double _height;
  double _width;
  String _token;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<CoordinatorsProviders>(context)
          .fetchAndSetCoordinator()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
              Divider(),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                child: Material(
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 8,
                  child: Container(
                    child: TextFormField(
                      cursorColor: Colors.blue[300],
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        prefixIcon: Icon(Icons.search,
                            color: Colors.blue[300], size: 30),
                        hintText: "Name you want to search?",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none),
                      ),
                      onChanged: (text) {
                        text = text.toLowerCase();
                      },
                    ),
                  ),
                ),
              ),
              Container(
                height: _height - 10,
                child: _isLoading
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Text("In process..."),
                          ),
                        ],
                      )
                    : CoordinatorsItem(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Container(
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
                        child: Text(
                          _token,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: _height / 50,
                          ),
                          softWrap: false,
                        ),
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
