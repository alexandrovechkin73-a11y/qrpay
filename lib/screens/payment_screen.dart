import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';
import '../services/apple_pay_service.dart';
import 'success_screen.dart';
import 'webview_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String stationId;

  const PaymentScreen({
    super.key,
    required this.stationId,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String? _errorMessage;
  String? _paymentToken;

  @override
  void initState() {
    super.initState();
    _initializePayment();
  }

  Future<void> _initializePayment() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _apiService.getBraintreeToken();
    } catch (e) {
      print('API Error (Demo mode): $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _processPayment() async {
    if (_paymentToken == null) {
      setState(() {
        _errorMessage = 'Ошибка: токен платежа не получен';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));
      
      await _apiService.createSubscription(
        paymentToken: _paymentToken!,
      );

      final rentResponse = await _apiService.rentPowerBank(
        stationId: widget.stationId,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessScreen(
              powerBankId: rentResponse.powerBankId ?? 'PB${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
              rentalId: rentResponse.rentalId ?? 'R${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
            ),
          ),
        );
      }
    } catch (e) {
      print('API Error (Demo mode): $e');
      
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessScreen(
              powerBankId: 'PB${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
              rentalId: 'R${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
            ),
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _simulateApplePay() async {
    if (kIsWeb) {
      final canPay = await ApplePayService.canMakePayments();
      if (canPay) {
        final result = await ApplePayService.requestPayment(
          amount: '4.99',
          currency: 'USD',
          merchantId: 'merchant.com.qrpay.demo',
        );
        
        if (result != null && result['success'] == true) {
          setState(() {
            _paymentToken = result['paymentToken'];
          });
          _processPayment();
        } else {
          setState(() {
            _errorMessage = 'Apple Pay недоступен';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Apple Pay не поддерживается на этом устройстве';
        });
      }
    } else {
      setState(() {
        _paymentToken = 'apple_pay_token_${DateTime.now().millisecondsSinceEpoch}';
      });
      _processPayment();
    }
  }

  void _simulateCardPayment() {
    setState(() {
      _paymentToken = 'card_payment_token_${DateTime.now().millisecondsSinceEpoch}';
    });
    _processPayment();
  }

  void _openWebViewPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WebViewScreen(
          url: 'web/test_webview.html',
          title: 'Оплата картой',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Subscribe',
          style: TextStyle(
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                const SizedBox(height: 40),
                
                Text(
                  'Monthly Subscription',
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF0B0B0B),
                    letterSpacing: 0.01,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 16),
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$4.99',
                      style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B0B0B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '\$9.99',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF9CA3AF),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                Text(
                  'First month only',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                Container(
                  height: 1,
                  color: const Color(0xFFE5E7EB),
                ),
                
                const SizedBox(height: 24),
                
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                    ),
                  )
                else ...[
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _simulateApplePay,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.apple, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Pay',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Container(
                    height: 1,
                    color: const Color(0xFFE5E7EB),
                  ),
                  
                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      onPressed: _openWebViewPayment,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.credit_card, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                'Debit or credit card',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF0B0B0B),
                                ),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF0B0B0B)),
                        ],
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                if (_errorMessage != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFEF4444).withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: Color(0xFFEF4444),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WebViewScreen(
                          url: 'web/test_webview.html',
                          title: 'Поддержка',
                        ),
                      ),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      text: 'Nothing happened? ',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF9CA3AF),
                      ),
                      children: [
                        TextSpan(
                          text: 'Contact support',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF3B82F6),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
