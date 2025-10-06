// import 'dart:developer';
//
// import 'package:wedplan/core/utils/formatter.dart';
// import 'package:wedplan/features/auth/data/dto.dart';
// import 'package:wedplan/features/auth/data/repository.dart';
//
// import 'model.dart';
//
// class AuthService {
//   final repo = AuthRepository();
//   final formatter = Formatter();
//
//   Future<User> login({required LoginDTO loginDto}) async {
//     try {
//       final user = await repo.read(email: loginDto.email);
//       if (user == null) {
//         throw Exception("No user exists");
//       }
//       final valid = user.password == loginDto.password;
//       if (valid) {
//         await repo.setId(id: user.id);
//         return user;
//       } else {
//         throw Exception("Invalid credentials");
//       }
//     } catch (e) {
//       log("LOGIN ERROR: $e");
//       throw Exception(e);
//     }
//   }
//
//   Future<User> register({required LoginDTO loginDto}) async {
//     try {
//       final user = await repo.read(email: loginDto.email);
//       if (user != null) {
//         throw Exception("User already exists");
//       }
//       final td = DateTime.now();
//       final id = formatter.generateId(value: loginDto.email);
//       final name = formatter.generateName(value: loginDto.email);
//       final username = formatter.generateUsername(value: loginDto.email);
//       final created = await repo.create(
//         user: User(
//           id: id,
//           name: name,
//           username: username,
//           email: loginDto.email,
//           password: loginDto.password,
//           createdAt: td,
//         ),
//       );
//       await repo.setId(id: created.id);
//       return created;
//     } catch (e) {
//       log("LOGIN ERROR: $e");
//       throw Exception(e);
//     }
//   }
//
//   Future<User> getUserById({required String id}) async {
//     try {
//       final user = await repo.read(id: id);
//       if (user != null) {
//         return user;
//       } else {
//         throw Exception("User don't exists");
//       }
//     } catch (e) {
//       throw Exception("User don't exists");
//     }
//   }
// }
