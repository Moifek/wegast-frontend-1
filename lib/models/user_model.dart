import 'package:wegast/models/orders_model.dart';

class UserModel {
  final int? id;
  final String? username;
  final String? email;
  final String? provider;
  final bool? confirmed;
  final bool? blocked;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? phoneNumber;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.createdAt,
    this.updatedAt,
    this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      provider: json['provider'] as String?,
      confirmed: json['confirmed'] as bool?,
      blocked: json['blocked'] as bool?,
      phoneNumber: json['PhoneNumber'] as int?,
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
      'id': id,
      'username': username,
      'email': email,
      'provider': provider,
      'confirmed': confirmed,
      'blocked': blocked,
      'PhoneNumber': phoneNumber,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class UserFullModel {
  final int? id;
  final String? username;
  final String? email;
  final String? provider;
  final bool? confirmed;
  final bool? blocked;
  final String? appRole;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? phoneNumber;
  final Role? role;
  final DasherProfile? dasherProfile;
  final int? dasherRating;
  final Adress? adress;
  final List<dynamic>? orders;

  UserFullModel({
    this.id,
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.appRole,
    this.createdAt,
    this.updatedAt,
    this.phoneNumber,
    this.role,
    this.dasherProfile,
    this.dasherRating,
    this.adress,
    this.orders,
  });

  factory UserFullModel.fromJson(Map<String, dynamic> json) {
    return UserFullModel(
      id: json['id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      provider: json['provider'] as String?,
      confirmed: json['confirmed'] as bool?,
      blocked: json['blocked'] as bool?,
      appRole: json['AppRole'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      phoneNumber: json['PhoneNumber'] as int?, // Removed colon
      role: json['role'] != null ? Role.fromJson(json['role']) : null,
      dasherProfile: json['dasher_profile'] != null
          ? DasherProfile.fromJson(json['dasher_profile'])
          : null, // Removed colon
      dasherRating: json['dasher_rating'], // Handles null
      adress: json['adress'] != null ? Adress.fromJson(json['adress']) : null,
      orders:
          json['orders'] != null ? List<dynamic>.from(json['orders']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'provider': provider,
      'confirmed': confirmed,
      'blocked': blocked,
      'appRole': appRole,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'phoneNumber': phoneNumber,
      'role': role?.toJson(),
      'dasherProfile': dasherProfile?.toJson(),
      'dasherRating': dasherRating,
      'adress': adress?.toJson(),
      'orders': orders,
    };
  }
}

class Adress {
  final int? id;
  final String? streetAdress;
  final int? latitude;
  final int? longtitude;
  final String? areaCode;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;

  Adress({
    this.id,
    this.streetAdress,
    this.latitude,
    this.longtitude,
    this.areaCode,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
  });

  factory Adress.fromJson(Map<String, dynamic> json) {
    return Adress(
      id: json['id'] as int?,
      streetAdress: json['streetAdress'] as String?,
      latitude: json['Latitude'] ?? 0,
      longtitude: json['Longtitude'] ?? 0,
      areaCode: json['areaCode'] as String?,
      type: json['type'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'streetAdress': streetAdress,
      'latitude': latitude,
      'longtitude': longtitude,
      'areaCode': areaCode,
      'type': type,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'publishedAt': publishedAt?.toIso8601String(),
    };
  }
}

class DasherProfile {
  final int? id;
  final String? displayName;
  final int? distanceTraveled;
  final int? payPerDistance;
  final bool? isActive;
  final int? balance;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;

  DasherProfile({
    this.id,
    this.displayName,
    this.distanceTraveled,
    this.payPerDistance,
    this.isActive,
    this.balance,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
  });

  factory DasherProfile.fromJson(Map<String, dynamic> json) {
    return DasherProfile(
      id: json['id'] as int?,
      displayName: json['displayName'] as String?,
      distanceTraveled: json['distanceTraveled'] as int?,
      payPerDistance: json['payPerDistance'] as int?,
      isActive: json['isActive'] as bool?,
      balance: json['balance'] as int?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'distanceTraveled': distanceTraveled,
      'payPerDistance': payPerDistance,
      'isActive': isActive,
      'balance': balance,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'publishedAt': publishedAt?.toIso8601String(),
    };
  }
}

class Role {
  final int? id;
  final String? name;
  final String? description;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Role({
    this.id,
    this.name,
    this.description,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
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
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
