import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BrowserApp());
}

class BrowserApp extends StatelessWidget {
  const BrowserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Browser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BrowserHomePage(),
    );
  }
}

class BrowserHomePage extends StatefulWidget {
  const BrowserHomePage({super.key});

  @override
  State<BrowserHomePage> createState() => _BrowserHomePageState();
}

class _BrowserHomePageState extends State<BrowserHomePage> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();
  String _token = '';

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token') ?? '';
    });
  }

  Future<void> _saveToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _tokenController.text);
    setState(() {
      _token = _tokenController.text;
    });
  }

  void _openUrl() {
    final url = _urlController.text;
    print('فتح URL: $url');
    // هنا يمكنك إضافة منطق لفتح URL في متصفح الويب
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Browser'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'أدخل URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _openUrl,
              child: const Text('فتح المتصفح'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _tokenController,
              decoration: const InputDecoration(
                labelText: 'أدخل مفتاح التوكن',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveToken,
              child: const Text('حفظ التوكن'),
            ),
            const SizedBox(height: 20),
            Text('التوكن الحالي: $ _token'),
          ],
        ),
      ),
    );
  }
}