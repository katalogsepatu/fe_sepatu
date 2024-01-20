import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tugas_besar/Models/katalog_sepatu.dart';
import 'package:tugas_besar/Models/login_model.dart';
import 'package:tugas_besar/Models/signup_model.dart';
import 'package:tugas_besar/Models/Product/product.dart';

class ApiServices {
  final Dio dio = Dio();
  final String _baseUrl =
      'https://asia-southeast2-keamanansistem.cloudfunctions.net';

  Future<LoginResponse?> login(LoginInput login) async {
    try {
      final response = await dio.post(
        '$_baseUrl/login-sepatu',
        data: login.toJson(),
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(json.decode(response.data));
      }
      return null;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != 200) {
        debugPrint('Client error - the request cannot be fulfilled');
        return LoginResponse.fromJson(e.response!.data);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<SignUpResponse?> signup(SignUpInput signup) async {
    try {
      final response = await dio.post(
        '$_baseUrl/register-sepatu',
        data: signup.toJson(),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic>) {
          return SignUpResponse.fromJson(responseData);
        } else if (responseData is String) {
          // If the response is a string, parse it as JSON
          final parsedData = json.decode(responseData);
          return SignUpResponse.fromJson(parsedData);
        }

        return null;
      }
      return null;
    } on DioException catch (e) {
      // Handle DioError
      rethrow;
    } catch (e) {
      // Handle other exceptions
      rethrow;
    }
  }

  Future<Iterable<KatalogSepatuModel>?> getAllKatalogSepatu() async {
    try {
      var response = await dio.get('$_baseUrl/katalogsepatu');
      if (response.statusCode == 200) {
        final contactList = (response.data['data'] as List)
            .map((contact) => KatalogSepatuModel.fromJson(contact))
            .toList();
        return contactList;
      }
      return null;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != 200) {
        debugPrint('Client error - the request cannot be fulfilled');
        return null;
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Future<KatalogSepatuModel?> getSingleKatalogSepatu(String id) async {
  //   try {
  //     var response = await dio.get('$_baseUrl/katalogsepatu/$id');
  //     if (response.statusCode == 200) {
  //       final data = response.data;
  //       return KatalogSepatuModel.fromJson(data);
  //     }
  //     return null;
  //   } on DioException catch (e) {
  //     if (e.response != null && e.response!.statusCode != 200) {
  //       debugPrint('Client error - the request cannot be fulfilled');
  //       return null;
  //     }
  //     rethrow;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<KatalogSepatuResponse?> postKatalogSepatu(
      KatalogSepatuInput ct) async {
    try {
      final response = await dio.post(
        '$_baseUrl/insert/katalog-sepatu',
        data: ct.toJson(),
      );
      if (response.statusCode == 200) {
        return KatalogSepatuResponse.fromJson(response.data);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<KatalogSepatuResponse?> putKatalogSepatu(
      String id, Map<String, dynamic> params) async {
    try {
      final response = await Dio().put(
        '$_baseUrl/update/katalog-sepatu/$id',
        data: params,
      );

      if (response.statusCode == 200) {
        return KatalogSepatuResponse.fromJson(response.data);
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteKatalogSepatu(String id) async {
    try {
      final response = await Dio().delete('$_baseUrl/katalog-sepatu/$id');
      if (response.statusCode == 200) {
        return KatalogSepatuResponse.fromJson(response.data);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<KatalogSepatuResponse?> saveKatalogSepatu(
      KatalogSepatuInput ct) async {
    try {
      final response = await dio.post(
        '$_baseUrl/save', // Replace 'save' with the appropriate endpoint
        data: ct.toJson(),
      );
      if (response.statusCode == 200) {
        return KatalogSepatuResponse.fromJson(response.data);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
