import 'package:flutter/material.dart';

class EditCoordinatorScreen extends StatefulWidget {
  static const routeName = '/coordinator-edit';
  EditCoordinatorScreen({Key key}) : super(key: key);

  @override
  _EditCoordinatorScreenState createState() => _EditCoordinatorScreenState();
}

class _EditCoordinatorScreenState extends State<EditCoordinatorScreen> {
  var _isLoading = false;

  Future<void> _saveForm() async {
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kemaskini Koordinator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
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
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(child: Text("In process...")),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text("Test"),
                  ],
                ),
              ),
            ),
    );
  }
}
