class ApiConstants {
  static const String baseUrl =
      "https://e512-2409-40e3-103a-8f1f-e0ef-258-4012-c5e.ngrok-free.app/";
}

class UserApiConstants {
  static const String baseUrl = "${ApiConstants.baseUrl}user/";
  static const String create = "${baseUrl}create/";
  static const String me = "${baseUrl}me/";
  static const String login = "${baseUrl}token/";
}

class TransactionApiConstants {
  static const String baseUrl = "${ApiConstants.baseUrl}transaction/";
  static const String listCreate = baseUrl;
  static const String category = "${ApiConstants.baseUrl}category/";
  static String retrieveUpdateDestroy(int id) {
    return "$baseUrl$id/";
  }
}

class CommunityPostApiConstants {
  static const String baseUrl = "${ApiConstants.baseUrl}community_post/";
  static const String listCreate = baseUrl;
  static String retrieveUpdateDestroy(int id) {
    return "$baseUrl$id/";
  }
}
