// Stub for non-web platforms

typedef NonceCallback = void Function(String nonce);

void openCardPaymentPopup(String clientToken, NonceCallback onNonce) {
  // Not supported outside web
}


