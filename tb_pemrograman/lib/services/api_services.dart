import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tb_pemrograman/models/user_model.dart';
import 'package:tb_pemrograman/models/katalog_sepatu.dart';
import 'package:tb_pemrograman/services/auth_manager.dart';

class ApiServices {
  final Dio dio = Dio();
  final String _baseUrl =
      'https://asia-southeast2-keamanansistem.cloudfunctions.net';

  Future<String?> getToken() async {
    return await AuthManager.getToken();
  }

  Future<List<UserModel>?> getAllUser() async {
    try {
      var response = await dio.get('$_baseUrl/user');
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());

        var datas = json.decode(response.data);

        if (datas['status'] == 200 && datas['data'] != null) {
          final userList = (datas['data'] as List)
              .map((user) => UserModel.fromJson(user))
              .toList();
          return userList;
        } else {
          // Handle case when status is not 200 or 'data' is null
          debugPrint('Invalid response format: $datas');
          return null;
        }
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
      if (e.response != null && e.response!.statusCode != 200) {
        debugPrint('Client error - the request cannot be fulfilled');
        return null;
      }
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
        debugPrint(response.data.toString());

        var datas = json.decode(response.data);

        final katalogsepatuList = (datas['data'] as List)
            .map((katalogsepatu) => KatalogSepatuModel.fromJson(katalogsepatu))
            .toList();
        return katalogsepatuList;
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

  Future<KatalogSepatuModel?> getSingleKatalogSepatu(String id) async {
    try {
      var response = await dio.get('$_baseUrl/katalogsepatu?id=$id');
      if (response.statusCode == 200) {
        debugPrint('respon: ${response.data}');
        final data = json.decode(response.data);
        return KatalogSepatuModel.fromJson(data['data']);
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

  Future<KatalogSepatuResponse?> postKatalogSepatu(
      KatalogSepatuInput katalogsepatu) async {
    try {
      final response = await dio.post('$_baseUrl/katalogsepatu',
          data: katalogsepatu.formData(),
          options: Options(
            headers: {'Authorization': await getToken()},
          ));
      print("token");
      print(await getToken());
      print("token");
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());
        return KatalogSepatuResponse.fromJson(json.decode(response.data));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<KatalogSepatuResponse?> putKatalogSepatu(
      String id, KatalogSepatuInput katalogsepatu) async {
    try {
      final response = await Dio().put('$_baseUrl/katalogsepatu?id=$id',
          data: katalogsepatu.formData(),
          options: Options(
            headers: {'Authorization': await getToken()},
          ));
      if (response.statusCode == 200) {
        return KatalogSepatuResponse.fromJson(json.decode(response.data));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteKatalogSepatu(String id) async {
    try {
      final response = await Dio().delete('$_baseUrl/katalogsepatu?id=$id',
          options: Options(
            headers: {'Authorization': await getToken()},
          ));
      if (response.statusCode == 200) {
        return KatalogSepatuResponse.fromJson(json.decode(response.data));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
