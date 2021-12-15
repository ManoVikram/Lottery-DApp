import 'package:flutter/material.dart';
import 'package:lottery_dapp/models/smart_contract_linker.dart';
import 'package:provider/provider.dart';

import './screens/homeScreen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SmartContractLinker(),
      child: MaterialApp(
        title: "Lottery DApp",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const Lottery(),
      ),
    );
  }
}

class Lottery extends StatelessWidget {
  const Lottery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}

void main() {
  runApp(const MyApp());
}
