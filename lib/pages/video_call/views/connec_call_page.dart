import 'package:flutter/material.dart';
import 'package:tdmubook/pages/video_call/views/video_call_page.dart';

class ConnecCallPage extends StatelessWidget {
  const ConnecCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userIdIDController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController callIDController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userIdIDController,
              decoration: const InputDecoration(labelText: 'User ID'),
            ),
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(labelText: 'User Name'),
            ),
            TextField(
              controller: callIDController,
              decoration: const InputDecoration(labelText: 'Call ID'),
            ),

            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoCallPage(userId: userIdIDController.text, userName: userNameController.text, callID: callIDController.text)));
            }, child: const Text('Connect Call')),
          ],
        ),
      ),
    );
  }
}
