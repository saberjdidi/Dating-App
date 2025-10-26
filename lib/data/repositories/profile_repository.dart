import 'package:dating_app_bilhalal/core/utils/constants/api_constant.dart';
import 'package:dating_app_bilhalal/data/api/api_client.dart';
import 'package:dating_app_bilhalal/data/models/api_result.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'handle_dio_error.dart';

class ProfileRepository {
  static final ProfileRepository _instance = ProfileRepository._internal();

  factory ProfileRepository() => _instance;

  ProfileRepository._internal();

  final ApiClient _client = ApiClient();

  //Create Account
  Future<ApiResult<void>> createAccount({
    required String username,
    required String bio,
    required String gender,
    required int age,
    required int height,
    required int weight,
    required String socialState,
    required String marriageType,
    required String jobTitle,
    required String salaryRangeMin,
    required String salaryRangeMax,
    required String country,
    required String skinColor,
    required List<String> hobbies
  }) async {
    try {
      final body = {
        "initial": {
          "name": username,
          "desc": bio,
          "gender": gender,
          "age": age,
          "weight": weight,
          "height": height
        },
        "profile": {
          "social_state": socialState,
          "marriage_type": marriageType,
          "job_title": jobTitle,
          "salary_range_min": salaryRangeMin,
          "salary_range_max": salaryRangeMax,
          "country": country,
          "skin_tone_hex": skinColor
        },
        "hobbies": hobbies
      };

      debugPrint("create account  : $body");

      final resp = await _client.post('${ApiConstants.user}/profile/full', data: body);

      if (resp.statusCode == HttpStatusCode.ok || resp.statusCode == HttpStatusCode.created) {
        final map = resp.data as Map<String, dynamic>;
        final dataMap = map['data'] as Map<String, dynamic>?;
        //final authData = dataMap != null ? UserModel.fromJsonProfile(dataMap) : null;
        return ApiResult(success: true, message: map['message'] as String?, data: dataMap);
      } else {
        // backend retourne 4xx avec message dans body
        final map = resp.data;
        final msg = (map is Map && map['message'] != null) ? map['message'] : resp.statusMessage;
        return ApiResult(success: false, message: msg?.toString());
      }
    } on DioException catch (e) {
      String msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  ///My Profile
  Future<ApiResult<UserModel>> myProfile() async {
    try {
      final resp = await _client.get('${ApiConstants.user}/profile');

      if (resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final dataMap = map['data'] as Map<String, dynamic>?;
        final authData = dataMap != null ? UserModel.fromJson(dataMap) : null;
        return ApiResult(success: true, message: map['message'] as String?, data: authData);
      } else {
        // backend retourne 4xx avec message dans body
        final map = resp.data;
        final msg = (map is Map && map['message'] != null) ? map['message'] : resp.statusMessage;
        return ApiResult(success: false, message: msg?.toString());
      }
    } on DioException catch (e) {
      String msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  Future<ApiResult<void>> updateProfile({
    required String username,
    required int height,
    required int weight,
    required String bio,
    required String socialState,
    required String marriageType,
    required String jobTitle,
    required String salaryRangeMin,
    required String salaryRangeMax,
    required String country,
    required String skinColor,
  }) async {
    try {
      final body = {
        "username": username,
        "height": height,
        "weight": weight,
        "description": bio,
        "social_state": socialState,
        "marriage_type": marriageType,
        "job_title": jobTitle,
        "salary_range_min": salaryRangeMin,
        "salary_range_max": salaryRangeMax,
        "country": country,
        "skin_tone_hex": skinColor
      };

      debugPrint("body edit profile  : $body");

      final resp = await _client.put('${ApiConstants.user}/profile', data: body);

      if (resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final dataMap = map['data'] as Map<String, dynamic>?;
        final authData = dataMap != null ? UserModel.fromJson(dataMap) : null;
        return ApiResult(success: true, message: map['message'] as String?, data: authData);
      } else {
        // backend retourne 4xx avec message dans body
        final map = resp.data;
        final msg = (map is Map && map['message'] != null) ? map['message'] : resp.statusMessage;
        return ApiResult(success: false, message: msg?.toString());
      }
    } on DioException catch (e) {
      String msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  /// ✅ Resend OTP
  Future<ApiResult<void>> profileReport({required int id, required String commentaire}) async {
    try {
      final body = {'comment': commentaire};
      final resp = await _client.post('${ApiConstants.profileReport}/$id', data: body);

      if (resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        return ApiResult(success: map['success'] ?? false, message: map['message']?.toString());
      } else {
        final map = resp.data;
        final msg = (map is Map && map['message'] != null) ? map['message'] : 'Erreur Reports';
        return ApiResult(success: false, message: msg.toString());
      }
    } on DioException catch (e) {
      return ApiResult(success: false, message: HandleDioError.handleDioError(e));
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  Future<ApiResult<List<InterestModel>>> getMyHobbies() async {
    try {
      final resp = await _client.get('${ApiConstants.user}/hobbies');

      if (resp.statusCode == HttpStatusCode.ok) {
        final map = resp.data as Map<String, dynamic>;
        final data = map['data']['hobbies'] as List<dynamic>? ?? [];
        final hobbies = data.map((e) => InterestModel.fromJson(e)).toList();

        return ApiResult(success: true, data: hobbies, message: map['message']);
      } else {
        return ApiResult(success: false, message: resp.statusMessage);
      }
    } on DioException catch (e) {
      final msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }

  Future<ApiResult<List<InterestModel>>> addHobbiesList(List<String?> hobbies) async {
    try {
      final body = {'hobbies': hobbies};
      final resp = await _client.post('${ApiConstants.user}/hobbies', data: body);

      if (resp.statusCode == HttpStatusCode.ok || resp.statusCode == HttpStatusCode.created) {
        final map = resp.data as Map<String, dynamic>;
        final data = map['data']['hobbies'] as List<dynamic>? ?? [];
        final hobbies = data.map((e) => InterestModel.fromJson(e)).toList();

        return ApiResult(success: true, data: hobbies, message: map['message']);
      } else {
        return ApiResult(success: false, message: resp.statusMessage);
      }
    } on DioException catch (e) {
      final msg = HandleDioError.handleDioError(e);
      return ApiResult(success: false, message: msg);
    } catch (e) {
      return ApiResult(success: false, message: e.toString());
    }
  }
}