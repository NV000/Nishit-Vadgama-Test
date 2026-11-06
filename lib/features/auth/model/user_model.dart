import 'dart:convert';

class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? role;

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        mobile: json['mobile_number'] as String?,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'mobile_number': mobile,
        'role': role,
      };

  String toJsonString() => jsonEncode(toJson());

  factory UserModel.fromJsonString(String jsonString) =>
      UserModel.fromJson(jsonDecode(jsonString));

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? mobile,
    String? role,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        role: role ?? this.role,
      );
}

