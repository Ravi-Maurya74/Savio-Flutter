class ApiConstants {
  static const String baseUrl =
      "https://b7ce-2409-40e3-55-fa62-3ee7-3ef6-12c4-51f2.ngrok-free.app/";
}

class UserApiConstants {
  static const String baseUrl = "${ApiConstants.baseUrl}user/";
  static const String search = baseUrl;
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

  static String categorySpending(int year, int month) {
    return "${baseUrl}category/$year/$month/";
  }

  static const String prediction = "${baseUrl}prediction/";
}

class CommunityPostApiConstants {
  static const String baseUrl = "${ApiConstants.baseUrl}community_post/";

  static const String listCreate = baseUrl;

  static const String bookmarked = "${baseUrl}user_bookmarks/";

  static const String userPosts = "${baseUrl}user_posts/";

  static String retrieveUpdateDestroy(int id) {
    return "$baseUrl$id/";
  }

  static String bookmark(int id) {
    return "$baseUrl$id/bookmark/";
  }

  static String vote(int id) {
    return "$baseUrl$id/vote/";
  }

  static const String comments = "${baseUrl}comments/";

  static String commentVote(int id) {
    return "$comments$id/vote/";
  }

  static const String commentCreate = "${comments}create/";
}

class LendingRegistryApiConstants {
  static const String baseUrl = "${ApiConstants.baseUrl}lending_registry/";
  static const String create = "${baseUrl}create/";
  static const String active = "${baseUrl}active/";
  static const String initiateRequestPending =
      "${baseUrl}initiate_request_pending/";
  static const String clearRequestPending = "${baseUrl}clear_request_pending/";
}
