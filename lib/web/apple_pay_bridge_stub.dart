// Stub for non-web platforms

typedef ApplePayCallback = void Function(Map<String, dynamic> paymentData);

class ApplePayWeb {
  static bool get isAvailable => false;

  static Future<bool> canMakePayments() async => false;

  static Future<Map<String, dynamic>?> requestPayment({
    required String merchantId,
    required String countryCode,
    required String currencyCode,
    required List<Map<String, dynamic>> lineItems,
    required ApplePayCallback onSuccess,
    required Function(String error) onError,
  }) async {
    onError('Apple Pay not available on this platform');
    return null;
  }
}
