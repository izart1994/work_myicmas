import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_providers.dart';
import 'providers/coordinators_providers.dart';

import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/coordinatorinfo_screen.dart';
import 'screens/coordinatorinfo_screen_search.dart';
import 'screens/coordinator_detail.dart';
import 'screens/edit_coordinator_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProviders(),
        ),
        ChangeNotifierProxyProvider<AuthProviders, CoordinatorsProviders>(
          builder: (ctx, auth, previousCoordinators) => CoordinatorsProviders(
            auth.token,
            previousCoordinators == null ? [] :previousCoordinators.items,
          ),
        ),
      ],
      child: Consumer<AuthProviders>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'ICMAS',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.blue[200],
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? DashboardScreen()
              : FutureBuilder(
                  future: auth.tryAutoSignin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? LoadingScreen()
                          : LoginScreen(),
                ),
          routes: {
            CoordinatorInfoScreen.routeName: (context) => CoordinatorInfoScreen(),
            CoordinatorInfoScreenSearch.routeName: (context) => CoordinatorInfoScreenSearch(),
            CoordinatorDetail.routeName: (context) => CoordinatorDetail(),
            EditCoordinatorScreen.routeName: (context) => EditCoordinatorScreen(),
          },
        ),
      ),
    );
  }
}
