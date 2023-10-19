import 'dart:convert';
import 'dart:io' as Io;

import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:million/api/api_client.dart';
import 'package:million/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  JobRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getJobList() async {
    return await apiClient.getData(AppConstants.JOB_LIST);
  }

  Future<Response> getChatUserWithPaginationApi(
      int id, String searchText) async {
    print(
        'URL >>> ${AppConstants.CHAT_USER_PAGINATION_API + id.toString() + '/$searchText'}');
    return await apiClient.getData(
        AppConstants.CHAT_USER_PAGINATION_API + id.toString() + '/$searchText');
  }

  Future<Response> getChatUserFilterApi(int id, String searchText) async {
    // return await apiClient.getData('${AppConstants.CHAT_USER_PAGINATION_API}$id?fullName=$searchText');

    return await apiClient
        .getData('${AppConstants.CHAT_USER_PAGINATION_API}$id/$searchText');
  }

  Future<Response> getJobsUserWithPaginationApi(int id) async {
    return await apiClient
        .getData(AppConstants.JOB_USER_PAGINATION_API + id.toString());
  }
Future<Response> getJobFilter(int id,String productionType,talent,jobType,shorting,uniontype) async {
    var filter = "";
    if(productionType != ""){
     filter = "${filter}productionType=$productionType";
    }
    if(talent != ""){
      if(filter!="") {
        filter = '${filter}&';
      }
      filter = "${filter}talent=$talent";
    }
    if(jobType != ""){
      if(filter!="") {
        filter = '${filter}&';
      }
      filter = "${filter}compensation=$jobType";
    }
    if(shorting != ""){
      if(filter!="") {
        filter = '${filter}&';
      }
      filter = "${filter}shorting=$shorting";
    }

    if(uniontype != "" && uniontype!="Any"){
      if(filter!="") {
        filter = '${filter}&';
      }
      filter = "${filter}unionStatus=$uniontype";
    }

    return await apiClient.getData('${AppConstants.JOB_USER_PAGINATION_API}$id?$filter');

  }

  Future<bool> setDraftData(
      String draftToken,
      ) async {
    return await sharedPreferences.setString(AppConstants.DRAFT_JSON, draftToken);
  }

  Future<Response> getJobsUserFilterApi(int id, String searchText) async {
    print(
        'job search url -- ${'${AppConstants.JOB_USER_PAGINATION_API}$id/$searchText'}');
    // return await apiClient.getData('${AppConstants.JOB_USER_PAGINATION_API}$id?talent=$searchText');

    return await apiClient
        .getData('${AppConstants.JOB_USER_PAGINATION_API}$id/$searchText');
  }

  Future<Response> getJobsAuditionApi() async {
    return await apiClient
        .getData(AppConstants.JOB_LIST + '?auditionDate=true');
  }

  Future<Response> getJobsSubmitASAPApi() async {
    return await apiClient.getData(AppConstants.JOB_LIST + '?submit=true');
  }

  Future<Response> getPostList() async {
    return await apiClient.getData(AppConstants.POST_LIST);
  }

  Future<Response> getPostListVideo() async {
    return await apiClient.getData(AppConstants.POST_LIST_VIDEO);
  }

  Future<Response> getOtherPostList(String userId) async {
    return await apiClient.getData(AppConstants.POST_LIST + userId);
  }

  Future<Response> getOtherVideoPostList(String userId) async {
    return await apiClient.getData(AppConstants.POST_LIST + userId);
  }

  Future<Response> getCommentList(String userId) async {
    return await apiClient.getData(AppConstants.GET_COMMENT_LIST + userId);
  }

  Future<Response> getProductionType() async {
    return await apiClient.getData(AppConstants.GET_PRODUCTION_TYPE );
  }

  Future<Response> getNotification() async {
    return await apiClient.getData(AppConstants.GET_NOTIFICATION);
  }

 Future<Response> getRolesType() async {
    return await apiClient.getData(AppConstants.GET_ROLES );
  }

  Future<Response> addCommentList({required String text, postID}) async {
    return await apiClient.postData(AppConstants.ADD_COMMENT_LIST, {
      "text": text,
      "postid": postID,
    });
  }

  Future<Response> getApplyJob(String userId) async {
    return await apiClient.getData(AppConstants.APPLY_JOB+ userId);
  }
  Future<Response> getApplyedJobSelected(String jobID) async {
    return await apiClient.getData(AppConstants.GET_APPLYED_JOB_SELECTED+ jobID);
  }
  Future<Response> getPrivateUser(String jobID) async {
    return await apiClient.getData(AppConstants.CHECK_USER_PRIVATE+ jobID);
  }
  Future<Response> addLikeList(String postid) async {
    return await apiClient.postData(AppConstants.GET_LIKE_POST ,{"postid":postid});
  }


  Future<Response> applyJobPost({
    required String jobid, userid,talent,postType,List? postItems,List? postVideo,List? postDocument,jobText,Map<String,dynamic>? userDetails}) async {
    return await apiClient.postData(AppConstants.APPLY_JOB, {
      "jobid": jobid,
      "userid": userid,
      "talent": talent,
      "postType": postType,
      "postItems": postItems,
      "postVideo": postVideo,
      "postDocument": postDocument,
      "jobText": jobText,
      "userDetails": userDetails,
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
