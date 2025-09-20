// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppleAccountRequest _$AppleAccountRequestFromJson(Map<String, dynamic> json) =>
    AppleAccountRequest(
      deviceId: json['deviceId'] as String?,
      appleId: json['appleId'] as String?,
    );

Map<String, dynamic> _$AppleAccountRequestToJson(AppleAccountRequest instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'appleId': instance.appleId,
    };

AppleAccountResponse _$AppleAccountResponseFromJson(Map<String, dynamic> json) =>
    AppleAccountResponse(
      token: json['token'] as String?,
      userId: json['userId'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AppleAccountResponseToJson(AppleAccountResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userId': instance.userId,
      'message': instance.message,
    };

BraintreeTokenResponse _$BraintreeTokenResponseFromJson(Map<String, dynamic> json) =>
    BraintreeTokenResponse(
      token: json['token'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BraintreeTokenResponseToJson(BraintreeTokenResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'message': instance.message,
    };

PaymentMethodRequest _$PaymentMethodRequestFromJson(Map<String, dynamic> json) =>
    PaymentMethodRequest(
      paymentToken: json['paymentToken'] as String,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$PaymentMethodRequestToJson(PaymentMethodRequest instance) =>
    <String, dynamic>{
      'paymentToken': instance.paymentToken,
      'deviceId': instance.deviceId,
    };

PaymentMethodResponse _$PaymentMethodResponseFromJson(Map<String, dynamic> json) =>
    PaymentMethodResponse(
      paymentMethodId: json['paymentMethodId'] as String?,
      message: json['message'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$PaymentMethodResponseToJson(PaymentMethodResponse instance) =>
    <String, dynamic>{
      'paymentMethodId': instance.paymentMethodId,
      'message': instance.message,
      'success': instance.success,
    };

SubscriptionRequest _$SubscriptionRequestFromJson(Map<String, dynamic> json) =>
    SubscriptionRequest(
      paymentToken: json['paymentToken'] as String,
      thePlanId: json['thePlanId'] as String,
    );

Map<String, dynamic> _$SubscriptionRequestToJson(SubscriptionRequest instance) =>
    <String, dynamic>{
      'paymentToken': instance.paymentToken,
      'thePlanId': instance.thePlanId,
    };

SubscriptionResponse _$SubscriptionResponseFromJson(Map<String, dynamic> json) =>
    SubscriptionResponse(
      subscriptionId: json['subscriptionId'] as String?,
      message: json['message'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$SubscriptionResponseToJson(SubscriptionResponse instance) =>
    <String, dynamic>{
      'subscriptionId': instance.subscriptionId,
      'message': instance.message,
      'success': instance.success,
    };

RentPowerBankRequest _$RentPowerBankRequestFromJson(Map<String, dynamic> json) =>
    RentPowerBankRequest(
      stationId: json['stationId'] as String,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$RentPowerBankRequestToJson(RentPowerBankRequest instance) =>
    <String, dynamic>{
      'stationId': instance.stationId,
      'deviceId': instance.deviceId,
    };

RentPowerBankResponse _$RentPowerBankResponseFromJson(Map<String, dynamic> json) =>
    RentPowerBankResponse(
      rentalId: json['rentalId'] as String?,
      message: json['message'] as String?,
      success: json['success'] as bool?,
      powerBankId: json['powerBankId'] as String?,
    );

Map<String, dynamic> _$RentPowerBankResponseToJson(RentPowerBankResponse instance) =>
    <String, dynamic>{
      'rentalId': instance.rentalId,
      'message': instance.message,
      'success': instance.success,
      'powerBankId': instance.powerBankId,
    };
