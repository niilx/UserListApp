import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userlist/UserList/ProviderDataModel.dart';
import 'package:userlist/UserList/UserList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
          create: (context)=> ProviderData(),
          child: UserList()),
    );

  }
}

