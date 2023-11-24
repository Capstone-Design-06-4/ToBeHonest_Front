import 'package:flutter/material.dart';

class MessagedShowPage extends StatelessWidget {
  const MessagedShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messaged Show Page'),
        backgroundColor: Colors.orange[200],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text('TO BE CONTINUED...'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
