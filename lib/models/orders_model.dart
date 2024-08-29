class OrdersResponse {
  final List<OrderData> data;
  final Meta meta;

  OrdersResponse({required this.data, required this.meta});

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    return OrdersResponse(
      data: (json['data'] as List).map((i) => OrderData.fromJson(i)).toList(),
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((order) => order.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

class OrderData {
  final int id;
  final OrderAttributes attributes;

  OrderData({required this.id, required this.attributes});

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'],
      attributes: OrderAttributes.fromJson(json['attributes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attributes': attributes.toJson(),
    };
  }
}

class OrderAttributes {
  final int discount;
  final double totalPrice;
  final String currency;
  final String orderStatus;
  final String? uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;

  OrderAttributes({
    required this.discount,
    required this.totalPrice,
    required this.currency,
    required this.orderStatus,
    this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  factory OrderAttributes.fromJson(Map<String, dynamic> json) {
    return OrderAttributes(
      discount: json['Discount'] ?? 0,
      totalPrice: (json['TotalPrice'] ?? 0.0).toDouble(),
      currency: json['Currency'] ?? '',
      orderStatus: json['OrderStatus'] ?? '',
      uuid: json['uuid'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      publishedAt: DateTime.parse(json['publishedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Discount': discount,
      'TotalPrice': totalPrice,
      'Currency': currency,
      'OrderStatus': orderStatus,
      'uuid': uuid,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'publishedAt': publishedAt.toIso8601String(),
    };
  }
}

class Meta {
  final Pagination pagination;

  Meta({required this.pagination});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      pagination: Pagination.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pagination': pagination.toJson(),
    };
  }
}

class Pagination {
  final int page;
  final int pageSize;
  final int pageCount;
  final int total;

  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      pageSize: json['pageSize'],
      pageCount: json['pageCount'],
      total: json['total'],
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
