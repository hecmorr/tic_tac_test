import 'package:flutter/material.dart';
import 'package:tic_tac_toe/pages/tic_tac_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic tac toe',
      home: Scaffold(body: TicTacPage()),
    );
  }
}
