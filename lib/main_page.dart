import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Text title = const Text('My App');
    Text bodyText = const Text('Hello, world!');
    AppBar appBar = AppBar(title: title);
    Scaffold scaffold = Scaffold(
      appBar: appBar,
      body: Center(child: bodyText),
    );

    return scaffold;
  }
}
