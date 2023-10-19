class AppConstants {
  static const String APP_NAME = '1Million';
  static const double APP_VERSION = 1.0;
  static const String THEME = 'theme';
  static const String INTRO = 'intro';

  static const String TOKEN = 'token';
  static const String REFRESH_TOKEN = 'refreshToken';
  static String FCM_TOKEN = '';
  static const String APP_ID = 'b266b20dff124f3a9ea57f71c77a07a9';
  static String DRAFT_JSON = '';

  static const String BASE_URL = 'http://192.168.29.32:4000';
  // static const String BASE_URL = 'http://43.204.60.115:4000';

  static const String IMAGE_BASE_URL = BASE_URL + '/public/images/';
  static const String DOCS_BASE_URL = BASE_URL + '/public/documents/';

  static const String UPLOAD_FILE = '/api/v1/fileupload';
  static const String UPLOAD_DOCS = '/api/v1/fileupload/documents';

  static const String LANGUAGE_CODE = 'language_code';

  static const String LOGIN = '/api/v1/user/login';
  static const String REGISTER = '/api/v1/user/register';
  static const String FORGOT_PASSWORD = '/api/v1/user/sendotp';
  static const String CHECK_OTP = '/api/v1/user/checkOtp';
  static const String UPDATE_PASSWORD = '/api/v1/user/updatePassword';
  static const String RESET_PASSWORD = '/api/v1/user/resatePassword';

  static const String USER_UPDATE = '/api/v1/user/update';
  static const String USER_DETAILS = '/api/v1/profile/';
  static const String USER_COUNTRY = '/api/v1/data/country';
  static const String CHAT_USER_PAGINATION_API = '/api/v1/user/Weblist/';

  static const String JOB_USER_PAGINATION_API = '/api/v1/jobs/';

  static const String SEARCH_USER = '/api/v1/user/list/';
  static const String USER_FOLLOW = '/api/v1/user/follow';
  static const String USER_GET_FOLLOW_OTHER = '/api/v1/user/getfollowOther/';
  static const String UNFOLLOW = '/api/v1/user/unfollow/';
  static const String USER_FOLLOWING_API = '/api/v1/user/following/';
  static const String SEND_MSG = '/api/v1/user/sendMsg';
  static const String REMOVE_FOLLOWER = '/api/v1/user/removefollower';

  static const String JOB_LIST = '/api/v1/jobs/list';
  static const String POST_ADD = '/api/v1/post/add';
  static const String POST_LIST = '/api/v1/post/list/';
  static const String POST_LIST_VIDEO = '/api/v1/post/listvideo/';
  static const String ADD_COMMENT_LIST = '/api/v1/createComment/add/';
  static const String GET_COMMENT_LIST = '/api/v1/getcomment/';
  static const String GET_PRODUCTION_TYPE = '/api/v1/data/production-types';
  static const String GET_ROLES = '/api/v1/data/roles';
  static const String GET_APPLYED_JOB_SELECTED =
      '/api/v1/getApplyedJobSelected/';
  static const String CHECK_USER_PRIVATE = '/api/v1/checkUserPrivate/';

  static const String APPLY_JOB = '/api/v1/appplyjob/';
  static const String GET_LIKE_POST = '/api/v1/post/like';
  static const String GET_NOTIFICATION = '/api/v1/user/notifications';

  static const String SEND_PHONE_NOTIFICATION = '/api/v1/sendNotifcationcall/';

  static const String USER_PASSWORD = 'password';
  static const String USER_EMAIL = 'email';
}

class ConstantData {
  static const callerSound = "assets/sound/caller.mp3";
  static const callDisconnected = "assets/sound/call_disconnected.mp3";
  static const connectionLost = "assets/sound/connectionLost.mp3";
  static const userOffline = "assets/sound/userOffline.mp3";
}
