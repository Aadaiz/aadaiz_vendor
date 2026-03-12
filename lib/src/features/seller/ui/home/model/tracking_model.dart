import 'dart:convert';

class TrackingModel {
  bool? status;
  Data? data;
  DeliveryAddress? deliveryAddress;
  String? message;

  TrackingModel({this.status, this.data, this.deliveryAddress, this.message});

  TrackingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    deliveryAddress = json['delivery_address'] != null
        ? new DeliveryAddress.fromJson(json['delivery_address'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.deliveryAddress != null) {
      data['delivery_address'] = this.deliveryAddress!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? orderItemId;
  String? awbCode;
  String? status;
  String? payload;
  PayloadData? payloadData;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.orderItemId,
        this.awbCode,
        this.status,
        this.payload,
        this.payloadData,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    orderItemId = json['order_item_id'];
    awbCode = json['awb_code'];
    status = json['status'];
    payload = json['payload'];
    if (json['payload'] != null) {
      try {
        payloadData = PayloadData.fromJson(jsonDecode(json['payload']));
      } catch (e) {
        print('Error parsing payload: $e');
      }
    }
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_item_id'] = this.orderItemId;
    data['awb_code'] = this.awbCode;
    data['status'] = this.status;
    data['payload'] = this.payload;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class PayloadData {
  TrackingData? trackingData;

  PayloadData({this.trackingData});

  PayloadData.fromJson(Map<String, dynamic> json) {
    trackingData = json['tracking_data'] != null
        ? new TrackingData.fromJson(json['tracking_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.trackingData != null) {
      data['tracking_data'] = this.trackingData!.toJson();
    }
    return data;
  }
}

class TrackingData {
  int? trackStatus;
  int? shipmentStatus;
  List<ShipmentTrack>? shipmentTrack;
  dynamic shipmentTrackActivities;
  String? trackUrl;
  String? etd;
  String? qcResponse;
  bool? isReturn;
  String? orderTag;

  TrackingData(
      {this.trackStatus,
        this.shipmentStatus,
        this.shipmentTrack,
        this.shipmentTrackActivities,
        this.trackUrl,
        this.etd,
        this.qcResponse,
        this.isReturn,
        this.orderTag});

  TrackingData.fromJson(Map<String, dynamic> json) {
    trackStatus = json['track_status'];
    shipmentStatus = json['shipment_status'];
    if (json['shipment_track'] != null) {
      shipmentTrack = <ShipmentTrack>[];
      json['shipment_track'].forEach((v) {
        shipmentTrack!.add(new ShipmentTrack.fromJson(v));
      });
    }
    shipmentTrackActivities = json['shipment_track_activities'];
    trackUrl = json['track_url'];
    etd = json['etd'];
    qcResponse = json['qc_response'];
    isReturn = json['is_return'];
    orderTag = json['order_tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['track_status'] = this.trackStatus;
    data['shipment_status'] = this.shipmentStatus;
    if (this.shipmentTrack != null) {
      data['shipment_track'] =
          this.shipmentTrack!.map((v) => v.toJson()).toList();
    }
    data['shipment_track_activities'] = this.shipmentTrackActivities;
    data['track_url'] = this.trackUrl;
    data['etd'] = this.etd;
    data['qc_response'] = this.qcResponse;
    data['is_return'] = this.isReturn;
    data['order_tag'] = this.orderTag;
    return data;
  }
}

class ShipmentTrack {
  int? id;
  String? awbCode;
  int? courierCompanyId;
  int? shipmentId;
  int? orderId;
  String? pickupDate;
  String? deliveredDate;
  String? weight;
  int? packages;
  String? currentStatus;
  String? deliveredTo;
  String? destination;
  String? consigneeName;
  String? origin;
  dynamic courierAgentDetails;
  String? courierName;
  String? edd;
  String? pod;
  String? podStatus;
  String? rtoDeliveredDate;
  String? returnAwbCode;
  String? updatedTimeStamp;

  ShipmentTrack(
      {this.id,
        this.awbCode,
        this.courierCompanyId,
        this.shipmentId,
        this.orderId,
        this.pickupDate,
        this.deliveredDate,
        this.weight,
        this.packages,
        this.currentStatus,
        this.deliveredTo,
        this.destination,
        this.consigneeName,
        this.origin,
        this.courierAgentDetails,
        this.courierName,
        this.edd,
        this.pod,
        this.podStatus,
        this.rtoDeliveredDate,
        this.returnAwbCode,
        this.updatedTimeStamp});

  ShipmentTrack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    awbCode = json['awb_code'];
    courierCompanyId = json['courier_company_id'];
    shipmentId = json['shipment_id'];
    orderId = json['order_id'];
    pickupDate = json['pickup_date'];
    deliveredDate = json['delivered_date'];
    weight = json['weight'];
    packages = json['packages'];
    currentStatus = json['current_status'];
    deliveredTo = json['delivered_to'];
    destination = json['destination'];
    consigneeName = json['consignee_name'];
    origin = json['origin'];
    courierAgentDetails = json['courier_agent_details'];
    courierName = json['courier_name'];
    edd = json['edd'];
    pod = json['pod'];
    podStatus = json['pod_status'];
    rtoDeliveredDate = json['rto_delivered_date'];
    returnAwbCode = json['return_awb_code'];
    updatedTimeStamp = json['updated_time_stamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['awb_code'] = this.awbCode;
    data['courier_company_id'] = this.courierCompanyId;
    data['shipment_id'] = this.shipmentId;
    data['order_id'] = this.orderId;
    data['pickup_date'] = this.pickupDate;
    data['delivered_date'] = this.deliveredDate;
    data['weight'] = this.weight;
    data['packages'] = this.packages;
    data['current_status'] = this.currentStatus;
    data['delivered_to'] = this.deliveredTo;
    data['destination'] = this.destination;
    data['consignee_name'] = this.consigneeName;
    data['origin'] = this.origin;
    data['courier_agent_details'] = this.courierAgentDetails;
    data['courier_name'] = this.courierName;
    data['edd'] = this.edd;
    data['pod'] = this.pod;
    data['pod_status'] = this.podStatus;
    data['rto_delivered_date'] = this.rtoDeliveredDate;
    data['return_awb_code'] = this.returnAwbCode;
    data['updated_time_stamp'] = this.updatedTimeStamp;
    return data;
  }
}

class DeliveryAddress {
  int? id;
  String? name;
  int? userId;
  Null? sellerId;
  Null? tailorId;
  String? address;
  String? landmark;
  String? city;
  String? state;
  String? country;
  int? pincode;
  String? mobile;
  Null? role;
  int? isDefault;
  String? createdAt;
  String? updatedAt;

  DeliveryAddress(
      {this.id,
        this.name,
        this.userId,
        this.sellerId,
        this.tailorId,
        this.address,
        this.landmark,
        this.city,
        this.state,
        this.country,
        this.pincode,
        this.mobile,
        this.role,
        this.isDefault,
        this.createdAt,
        this.updatedAt});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    sellerId = json['seller_id'];
    tailorId = json['tailor_id'];
    address = json['address'];
    landmark = json['landmark'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    mobile = json['mobile'];
    role = json['role'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['seller_id'] = this.sellerId;
    data['tailor_id'] = this.tailorId;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['mobile'] = this.mobile;
    data['role'] = this.role;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}