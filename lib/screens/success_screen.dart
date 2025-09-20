import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessScreen extends StatelessWidget {
  final String powerBankId;
  final String rentalId;

  const SuccessScreen({
    super.key,
    required this.powerBankId,
    required this.rentalId,
  });

  Future<void> _launchApp() async {
    const appUrl = 'qrpay://open';
    final uri = Uri.parse(appUrl);
    
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Payment Successful!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    
                    Text(
                      'Stay Powered Anytime',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF0B0B0B),
                        letterSpacing: 0.01,
                        height: 1.17,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    Text(
                      'To return your power bank and keep enjoying our service for free, simply download the app!',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xFF0B0B0B),
                        height: 1.2,
                        letterSpacing: 0.02,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF99F88D), Color(0xFF86E71F)],
                      stops: [0.62, 0.83],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton(
                    onPressed: _launchApp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: const Color(0xFF0B0B0B),
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Download App',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.04,
                        color: const Color(0xFF0B0B0B),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              Center(
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
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}