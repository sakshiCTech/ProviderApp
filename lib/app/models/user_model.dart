import 'package:home_services_provider/app/models/parents/model.dart';

class User {
  int id;
  String firstName;
  String lastName;
  String agentId;
  String email;
  String gender;
  String geoFencingId;
  double latitude;
  double longitude;
  String address;
  int otp;
  int commissionPercentage;
  String language;
  String avatar;
  String countryCode;
  String mobile;
  String password;
  String blocked;
  String verified;
  String status;
  String stripeAccId;
  String stripeCustId;
  String paypalEmail;
  String loginBy;
  String socialUniqueId;
  int walletBalance;
  String referralUniqueId;
  String qrcodeUrl;
  String deletedAt;
  String rememberToken;
  String createdAt;
  String updatedAt;
  String accessToken;
  String currency;
  String sos;
  String measurement;
  Services services;
  int rating;
  List<Service> service;
  Device device;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.agentId,
      this.email,
      this.gender,
      this.geoFencingId,
      this.latitude,
      this.longitude,
      this.address,
      this.otp,
      this.commissionPercentage,
      this.language,
      this.avatar,
      this.countryCode,
      this.mobile,
      this.password,
      this.blocked,
      this.verified,
      this.status,
      this.stripeAccId,
      this.stripeCustId,
      this.paypalEmail,
      this.loginBy,
      this.socialUniqueId,
      this.walletBalance,
      this.referralUniqueId,
      this.qrcodeUrl,
      this.deletedAt,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.accessToken,
      this.currency,
      this.sos,
      this.measurement,
      this.services,
      this.rating,
      this.service,
      this.device});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    agentId = json['agent_id'];
    email = json['email'];
    gender = json['gender'];
    geoFencingId = json['geo_fencing_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    otp = json['otp'];
    commissionPercentage = json['commission_percentage'];
    language = json['language'];
    avatar = json['avatar'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    password = json['password'];
    blocked = json['blocked'];
    verified = json['verified'];
    status = json['status'];
    stripeAccId = json['stripe_acc_id'];
    stripeCustId = json['stripe_cust_id'];
    paypalEmail = json['paypal_email'];
    loginBy = json['login_by'];
    socialUniqueId = json['social_unique_id'];
    walletBalance = json['wallet_balance'];
    referralUniqueId = json['referral_unique_id'];
    qrcodeUrl = json['qrcode_url'];
    deletedAt = json['deleted_at'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    accessToken = json['access_token'];
    currency = json['currency'];
    sos = json['sos'];
    measurement = json['measurement'];
    services = json['services'] != null
        ? new Services.fromJson(json['services'])
        : null;
    rating = json['rating'];
    if (json['service'] != null) {
      service = new List<Service>();
      json['service'].forEach((v) {
        service.add(new Service.fromJson(v));
      });
    }
    device =
        json['device'] != null ? new Device.fromJson(json['device']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['agent_id'] = this.agentId;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['geo_fencing_id'] = this.geoFencingId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['otp'] = this.otp;
    data['commission_percentage'] = this.commissionPercentage;
    data['language'] = this.language;
    data['avatar'] = this.avatar;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['blocked'] = this.blocked;
    data['verified'] = this.verified;
    data['status'] = this.status;
    data['stripe_acc_id'] = this.stripeAccId;
    data['stripe_cust_id'] = this.stripeCustId;
    data['paypal_email'] = this.paypalEmail;
    data['login_by'] = this.loginBy;
    data['social_unique_id'] = this.socialUniqueId;
    data['wallet_balance'] = this.walletBalance;
    data['referral_unique_id'] = this.referralUniqueId;
    data['qrcode_url'] = this.qrcodeUrl;
    data['deleted_at'] = this.deletedAt;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['access_token'] = this.accessToken;
    data['currency'] = this.currency;
    data['sos'] = this.sos;
    data['measurement'] = this.measurement;
    if (this.services != null) {
      data['services'] = this.services.toJson();
    }
    data['rating'] = this.rating;
    if (this.service != null) {
      data['service'] = this.service.map((v) => v.toJson()).toList();
    }
    if (this.device != null) {
      data['device'] = this.device.toJson();
    }
    return data;
  }
}

class Services {
  String name;
  String serviceNumber;
  String serviceModel;

  Services({this.name, this.serviceNumber, this.serviceModel});

  Services.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    serviceNumber = json['service_number'];
    serviceModel = json['service_model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['service_number'] = this.serviceNumber;
    data['service_model'] = this.serviceModel;
    return data;
  }
}

class Service {
  int id;
  int providerId;
  int serviceTypeId;
  String status;
  String serviceNumber;
  String serviceModel;
  String serviceType;

  Service(
      {this.id,
      this.providerId,
      this.serviceTypeId,
      this.status,
      this.serviceNumber,
      this.serviceModel,
      this.serviceType});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    serviceTypeId = json['service_type_id'];
    status = json['status'];
    serviceNumber = json['service_number'];
    serviceModel = json['service_model'];
    serviceType = json['service_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['service_type_id'] = this.serviceTypeId;
    data['status'] = this.status;
    data['service_number'] = this.serviceNumber;
    data['service_model'] = this.serviceModel;
    data['service_type'] = this.serviceType;
    return data;
  }
}

class Device {
  int id;
  int providerId;
  String udid;
  String token;
  String snsArn;
  String type;
  String jwtToken;

  Device(
      {this.id,
      this.providerId,
      this.udid,
      this.token,
      this.snsArn,
      this.type,
      this.jwtToken});

  Device.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    udid = json['udid'];
    token = json['token'];
    snsArn = json['sns_arn'];
    type = json['type'];
    jwtToken = json['jwt_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['udid'] = this.udid;
    data['token'] = this.token;
    data['sns_arn'] = this.snsArn;
    data['type'] = this.type;
    data['jwt_token'] = this.jwtToken;
    return data;
  }
}
