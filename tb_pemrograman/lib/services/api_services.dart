import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tb_pemrograman/models/login_model.dart';
import 'package:tb_pemrograman/Models/katalog_sepatu.dart';

class ApiServices {
  final Dio dio = Dio();
  final String _baseUrl =
      'https://asia-southeast2-keamanansistem.cloudfunctions.net/login-sepatu';

  Future<Iterable<KatalogSepatuModel>?> getAllKatalogSepatu() async {
    try {
      var response = await dio.get('$_baseUrl/contacts');
      if (response.statusCode == 200) {
        final katalogSepatuList = (response.data['data'] as List)
            .map((contact) => KatalogSepatuModel.fromJson(contact))
            .toList();
        return katalogSepatuList;
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

  Future<KatalogSepatuModel?> getSingleContact(String id) async {
    try {
      var response = await dio.get('$_baseUrl/contacts/$id');
      if (response.statusCode == 200) {
        final data = response.data;
        return KatalogSepatuModel.fromJson(data);
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

  Future<KatalogSepatuResponse?> postContact(KatalogSepatuInput ct) async {
    try {
      final response = await dio.post(
        '$_baseUrl/insert',
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

  Future<KatalogSepatuResponse?> putContact(
      String id, KatalogSepatuInput ct) async {
    try {
      final response = await Dio().put(
        '$_baseUrl/update/$id',
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

  Future deleteContact(String id) async {
    try {
      final response = await Dio().delete('$_baseUrl/delete/$id');
      if (response.statusCode == 200) {
        return KatalogSepatuResponse.fromJson(response.data);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse?> login(LoginInput login) async {
    try {
      final response = await dio.post(
        '$_baseUrl/https://asia-southeast2-keamanansistem.cloudfunctions.net/login-sepatu',
        data: login.toJson(),
      );
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
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
}
