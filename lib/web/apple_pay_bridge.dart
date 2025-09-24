// Web implementation for Apple Pay
// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;

typedef ApplePayCallback = void Function(Map<String, dynamic> paymentData);

class ApplePayWeb {
  static bool get isAvailable {
    try {
      return js.context['ApplePaySession'] != null;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> canMakePayments() async {
    if (!isAvailable) return false;
    
    try {
      final result = await js.context.callMethod('eval', [
        'ApplePaySession.canMakePayments()'
      ]);
      return result == true;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>?> requestPayment({
    required String merchantId,
    required String countryCode,
    required String currencyCode,
    required List<Map<String, dynamic>> lineItems,
    required ApplePayCallback onSuccess,
    required Function(String error) onError,
  }) async {
    if (!isAvailable) {
      onError('Apple Pay not available');
      return null;
    }

    try {
      // Calculate total from line items
      double total = 0.0;
      for (var item in lineItems) {
        if (item['type'] == 'final') {
          total += double.parse(item['amount'].toString());
        }
      }
      
      // Add total to line items
      final allLineItems = List<Map<String, dynamic>>.from(lineItems);
      allLineItems.add({
        'type': 'final',
        'label': 'Total',
        'amount': total.toStringAsFixed(2),
      });

      final session = js.JsObject(js.context['ApplePaySession'], [
        '3.0',
        js.JsObject.jsify({
          'merchantIdentifier': merchantId,
          'countryCode': countryCode,
          'currencyCode': currencyCode,
          'supportedNetworks': ['visa', 'masterCard', 'amex'],
          'merchantCapabilities': ['supports3DS'],
          'lineItems': allLineItems,
          'total': {
            'label': 'QR Pay',
            'amount': total.toStringAsFixed(2),
          },
        })
      ]);

      // Handle validation
      session.callMethod('addEventListener', [
        'validatemerchant',
        js.allowInterop((event) {
          // In real implementation, validate with your backend
          final validationURL = event['validationURL'];
          // For demo, just complete validation
          session.callMethod('completeMerchantValidation', [js.JsObject.jsify({
            'merchantSession': {
              'epochTimestamp': DateTime.now().millisecondsSinceEpoch,
              'expiresAt': DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch,
              'merchantSessionIdentifier': 'session_${DateTime.now().millisecondsSinceEpoch}',
              'nonce': 'nonce_${DateTime.now().millisecondsSinceEpoch}',
              'merchantIdentifier': merchantId,
              'domainName': 'alexandrovechkin73-a11y.github.io',
              'displayName': 'QR Pay',
              'signature': 'demo_signature'
            }
          })]);
        })
      ]);

      // Handle payment authorization
      session.callMethod('addEventListener', [
        'paymentauthorized',
        js.allowInterop((event) {
          final payment = event['payment'];
          final paymentData = {
            'token': payment['token'],
            'billingContact': payment['billingContact'],
            'shippingContact': payment['shippingContact'],
          };
          onSuccess(paymentData);
          session.callMethod('completePayment', [js.JsObject.jsify({
            'status': 0 // ApplePaySession.STATUS_SUCCESS
          })]);
        })
      ]);

      // Handle errors
      session.callMethod('addEventListener', [
        'cancel',
        js.allowInterop((event) {
          onError('Payment cancelled');
        })
      ]);

      // Start the session
      session.callMethod('begin');

      return null; // Will be handled by callbacks
    } catch (e) {
      onError('Apple Pay error: $e');
      return null;
    }
  }
}
