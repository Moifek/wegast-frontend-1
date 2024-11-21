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
    final attributes = json['attributes'] ?? json;
    return UserModel(
      id: attributes['id'] as int?,
      username: attributes['username'],
      email: attributes['email'],
      provider: attributes['provider'],
      confirmed: attributes['confirmed'],
      blocked: attributes['blocked'],
      phoneNumber: attributes['PhoneNumber'] as int?,
      createdAt: attributes['createdAt'] != null
          ? DateTime.tryParse(attributes['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(attributes['updatedAt'])
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
