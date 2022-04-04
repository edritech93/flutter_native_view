import 'package:flutter/material.dart';
import 'package:flutter_native_view/native_view_example.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          height: null,
          width: null,
          child: const NativeViewExample()),
    );
  }
}
