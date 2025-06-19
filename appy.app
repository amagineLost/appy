import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secret Passcode App',
      home: PasscodeScreen(),
    );
  }
}

class PasscodeScreen extends StatefulWidget {
  @override
  _PasscodeScreenState createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> {
  final _controller = TextEditingController();
  String? _error;

  void _checkPasscode() {
    if (_controller.text == 'Testy123') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChannelScreen()),
      );
    } else {
      setState(() {
        _error = 'Incorrect passcode!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Passcode')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Secret Passcode',
                errorText: _error,
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkPasscode,
              child: Text('Enter'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChannelScreen extends StatefulWidget {
  @override
  _ChannelScreenState createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  final _channelController = TextEditingController();
  String? _message;

  Future<void> _createChannel() async {
    final channelName = _channelController.text;
    if (channelName.isEmpty) return;

    // Replace with your backend endpoint
    final url = Uri.parse('https://your-backend-url.com/create-channel');
    final response = await http.post(url, body: {'channel_name': channelName});

    setState(() {
      if (response.statusCode == 200) {
        _message = 'Channel created!';
      } else {
        _message = 'Failed to create channel.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Discord Channel')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _channelController,
              decoration: InputDecoration(labelText: 'Channel Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createChannel,
              child: Text('Create Channel'),
            ),
            if (_message != null) ...[
              SizedBox(height: 20),
              Text(_message!),
            ]
          ],
        ),
      ),
    );
  }
}
