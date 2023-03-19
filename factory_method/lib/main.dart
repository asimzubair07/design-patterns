import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FactoryMethodPage(),
    );
  }
}

class FactoryMethodPage extends StatefulWidget {
  const FactoryMethodPage({super.key});

  @override
  State<FactoryMethodPage> createState() => _FactoryMethodPageState();
}

class _FactoryMethodPageState extends State<FactoryMethodPage> {
  final List<CustomDialog> customDialogList = [
    AndroidDialog(),
    IosDialog(),
  ];

  int _selectedDialogIndex = 0;

  Future _showCustomDialog(BuildContext context) async {
    final selectedDialog = customDialogList[_selectedDialogIndex];

    await selectedDialog.show(context);
  }

  void _setSelectedDialogIndex(int? index) {
    setState(() {
      _selectedDialogIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoButton(
                onPressed: () {
                  _setSelectedDialogIndex(_selectedDialogIndex == 0 ? 1 : 0);
                  _showCustomDialog(context);
                },
                child: const Text("Alert Dialog"))
          ],
        ),
      ),
    );
    ;
  }
}
