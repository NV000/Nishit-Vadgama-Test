import 'dart:convert';

class UserModel {
  final int? id;
  final String? uid;
  final String? name;
  final String? email;
  final String? mobile;
  final String? photoUrl;
  final String? role;

  const UserModel({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.mobile,
    this.photoUrl,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as int?,
        uid: json['uid'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        mobile: json['mobile_number'] as String?,
        photoUrl: json['photo_url'] as String?,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'name': name,
        'email': email,
        'mobile_number': mobile,
        'photo_url': photoUrl,
        'role': role,
      };

  String toJsonString() => jsonEncode(toJson());

  factory UserModel.fromJsonString(String jsonString) =>
      UserModel.fromJson(jsonDecode(jsonString));

  UserModel copyWith({
    int? id,
    String? uid,
    String? name,
    String? email,
    String? mobile,
    String? photoUrl,
    String? role,
  }) =>
      UserModel(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        photoUrl: photoUrl ?? this.photoUrl,
        role: role ?? this.role,
      );
}
