// class User {
//   final String id;
//   final String name;
//   final String username;
//   final String email;
//   final String password;
//   final DateTime createdAt;
//
//   const User({
//     required this.id,
//     required this.name,
//     required this.username,
//     required this.email,
//     required this.password,
//     required this.createdAt,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] as String? ?? '',
//       name: json['name'] as String? ?? '',
//       username: json['username'] as String? ?? '',
//       email: json['email'] as String? ?? '',
//       password: json['password'] as String? ?? '',
//       createdAt: json['createdAt'] != null
//           ? DateTime.parse(json['createdAt'] as String)
//           : DateTime.now(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'username': username,
//       'email': email,
//       'password': password,
//       'createdAt': createdAt.toIso8601String(),
//     };
//   }
//
//   User copyWith({
//     String? id,
//     String? name,
//     String? username,
//     String? email,
//     String? password,
//     DateTime? createdAt,
//   }) {
//     return User(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       username: username ?? this.username,
//       email: email ?? this.email,
//       password: password ?? this.password,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }
// }
