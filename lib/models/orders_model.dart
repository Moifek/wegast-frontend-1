import 'package:wegast/models/restaurant_model.dart';
import 'package:wegast/models/user_model.dart';

class OrdersResponse {
  final List<OrderData>? data;
  final Meta? meta;

  OrdersResponse({this.data, this.meta});

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    return OrdersResponse(
      data: (json['data'] as List?)
          ?.map((i) => OrderData.fromJson(i as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((order) => order.toJson()).toList(),
      'meta': meta?.toJson(),
    };
  }
}

class OrderData {
  final int? id;
  final OrderAttributes? attributes;

  OrderData({this.id, this.attributes});

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'] as int?,
      attributes: json['attributes'] != null
          ? OrderAttributes.fromJson(json['attributes'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attributes': attributes?.toJson(),
    };
  }
}

class OrderItems {
  final int id;
  final int quantity;
  final double price;
  final String? comment;

  OrderItems({
    required this.id,
    required this.quantity,
    required this.price,
    this.comment,
  });

  factory OrderItems.fromJson(Map<String, dynamic> json) {
    return OrderItems(
      id: json['id'] as int,
      quantity: json['Quantity'] as int,
      price: (json['Price'] as num).toDouble(),
      comment: json['Comment'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Quantity': quantity,
      'Price': price,
      'Comment': comment,
    };
  }
}

class OrderAttributes {
  final int? discount;
  final double? totalPrice;
  final String? currency;
  final String? orderStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final Restaurant? restaurant;
  final UserModel? user;
  final DasherProfile? dasherProfile;
  final List<OrderItems>? orderItems;

  OrderAttributes({
    this.discount,
    this.totalPrice,
    this.currency,
    this.orderStatus,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.restaurant,
    this.user,
    this.dasherProfile,
    this.orderItems,
  });

  factory OrderAttributes.fromJson(Map<String, dynamic> json) {
    return OrderAttributes(
      discount: json['Discount'] as int?,
      totalPrice: (json['TotalPrice'] as num?)?.toDouble(),
      currency: json['Currency'] as String?,
      orderStatus: json['OrderStatus'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'])
          : null,
      restaurant: json['restaurant']?['data'] != null
          ? Restaurant.fromJson(json['restaurant']['data'])
          : null,
      user: json['user']?['data'] != null
          ? UserModel.fromJson(json['user']['data'])
          : null,
      dasherProfile: json['dasher_profile']?['data'] != null
          ? DasherProfile.fromJson(json['dasher_profile']['data'])
          : null,
      orderItems: json['OrderItems'] != null
          ? (json['OrderItems'] as List)
              .map((item) => OrderItems.fromJson(item))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Discount': discount,
      'TotalPrice': totalPrice,
      'Currency': currency,
      'OrderStatus': orderStatus,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'publishedAt': publishedAt?.toIso8601String(),
      'restaurant': restaurant?.toJson(),
      'user': user?.toJson(),
      'dasher_profile': dasherProfile?.toJson(),
      'OrderItems': orderItems?.map((item) => item.toJson()).toList(),
    };
  }
}

class DasherProfile {
  final int? id;
  final DasherAttributes? attributes;

  DasherProfile({this.id, this.attributes});

  factory DasherProfile.fromJson(Map<String, dynamic> json) {
    return DasherProfile(
      id: json['id'] as int?,
      attributes: json['attributes'] != null
          ? DasherAttributes.fromJson(
              json['attributes'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attributes': attributes?.toJson(),
    };
  }
}

class DasherAttributes {
  final String? displayName;
  final double? distanceTraveled;
  final double? payPerDistance;
  final bool? isActive;
  final double? balance;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DasherAttributes({
    this.displayName,
    this.distanceTraveled,
    this.payPerDistance,
    this.isActive,
    this.balance,
    this.createdAt,
    this.updatedAt,
  });

  factory DasherAttributes.fromJson(Map<String, dynamic> json) {
    return DasherAttributes(
      displayName: json['DisplayName'] as String?,
      distanceTraveled: (json['DistanceTraveled'] as num?)?.toDouble(),
      payPerDistance: (json['PayPerDistance'] as num?)?.toDouble(),
      isActive: json['IsActive'] as bool?,
      balance: (json['Balance'] as num?)?.toDouble(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DisplayName': displayName,
      'DistanceTraveled': distanceTraveled,
      'PayPerDistance': payPerDistance,
      'IsActive': isActive,
      'Balance': balance,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class Meta {
  final Pagination? pagination;

  Meta({this.pagination});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pagination': pagination?.toJson(),
    };
  }
}

class Pagination {
  final int? page;
  final int? pageSize;
  final int? pageCount;
  final int? total;

  Pagination({
    this.page,
    this.pageSize,
    this.pageCount,
    this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] as int?,
      pageSize: json['pageSize'] as int?,
      pageCount: json['pageCount'] as int?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'pageSize': pageSize,
      'pageCount': pageCount,
      'total': total,
    };
  }
}
