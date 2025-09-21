// Web implementation: opens a popup with Braintree Drop-in page and
// listens for a nonce via postMessage
// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html' as html;

typedef NonceCallback = void Function(String nonce);

void openCardPaymentPopup(String clientToken, NonceCallback onNonce) {
  final encoded = Uri.encodeComponent(clientToken);
  final url = Uri.base.resolve('card_payment.html#$encoded').toString();
  final popup = html.window.open(
    url,
    'card_payment',
    'width=420,height=720,menubar=no,toolbar=no,location=no,status=no',
  );

  StreamSubscription<html.MessageEvent>? subscription;
  subscription = html.window.onMessage.listen((event) {
    try {
      final data = event.data;
      if (data is Map && data['type'] == 'braintreeNonce' && data['nonce'] is String) {
        onNonce(data['nonce'] as String);
        subscription?.cancel();
        try {
          popup?.close();
        } catch (_) {}
      }
    } catch (_) {
      // ignore
    }
  });
}


