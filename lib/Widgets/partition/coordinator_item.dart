import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/coordinator_providers.dart';


class CoordinatorItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    final coordinator =
        Provider.of<CoordinatorProviders>(context, listen: false);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 10, right: 5, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  coordinator.newICNo,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: _height / 40),
                ),
                Container(
                  width: _width / 1.4,
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          coordinator.cddName,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).pushNamed(
            //       CoordinatorDetail.routeName,
            //       arguments: coordinator.cddId,
            //     );
            //   },
            //   child: Icon(
            //     Icons.info,
            //     color: Colors.blue[300],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
