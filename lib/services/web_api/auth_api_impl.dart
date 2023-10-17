import 'dart:convert';

import 'package:rexofarm/models/api_response.dart';
import 'package:rexofarm/models/user.dart';

import 'package:http/http.dart' as http;

import 'dart:async';

import 'auth_api.dart';

class AuthApiImpl implements AuthApi {
  final String _baseUrl = 'rexofarm-logistics-api.onrender.com';

  @override
  Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    ApiResponse apiResponse;
    http.Response response;

    String endpoint = "v1/auth/sign-in";

    try {
      response = await http.post(
        Uri.https(_baseUrl, endpoint),
        headers: <String, String>{},
        body: <String, dynamic>{
          'email': email,
          'password': password,
        },
      );
    } catch (error) {
      apiResponse = ApiResponse.error(
        'Please check your internet connection and try again',
      );
      return apiResponse;
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // log in successful
      final token = jsonDecode(response.body)["data"]["token"];
      apiResponse = ApiResponse.completed(token: token);
    } else {
      // Bad request error (e.g., email or password is invalid)
      apiResponse = ApiResponse.error(
        "Invalid email or password! Please check.",
      );
    }

    return apiResponse;
  }

  @override
  Future<ApiResponse> signUp(User user) async {
    ApiResponse apiResponse;
    http.Response response;

    String endpoint = 'v1/auth/sign-up';

    try {
      response = await http.post(
        Uri.https(_baseUrl, endpoint),
        headers: <String, String>{},
        body: <String, dynamic>{
          'firstName': user.firstName,
          'lastName': user.lastName,
          'phone': user.phoneNumber,
          'email': user.email,
          'password': user.password,
        },
      );
    } catch (error) {
      apiResponse = ApiResponse.error(
          'Please check your internet connection and try again');
      return apiResponse;
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // account created successfully
      final token = jsonDecode(response.body)["data"]["token"];
      apiResponse = ApiResponse.completed(token: token);
    } else if (response.statusCode == 400) {
      // Bad request error (e.g., email or password is invalid)
      apiResponse =
          ApiResponse.error("Invalid email or password! Please check.");
    } else if (response.statusCode == 409) {
      // Duplicate key error (email already registered)
      apiResponse = ApiResponse.existingEmail(
          "Email already registered! Please sign in instead.");
    } else {
      // general error occurred. Please try again
      apiResponse = ApiResponse.error("Error occurred! Please try again");
    }

    return apiResponse;
  }

  @override
  Future<ApiResponse> resetPasswordInitiate({
    required String email,
  }) async {
    ApiResponse apiResponse;
    http.Response response;

    String endpoint = 'v1/auth/reset-password/initiate';

    try {
      response = await http.post(
        Uri.https(_baseUrl, endpoint),
        body: <String, dynamic>{
          'email': email,
        },
      );
    } catch (error) {
      apiResponse = ApiResponse.error(
        'Please check your internet connection and try again',
      );
      return apiResponse;
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      String token = json['data']['token'];
      apiResponse = ApiResponse.completed(token: token);
    } else {
      final json = jsonDecode(response.body);
      String error = json['error'] ?? '';
      String message = json['message'] ?? '';
      apiResponse = ApiResponse.error('$error: $message');
    }

    return apiResponse;
  }

  @override
  Future<ApiResponse> resetPasswordValidate({
    required String verificationToken,
    required String otp,
  }) async {
    ApiResponse apiResponse;
    http.Response response;

    String endpoint = 'v1/auth/reset-password/validate';

    try {
      response = await http.post(
        Uri.https(_baseUrl, endpoint),
        body: <String, dynamic>{
          'verificationToken': verificationToken,
          'otp': otp,
        },
      );
    } catch (error) {
      apiResponse = ApiResponse.error(
        'Please check your internet connection and try again',
      );
      return apiResponse;
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      final token = json['data']['token']['payload'];
      apiResponse = ApiResponse.completed(token: token);
    } else {
      final json = jsonDecode(response.body);
      apiResponse = ApiResponse.error(json["message"]);
    }

    return apiResponse;
  }

  @override
  Future<ApiResponse> resetPasswordComplete({
    required String verificationToken,
    required String password,
  }) async {
    ApiResponse apiResponse;
    http.Response response;

    String endpoint = 'v1/auth/reset-password/complete';

    try {
      response = await http.patch(
        Uri.https(_baseUrl, endpoint),
        body: <String, dynamic>{
          'verificationToken': verificationToken,
          'password': password,
        },
      );
    } catch (error) {
      apiResponse = ApiResponse.error(
        'Please check your internet connection and try again',
      );
      return apiResponse;
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      apiResponse = ApiResponse.completed(token: verificationToken);
    } else {
      apiResponse = ApiResponse.error("Error occurred! Please try again");
    }

    return apiResponse;
  }

  @override
  Future<ApiResponse> changePassword({
    required String token,
    required String oldPassword,
    required String newPassword,
  }) async {
    ApiResponse apiResponse;
    http.Response response;

    String endpoint = 'v1/user/change-password';

    try {
      response = await http.patch(
        Uri.https(_baseUrl, endpoint),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
      );
    } catch (error) {
      apiResponse = ApiResponse.error(
        'Please check your internet connection and try again',
      );
      return apiResponse;
    }

    print("Response - "+response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      apiResponse = ApiResponse.completed(token: token);
    } else {
      apiResponse = ApiResponse.error("Error occurred! Please try again");
    }

    return apiResponse;
  }
}
