import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import '../../../values/constants.dart';
import '../../api_provider/api_provider.dart';

class AuthRepo extends GetxService {
  ApiProvider apiProvider;

  AuthRepo({
    required this.apiProvider,
  });

  Future<Response> signUpUserRepo(
      {required Map<String, dynamic> formData}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider
        .setFormData(url: Constants.signUpPath, formData: formData, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
  }

  Future<Response> loginRepo({required Map<String, dynamic> formData}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider
        .setFormData(url: Constants.loginPath, formData: formData, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
  }

  Future<Response> forgotPassword(
      {required Map<String, dynamic> formData}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider.setFormData(
        url: Constants.forgotPassword,
        formData: formData,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        });
  }

  Future<Response> verifyEmail({required Map<String, dynamic> formData}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider
        .setFormData(url: Constants.otp, formData: formData, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
  }

  Future<Response> verifyEmailResetPassword(
      {required Map<String, dynamic> formData}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider.setFormData(
        url: Constants.resetPasswordOtp,
        formData: formData,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        });
  }

  Future<Response> resendOtpRepo(
      {required Map<String, dynamic> formData}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider.setFormData(
        url: Constants.resendOtp,
        formData: formData,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        });
  }

  Future<Response> updatePasswordRepo(
      {required Map<String, dynamic> formData,required String accessToken}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider.setFormData(
        url: Constants.updatePassword,
        formData: formData,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $accessToken"
        });
  }
}
