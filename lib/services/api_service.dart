import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/payment_models.dart';

class ApiService {
  static const String baseUrl = 'https://goldfish-app-3lf7u.ondigitalocean.app';
  String? _authToken;

  void setAuthToken(String token) {
    _authToken = token;
  }

  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
    };
    
    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    
    return headers;
  }

  Future<AppleAccountResponse> createAppleAccount({
    String? deviceId,
    String? appleId,
  }) async {
    try {
      final request = AppleAccountRequest(
        deviceId: deviceId,
        appleId: appleId,
      );

      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/auth/apple/generate-account'),
        headers: _headers,
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AppleAccountResponse.fromJson(data);
      } else {
        throw Exception('Failed to create Apple account: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating Apple account: $e');
    }
  }

  Future<BraintreeTokenResponse> getBraintreeToken() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/v1/payments/generate-and-save-braintree-client-token'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return BraintreeTokenResponse.fromJson(data);
      } else {
        throw Exception('Failed to get Braintree token: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting Braintree token: $e');
    }
  }

  Future<PaymentMethodResponse> addPaymentMethod(String paymentToken, {String? deviceId}) async {
    try {
      final request = PaymentMethodRequest(
        paymentToken: paymentToken,
        deviceId: deviceId,
      );

      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/payments/add-payment-method'),
        headers: _headers,
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PaymentMethodResponse.fromJson(data);
      } else {
        throw Exception('Failed to add payment method: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      throw Exception('Error adding payment method: $e');
    }
  }

  Future<SubscriptionResponse> createSubscription({
    required String paymentToken,
    String thePlanId = 'tss2',
    bool disableWelcomeDiscount = false,
    int welcomeDiscount = 10,
  }) async {
    try {
      final request = SubscriptionRequest(
        paymentToken: paymentToken,
        thePlanId: thePlanId,
      );

      final queryParams = {
        'disableWelcomeDiscount': disableWelcomeDiscount.toString(),
        'welcomeDiscount': welcomeDiscount.toString(),
      };

      final uri = Uri.parse('$baseUrl/api/v1/payments/subscription/create-subscription-transaction-v2')
          .replace(queryParameters: queryParams);

      final response = await http.post(
        uri,
        headers: _headers,
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return SubscriptionResponse.fromJson(data);
      } else {
        throw Exception('Failed to create subscription: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating subscription: $e');
    }
  }

  Future<RentPowerBankResponse> rentPowerBank({
    required String stationId,
    String? deviceId,
  }) async {
    try {
      final request = RentPowerBankRequest(
        stationId: stationId,
        deviceId: deviceId,
      );

      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/payments/rent-power-bank'),
        headers: _headers,
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return RentPowerBankResponse.fromJson(data);
      } else {
        throw Exception('Failed to rent power bank: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error renting power bank: $e');
    }
  }
}
