import 'package:store_mobile/domain/models/product.dart';

class Helper {
  static Product findProductAtList(List<Product> list, Product object) {
    final index = list.indexWhere((element) => element.id == object.id);
    if (index != -1) {
      return list[index];
    }
    return object;
  }

  static String? emailValidation(String? email) {
    RegExp regex =
    RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+(\.[a-zA-Z]+)?$');
    if (!regex.hasMatch(email!) || email.isEmpty) {
      return 'Email tidak valid';
    }
    return null;
  }

  static String? passwordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password Tidak Boleh Kosong';
    }
    if (password.length < 8) {
      return 'Password Minimal 8 karakter';
    }
    return null;
  }

  static String? nameValidation(String? name) {
    if (name == null || name.isEmpty) {
      return 'Nama Tidak Boleh Kosong';
    }
    if (name.length < 3) {
      return 'Nama Minimal 3 Karakter';
    }
    return null;
  }

  static String? streetValidation(String? street) {
    if (street == null || street.isEmpty) {
      return 'Nama Tidak Boleh Kosong';
    }
    return null;
  }

  static String? phoneValidation(String? phone) {
    RegExp regex = RegExp(r'^08\d{8,12}$');
    if (phone == null || phone.isEmpty) {
      return 'Telepon Tidak Boleh Kosong';
    }
    if (!regex.hasMatch(phone)) {
      return 'Telepon Tidak Valid';
    }
    return null;
  }
}