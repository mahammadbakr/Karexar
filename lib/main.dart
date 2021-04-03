import 'package:flutter/material.dart';
import 'package:kar_administration/Screens/AddProjectScreen/AddProjectScreen.dart';
import 'package:kar_administration/Screens/AddthingScreen/AddThingScreen.dart';
import 'package:provider/provider.dart';

import 'Constants.dart';
import 'Providers/LocationProvider.dart';
import 'Screens/AddPersonScreen/AddPersonScreen.dart';
import 'Screens/HomeScreen/HomeScreen.dart';
import 'Screens/SplashScreen/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationProvider>(
          create: (context) => LocationProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          // fontFamily: "Cinzel",
          primaryColor: ColorConstants.mainAppColor,
          primarySwatch: Colors.deepPurple,
          appBarTheme: AppBarTheme(
            elevation: 3,
          ),
        ),
        title: 'Kar',
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashScreen(),
          '/home': (context) => HomeScreen(),
          '/addPerson': (context) => AddPersonScreen(),
          '/addProject': (context) => AddProjectScreen(),
          '/addThing': (context) => AddThingScreen(),
        },
      ),
    );
  }
}
