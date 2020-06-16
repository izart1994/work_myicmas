import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/coordinators_providers.dart';
import './edit_coordinator_detail.dart';

class CoordinatorDetail extends StatefulWidget {
  static const routeName = '/coordinator-detail';

  @override
  _CoordinatorDetailState createState() => _CoordinatorDetailState();
}

class _CoordinatorDetailState extends State<CoordinatorDetail> {
  @override
  Widget build(BuildContext context) {
    final cddId =
        ModalRoute.of(context).settings.arguments as String; // is the id
    final loadedProduct = Provider.of<CoordinatorsProviders>(
      context,
      listen: false,
    ).findById(cddId);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Informasi Koordinator'),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      loadedProduct.newICNo,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          loadedProduct.cddName,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: gender(loadedProduct.gender),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          EditCoordinatorScreen.routeName,
                          arguments: loadedProduct.cddId);
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  gender(gender) {
    if (gender != null) {
      if (gender == '2') {
        return Text(
          'Perempuan',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
        );
      } else if (gender == '1') {
        return Text(
          'Lelaki',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
        );
      }
    } else {
      return Text(
        'Belum Diisi',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 20,
        ),
      );
    }
  }
}
