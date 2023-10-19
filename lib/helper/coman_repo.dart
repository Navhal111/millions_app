import 'dart:async';
import 'dart:convert';
import 'dart:io' as Io;

import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:million/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class ComanRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ComanRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> addPostApi({
    required dynamic postImage,
    required String userid,
    required String dec,
    required String tags,
    required String type,
    required int status,
  }) async {
    return await apiClient.postData(AppConstants.POST_ADD, {
      "postImage": postImage,
      "userid": userid,
      "dec": dec,
      "tags": tags,
      "type": type,
      "status": status
    });
  }

  Future<dynamic> uploadImage(
    key,
    String? file,
    String path,
  ) async {
    final postUri = Uri.parse(AppConstants.BASE_URL + AppConstants.UPLOAD_FILE);

    Http.MultipartRequest request = Http.MultipartRequest('POST', postUri);
    List<int> imageBytes = Io.File(path).readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    // debugPrint("image $base64Image");
    return await apiClient.appUserUploadFileAsyncProfile(
      file,
      base64Image,
    );
  }
}
