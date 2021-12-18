class HistoryModel {
  int id;
  String bookingId;
  int userId;
  String braintreeNonce;
  int providerId;
  int currentProviderId;
  int serviceTypeId;
  int promocodeId;
  int price;
  String invoiceItem;
  String geoTime;
  String beforeImage;
  String beforeComment;
  String afterImage;
  String afterComment;
  String driverAcceptTime;
  String driverReachedTime;
  String arrivalEstimateTime;
  int etaDiscount;
  String status;
  String serviceRequired;
  String cancelledBy;
  String cancelReason;
  String nightFare;
  String paymentMode;
  int paid;
  String isTrack;
  int estimatedFare;
  int distance;
  String travelTime;
  String unit;
  String otp;
  int geoFencingDistance;
  int geoFencingId;
  String sAddress;
  double sLatitude;
  double sLongitude;
  String dAddress;
  double dLatitude;
  double dLongitude;
  int trackDistance;
  int trackLatitude;
  int trackLongitude;
  String destinationLog;
  int isDropLocation;
  int isInstantRide;
  int isDispute;
  String assignedAt;
  String scheduleAt;
  String startedAt;
  String finishedAt;
  String isScheduled;
  int userRated;
  int providerRated;
  int useWallet;
  int surge;
  String routeKey;
  String nonce;
  String broadcast;
  String invoiceEmail;
  String rideOption;
  String type;
  String deletedAt;
  String createdAt;
  String updatedAt;
  String staticMap;
  Payment payment;
  ServiceType serviceType;

  HistoryModel(
      {this.id,
        this.bookingId,
        this.userId,
        this.braintreeNonce,
        this.providerId,
        this.currentProviderId,
        this.serviceTypeId,
        this.promocodeId,
        this.price,
        this.invoiceItem,
        this.geoTime,
        this.beforeImage,
        this.beforeComment,
        this.afterImage,
        this.afterComment,
        this.driverAcceptTime,
        this.driverReachedTime,
        this.arrivalEstimateTime,
        this.etaDiscount,
        this.status,
        this.serviceRequired,
        this.cancelledBy,
        this.cancelReason,
        this.nightFare,
        this.paymentMode,
        this.paid,
        this.isTrack,
        this.estimatedFare,
        this.distance,
        this.travelTime,
        this.unit,
        this.otp,
        this.geoFencingDistance,
        this.geoFencingId,
        this.sAddress,
        this.sLatitude,
        this.sLongitude,
        this.dAddress,
        this.dLatitude,
        this.dLongitude,
        this.trackDistance,
        this.trackLatitude,
        this.trackLongitude,
        this.destinationLog,
        this.isDropLocation,
        this.isInstantRide,
        this.isDispute,
        this.assignedAt,
        this.scheduleAt,
        this.startedAt,
        this.finishedAt,
        this.isScheduled,
        this.userRated,
        this.providerRated,
        this.useWallet,
        this.surge,
        this.routeKey,
        this.nonce,
        this.broadcast,
        this.invoiceEmail,
        this.rideOption,
        this.type,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.staticMap,
        this.payment,
        this.serviceType});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    userId = json['user_id'];
    braintreeNonce = json['braintree_nonce'];
    providerId = json['provider_id'];
    currentProviderId = json['current_provider_id'];
    serviceTypeId = json['service_type_id'];
    promocodeId = json['promocode_id'];
    price = json['price'];
    invoiceItem = json['invoice_item'];
    geoTime = json['geo_time'];
    beforeImage = json['before_image'];
    beforeComment = json['before_comment'];
    afterImage = json['after_image'];
    afterComment = json['after_comment'];
    driverAcceptTime = json['driver_accept_time'];
    driverReachedTime = json['driver_reached_time'];
    arrivalEstimateTime = json['arrival_estimate_time'];
    etaDiscount = json['eta_discount'];
    status = json['status'];
    serviceRequired = json['service_required'];
    cancelledBy = json['cancelled_by'];
    cancelReason = json['cancel_reason'];
    nightFare = json['night_fare'];
    paymentMode = json['payment_mode'];
    paid = json['paid'];
    isTrack = json['is_track'];
    estimatedFare = json['estimated_fare'];
    distance = json['distance'];
    travelTime = json['travel_time'];
    unit = json['unit'];
    otp = json['otp'];
    geoFencingDistance = json['geo_fencing_distance'];
    geoFencingId = json['geo_fencing_id'];
    sAddress = json['s_address'];
    sLatitude = json['s_latitude'];
    sLongitude = json['s_longitude'];
    dAddress = json['d_address'];
    dLatitude = json['d_latitude'];
    dLongitude = json['d_longitude'];
    trackDistance = json['track_distance'];
    trackLatitude = json['track_latitude'];
    trackLongitude = json['track_longitude'];
    destinationLog = json['destination_log'];
    isDropLocation = json['is_drop_location'];
    isInstantRide = json['is_instant_ride'];
    isDispute = json['is_dispute'];
    assignedAt = json['assigned_at'];
    scheduleAt = json['schedule_at'];
    startedAt = json['started_at'];
    finishedAt = json['finished_at'];
    isScheduled = json['is_scheduled'];
    userRated = json['user_rated'];
    providerRated = json['provider_rated'];
    useWallet = json['use_wallet'];
    surge = json['surge'];
    routeKey = json['route_key'];
    nonce = json['nonce'];
    broadcast = json['broadcast'];
    invoiceEmail = json['invoice_email'];
    rideOption = json['ride_option'];
    type = json['type'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    staticMap = json['static_map'];
    payment =
    json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    serviceType = json['service_type'] != null
        ? new ServiceType.fromJson(json['service_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['user_id'] = this.userId;
    data['braintree_nonce'] = this.braintreeNonce;
    data['provider_id'] = this.providerId;
    data['current_provider_id'] = this.currentProviderId;
    data['service_type_id'] = this.serviceTypeId;
    data['promocode_id'] = this.promocodeId;
    data['price'] = this.price;
    data['invoice_item'] = this.invoiceItem;
    data['geo_time'] = this.geoTime;
    data['before_image'] = this.beforeImage;
    data['before_comment'] = this.beforeComment;
    data['after_image'] = this.afterImage;
    data['after_comment'] = this.afterComment;
    data['driver_accept_time'] = this.driverAcceptTime;
    data['driver_reached_time'] = this.driverReachedTime;
    data['arrival_estimate_time'] = this.arrivalEstimateTime;
    data['eta_discount'] = this.etaDiscount;
    data['status'] = this.status;
    data['service_required'] = this.serviceRequired;
    data['cancelled_by'] = this.cancelledBy;
    data['cancel_reason'] = this.cancelReason;
    data['night_fare'] = this.nightFare;
    data['payment_mode'] = this.paymentMode;
    data['paid'] = this.paid;
    data['is_track'] = this.isTrack;
    data['estimated_fare'] = this.estimatedFare;
    data['distance'] = this.distance;
    data['travel_time'] = this.travelTime;
    data['unit'] = this.unit;
    data['otp'] = this.otp;
    data['geo_fencing_distance'] = this.geoFencingDistance;
    data['geo_fencing_id'] = this.geoFencingId;
    data['s_address'] = this.sAddress;
    data['s_latitude'] = this.sLatitude;
    data['s_longitude'] = this.sLongitude;
    data['d_address'] = this.dAddress;
    data['d_latitude'] = this.dLatitude;
    data['d_longitude'] = this.dLongitude;
    data['track_distance'] = this.trackDistance;
    data['track_latitude'] = this.trackLatitude;
    data['track_longitude'] = this.trackLongitude;
    data['destination_log'] = this.destinationLog;
    data['is_drop_location'] = this.isDropLocation;
    data['is_instant_ride'] = this.isInstantRide;
    data['is_dispute'] = this.isDispute;
    data['assigned_at'] = this.assignedAt;
    data['schedule_at'] = this.scheduleAt;
    data['started_at'] = this.startedAt;
    data['finished_at'] = this.finishedAt;
    data['is_scheduled'] = this.isScheduled;
    data['user_rated'] = this.userRated;
    data['provider_rated'] = this.providerRated;
    data['use_wallet'] = this.useWallet;
    data['surge'] = this.surge;
    data['route_key'] = this.routeKey;
    data['nonce'] = this.nonce;
    data['broadcast'] = this.broadcast;
    data['invoice_email'] = this.invoiceEmail;
    data['ride_option'] = this.rideOption;
    data['type'] = this.type;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['static_map'] = this.staticMap;
    if (this.payment != null) {
      data['payment'] = this.payment.toJson();
    }
    if (this.serviceType != null) {
      data['service_type'] = this.serviceType.toJson();
    }
    return data;
  }
}

class Payment {
  int id;
  int requestId;
  int userId;
  int providerId;
  String agentId;
  String promocodeId;
  String paymentId;
  String paymentMode;
  int fixed;
  int distance;
  int minute;
  int geoFencingMinute;
  int nonGeoFencingMinute;
  int hour;
  int peakPrice;
  int driverBeta;
  int commision;
  int commisionPer;
  int agent;
  int agentPer;
  int discount;
  int discountPer;
  int tax;
  int taxPer;
  int wallet;
  int isPartial;
  int cash;
  int card;
  int online;
  int surge;
  int geoFencingTotal;
  int noneGeoFencingTotal;
  int tollCharge;
  int roundOf;
  int peakAmount;
  int peakCommAmount;
  int totalWaitingTime;
  int waitingAmount;
  int waitingCommAmount;
  int tips;
  int total;
  int payable;
  int nightFare;
  int percentage;
  int providerCommission;
  int providerPay;
  int returnTravelFare;
  int etaDiscount;
  int nonGeoPrice;

  Payment(
      {this.id,
        this.requestId,
        this.userId,
        this.providerId,
        this.agentId,
        this.promocodeId,
        this.paymentId,
        this.paymentMode,
        this.fixed,
        this.distance,
        this.minute,
        this.geoFencingMinute,
        this.nonGeoFencingMinute,
        this.hour,
        this.peakPrice,
        this.driverBeta,
        this.commision,
        this.commisionPer,
        this.agent,
        this.agentPer,
        this.discount,
        this.discountPer,
        this.tax,
        this.taxPer,
        this.wallet,
        this.isPartial,
        this.cash,
        this.card,
        this.online,
        this.surge,
        this.geoFencingTotal,
        this.noneGeoFencingTotal,
        this.tollCharge,
        this.roundOf,
        this.peakAmount,
        this.peakCommAmount,
        this.totalWaitingTime,
        this.waitingAmount,
        this.waitingCommAmount,
        this.tips,
        this.total,
        this.payable,
        this.nightFare,
        this.percentage,
        this.providerCommission,
        this.providerPay,
        this.returnTravelFare,
        this.etaDiscount,
        this.nonGeoPrice});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    userId = json['user_id'];
    providerId = json['provider_id'];
    agentId = json['agent_id'];
    promocodeId = json['promocode_id'];
    paymentId = json['payment_id'];
    paymentMode = json['payment_mode'];
    fixed = json['fixed'];
    distance = json['distance'];
    minute = json['minute'];
    geoFencingMinute = json['geo_fencing_minute'];
    nonGeoFencingMinute = json['non_geo_fencing_minute'];
    hour = json['hour'];
    peakPrice = json['peak_price'];
    driverBeta = json['driver_beta'];
    commision = json['commision'];
    commisionPer = json['commision_per'];
    agent = json['agent'];
    agentPer = json['agent_per'];
    discount = json['discount'];
    discountPer = json['discount_per'];
    tax = json['tax'];
    taxPer = json['tax_per'];
    wallet = json['wallet'];
    isPartial = json['is_partial'];
    cash = json['cash'];
    card = json['card'];
    online = json['online'];
    surge = json['surge'];
    geoFencingTotal = json['geo_fencing_total'];
    noneGeoFencingTotal = json['none_geo_fencing_total'];
    tollCharge = json['toll_charge'];
    roundOf = json['round_of'];
    peakAmount = json['peak_amount'];
    peakCommAmount = json['peak_comm_amount'];
    totalWaitingTime = json['total_waiting_time'];
    waitingAmount = json['waiting_amount'];
    waitingCommAmount = json['waiting_comm_amount'];
    tips = json['tips'];
    total = json['total'];
    payable = json['payable'];
    nightFare = json['night_fare'];
    percentage = json['percentage'];
    providerCommission = json['provider_commission'];
    providerPay = json['provider_pay'];
    returnTravelFare = json['return_travel_fare'];
    etaDiscount = json['eta_discount'];
    nonGeoPrice = json['non_geo_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['request_id'] = this.requestId;
    data['user_id'] = this.userId;
    data['provider_id'] = this.providerId;
    data['agent_id'] = this.agentId;
    data['promocode_id'] = this.promocodeId;
    data['payment_id'] = this.paymentId;
    data['payment_mode'] = this.paymentMode;
    data['fixed'] = this.fixed;
    data['distance'] = this.distance;
    data['minute'] = this.minute;
    data['geo_fencing_minute'] = this.geoFencingMinute;
    data['non_geo_fencing_minute'] = this.nonGeoFencingMinute;
    data['hour'] = this.hour;
    data['peak_price'] = this.peakPrice;
    data['driver_beta'] = this.driverBeta;
    data['commision'] = this.commision;
    data['commision_per'] = this.commisionPer;
    data['agent'] = this.agent;
    data['agent_per'] = this.agentPer;
    data['discount'] = this.discount;
    data['discount_per'] = this.discountPer;
    data['tax'] = this.tax;
    data['tax_per'] = this.taxPer;
    data['wallet'] = this.wallet;
    data['is_partial'] = this.isPartial;
    data['cash'] = this.cash;
    data['card'] = this.card;
    data['online'] = this.online;
    data['surge'] = this.surge;
    data['geo_fencing_total'] = this.geoFencingTotal;
    data['none_geo_fencing_total'] = this.noneGeoFencingTotal;
    data['toll_charge'] = this.tollCharge;
    data['round_of'] = this.roundOf;
    data['peak_amount'] = this.peakAmount;
    data['peak_comm_amount'] = this.peakCommAmount;
    data['total_waiting_time'] = this.totalWaitingTime;
    data['waiting_amount'] = this.waitingAmount;
    data['waiting_comm_amount'] = this.waitingCommAmount;
    data['tips'] = this.tips;
    data['total'] = this.total;
    data['payable'] = this.payable;
    data['night_fare'] = this.nightFare;
    data['percentage'] = this.percentage;
    data['provider_commission'] = this.providerCommission;
    data['provider_pay'] = this.providerPay;
    data['return_travel_fare'] = this.returnTravelFare;
    data['eta_discount'] = this.etaDiscount;
    data['non_geo_price'] = this.nonGeoPrice;
    return data;
  }
}

class ServiceType {
  int id;
  int parentId;
  Name name;
  String image;
  String marker;
  int fixed;
  int price;
  int typePrice;
  String calculator;
  String description;
  int status;
  String deletedAt;
  String createdAt;
  String updatedAt;

  ServiceType(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.marker,
        this.fixed,
        this.price,
        this.typePrice,
        this.calculator,
        this.description,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  ServiceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    image = json['image'];
    marker = json['marker'];
    fixed = json['fixed'];
    price = json['price'];
    typePrice = json['type_price'];
    calculator = json['calculator'];
    description = json['description'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    data['image'] = this.image;
    data['marker'] = this.marker;
    data['fixed'] = this.fixed;
    data['price'] = this.price;
    data['type_price'] = this.typePrice;
    data['calculator'] = this.calculator;
    data['description'] = this.description;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Name {
  String en;

  Name({this.en});

  Name.fromJson(Map<String, dynamic> json) {
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    return data;
  }
}
