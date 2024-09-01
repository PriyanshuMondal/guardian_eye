import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer' as devtools show log;

class WalkWithMePage extends StatefulWidget {
  const WalkWithMePage({super.key});

  @override
  State<WalkWithMePage> createState() => _WalkWithMePageState();
}

class _WalkWithMePageState extends State<WalkWithMePage> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  String _userPin = "";
  Timer? _securityTimer;

  @override
  void dispose() {
    _securityTimer?.cancel(); // Cancel the timer when the page is disposed
    _fromController.dispose();
    _toController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _startWalk() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Set Security Pin'),
          content: TextField(
            controller: _pinController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Enter a unique security pin',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_pinController.text.isNotEmpty) {
                  setState(() {
                    _userPin = _pinController.text;
                  });
                  Navigator.of(context).pop();
                  _startSecurityCheck(); // Start the security pin check
                }
              },
              child: const Text('Start'),
            ),
          ],
        );
      },
    );
  }

  void _startSecurityCheck() {
    _securityTimer = Timer.periodic(const Duration(minutes: 3), (timer) {
      _promptSecurityPin(); // Prompt for security pin every 3 minutes
    });
  }

  void _promptSecurityPin() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog without input
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Security Check'),
          content: TextField(
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Enter your security pin',
            ),
            onChanged: (value) {
              if (value == _userPin) {
                Navigator.of(context).pop(); // Close the dialog if pin matches
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_pinController.text != _userPin) {
                  _triggerDangerAlert(); // Trigger danger alert if the pin is incorrect
                } else {
                  Navigator.of(context)
                      .pop(); // Close the dialog if pin matches
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _triggerDangerAlert() {
    // Logic to handle the danger alert (e.g., send notifications, alert emergency contacts)
    devtools.log('User in danger! Sending alert...');
    // Here you would implement actual alert logic, like sending an SOS message
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Walk with Me'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _fromController,
              decoration: const InputDecoration(
                labelText: 'From',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _toController,
              decoration: const InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startWalk,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Start Walk'),
            ),
          ],
        ),
      ),
    );
  }
}
