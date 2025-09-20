import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String? title;

  const WebViewScreen({
    super.key,
    required this.url,
    this.title,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebViewController? _controller;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    // Для веб-платформы используем url_launcher
    if (kIsWeb) {
      _openUrlInBrowser();
      return;
    }

    // Для мобильных платформ используем WebView
    _initializeMobileWebView();
  }

  @override
  Widget build(BuildContext context) {
    // Для веб-платформы показываем только индикатор загрузки
    if (kIsWeb) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.title ?? 'Веб-страница',
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
              SizedBox(height: 24),
              Text(
                'Открытие в браузере...',
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

    // Для мобильных платформ используем обычный WebView
    return _buildMobileWebView();
  }

  Widget _buildMobileWebView() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title ?? 'Веб-страница',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: _goBack,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: _reload,
          ),
        ],
      ),
      body: Stack(
        children: [
          if (_errorMessage != null)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Color(0xFFEF4444),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Ошибка загрузки',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xFF9CA3AF),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _reload,
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
            )
          else if (_controller != null)
            WebViewWidget(controller: _controller!)
          else
            const Center(
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
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: _goBack,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onPressed: _goForward,
            ),
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black),
              onPressed: _reload,
            ),
            IconButton(
              icon: const Icon(Icons.home, color: Colors.black),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _initializeMobileWebView() {
    try {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Обновляем прогресс загрузки
            },
            onPageStarted: (String url) {
              setState(() {
                _isLoading = true;
                _errorMessage = null;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
              });
            },
            onWebResourceError: (WebResourceError error) {
              setState(() {
                _isLoading = false;
                _errorMessage = 'Ошибка загрузки: ${error.description}';
              });
            },
            onNavigationRequest: (NavigationRequest request) {
              // Разрешаем все навигации
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.url));
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'WebView недоступен на этой платформе';
      });
    }
  }

  void _openUrlInBrowser() async {
    try {
      final uri = Uri.parse(widget.url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        // Закрываем экран после открытия ссылки
        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Не удалось открыть ссылку';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Ошибка открытия ссылки: $e';
      });
    }
  }

  void _goBack() async {
    if (kIsWeb) {
      Navigator.of(context).pop();
      return;
    }
    
    if (_controller != null && await _controller!.canGoBack()) {
      await _controller!.goBack();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _goForward() async {
    if (kIsWeb) {
      return;
    }
    
    if (_controller != null && await _controller!.canGoForward()) {
      await _controller!.goForward();
    }
  }

  void _reload() {
    if (kIsWeb) {
      _openUrlInBrowser();
      return;
    }
    
    _controller?.reload();
  }

}
