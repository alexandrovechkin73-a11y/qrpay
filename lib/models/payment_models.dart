import 'package:json_annotation/json_annotation.dart';

part 'payment_models.g.dart';

@JsonSerializable()
class AppleAccountRequest {
  final String? deviceId;
  final String? appleId;

  AppleAccountRequest({
    this.deviceId,
    this.appleId,
  });

  factory AppleAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$AppleAccountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AppleAccountRequestToJson(this);
}

@JsonSerializable()
class AppleAccountResponse {
  final String? token;
  final String? userId;
  final String? message;

  AppleAccountResponse({
    this.token,
    this.userId,
    this.message,
  });

  factory AppleAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$AppleAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppleAccountResponseToJson(this);
}

@JsonSerializable()
class BraintreeTokenResponse {
  final String? token;
  final String? message;

  BraintreeTokenResponse({
    this.token,
    this.message,
  });

  factory BraintreeTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$BraintreeTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BraintreeTokenResponseToJson(this);
}

@JsonSerializable()
class PaymentMethodRequest {
  final String paymentToken;
  final String? deviceId;

  PaymentMethodRequest({
    required this.paymentToken,
    this.deviceId,
  });

  factory PaymentMethodRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodRequestToJson(this);
}

@JsonSerializable()
class PaymentMethodResponse {
  final String? paymentMethodId;
  final String? message;
  final bool? success;

  PaymentMethodResponse({
    this.paymentMethodId,
    this.message,
    this.success,
  });

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodResponseToJson(this);
}

@JsonSerializable()
class SubscriptionRequest {
  final String paymentToken;
  final String thePlanId;

  SubscriptionRequest({
    required this.paymentToken,
    required this.thePlanId,
  });

  factory SubscriptionRequest.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionRequestToJson(this);
}

@JsonSerializable()
class SubscriptionResponse {
  final String? subscriptionId;
  final String? message;
  final bool? success;

  SubscriptionResponse({
    this.subscriptionId,
    this.message,
    this.success,
  });

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionResponseToJson(this);
}

@JsonSerializable()
class RentPowerBankRequest {
  final String stationId;
  final String? deviceId;

  RentPowerBankRequest({
    required this.stationId,
    this.deviceId,
  });

  factory RentPowerBankRequest.fromJson(Map<String, dynamic> json) =>
      _$RentPowerBankRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RentPowerBankRequestToJson(this);
}

@JsonSerializable()
class RentPowerBankResponse {
  final String? rentalId;
  final String? message;
  final bool? success;
  final String? powerBankId;

  RentPowerBankResponse({
    this.rentalId,
    this.message,
    this.success,
    this.powerBankId,
  });

  factory RentPowerBankResponse.fromJson(Map<String, dynamic> json) =>
      _$RentPowerBankResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RentPowerBankResponseToJson(this);
}
