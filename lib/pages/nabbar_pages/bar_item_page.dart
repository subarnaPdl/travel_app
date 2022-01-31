import 'package:flutter/material.dart';

class BarItemPage extends StatefulWidget {
  const BarItemPage({Key? key}) : super(key: key);

  @override
  _BarItemPageState createState() => _BarItemPageState();
}

class _BarItemPageState extends State<BarItemPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Bar Item Page"),
    );
  }
}
