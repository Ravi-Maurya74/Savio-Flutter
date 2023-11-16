// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final int id;
  final String name;
  final String email;
  final String city;
  final String? profilePic;
  final double totalBudget;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
    this.profilePic,
    required this.totalBudget,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? city,
    String? profilePic,
    double? totalBudget,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      city: city ?? this.city,
      profilePic: profilePic ?? this.profilePic,
      totalBudget: totalBudget ?? this.totalBudget,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'city': city,
      'profile_pic': profilePic,
      'total_budget': totalBudget.toString(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      city: map['city'] as String,
      profilePic:
          map['profile_pic'] != null ? map['profile_pic'] as String : null,
      totalBudget: double.parse(map['total_budget'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, city: $city, profilePic: $profilePic, totalBudget: $totalBudget)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.city == city &&
        other.profilePic == profilePic &&
        other.totalBudget == totalBudget;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        city.hashCode ^
        profilePic.hashCode ^
        totalBudget.hashCode;
  }
}
