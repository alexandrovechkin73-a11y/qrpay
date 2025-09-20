import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/payment_screen.dart';
import 'screens/webview_screen.dart';

void main() {
  runApp(const QrPayApp());
}

class QrPayApp extends StatelessWidget {
  const QrPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Pay - Аренда павербанка',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B82F6),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const DeepLinkHandler(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DeepLinkHandler extends StatefulWidget {
  const DeepLinkHandler({super.key});

  @override
  State<DeepLinkHandler> createState() => _DeepLinkHandlerState();
}

class _DeepLinkHandlerState extends State<DeepLinkHandler> {
  String? _stationId;
  String? _url;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _handleDeepLink();
  }

  void _handleDeepLink() {
    Future.delayed(const Duration(seconds: 1), () {
      // Для демонстрации используем обычный flow с stationId
      const testStationId = 'RECH082203000350';
      
      setState(() {
        _stationId = testStationId;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
              SizedBox(height: 24),
              Text(
                'Загрузка...',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }


    if (_stationId == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Color(0xFFEF4444),
              ),
              const SizedBox(height: 24),
              const Text(
                'Ошибка загрузки',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Не удалось получить ID станции',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  _handleDeepLink();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: const Text('Повторить'),
              ),
            ],
          ),
        ),
      );
    }

    return PaymentScreen(stationId: _stationId!);
  }
}
