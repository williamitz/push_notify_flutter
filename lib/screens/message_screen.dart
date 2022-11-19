import 'package:flutter/material.dart';


class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final product = ModalRoute.of(context)?.settings.arguments ?? 'No Product';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messagin'),
      ),
      body: Center(
        child: Text('$product'),
     ),
   );
  }
}