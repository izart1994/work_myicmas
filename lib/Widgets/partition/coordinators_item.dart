import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/coordinators_providers.dart';
import 'coordinator_item.dart';

class CoordinatorsItem extends StatelessWidget {
  @override
  Widget build([BuildContext context]) {
    final coordinatorsData =
        Provider.of<CoordinatorsProviders>(context, listen: false);
    final coordinators = coordinatorsData.items;

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.all(15),
      itemCount: coordinators.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: coordinators[index],
        child: CoordinatorItem(),
      ),
    );
  }
}
