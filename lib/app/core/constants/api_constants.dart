import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants
{
    static String baseUrl = dotenv.env['BASE_URL']!;

    // ------------------ AI-Chat Endpoints ------------------

    static const String aiChat = "/ai/chat"; // POST
    static const String getChat = "/ai/chat/{id}"; // GET
    static const String sendMessage = "/ai/chat/{id}/message"; // POST
    static const String updateContext = "/ai/chat/{id}/context"; // PATCH
    static const String endChat = "/ai/chat/{id}/end"; // PATCH
    static const String messageFeedback = "/ai/chat/{chatId}/message/{messageId}/feedback"; // POST
    static const String sessionFeedback = "/ai/chat/{id}/feedback"; // POST
    static const String chatAnalytics = "/ai/chat/{id}/analytics"; // GET
    static const String allChats = "/ai/chats"; // GET
    static const String chatDeleteById = "/ai/chat/{id}"; // Delete
    static const String chatAllDelete = "/ai/chat/all"; // Delete

    // ------------------ Authentication Endpoints ------------------


    static const String logout = "/auth/logout"; // POST
    static const String me = "/auth/me"; // GET
    static const String updateDetails = "/auth/updatedetails"; // PUT
    static const String verifyEmail = "/auth/verify-email/{token}"; // GET
    static const String sendOtp = "/auth/send-otp"; // POST
    static const String googleLogin = "/auth/google-login"; // POST
    static const String verifyOtp = "/auth/verify-otp"; // POST
    static const String refreshToken = "/auth/refresh-token"; // POST

    // ------------------ Leads Endpoints ------------------

    static const String leads = "/leads"; // GET, POST
    static const String myInquiries = "/leads/my-inquiries"; // GET
    static const String myLeads = "/leads/my-leads"; // GET
    static const String leadsAnalytics = "/leads/analytics"; // GET
    static const String singleLead = "/leads/{id}"; // GET, PUT, DELETE
    static const String followUpLead = "/leads/{id}/followup"; // PUT
    static const String convertLead = "/leads/{id}/convert"; // PUT

    // ------------------ Notifications Endpoints ------------------

    static const String notifications = "/notifications"; // GET, POST
    static const String unreadCount = "/notifications/unread-count"; // GET
    static const String markAsRead = "/notifications/{id}/read"; // PUT
    static const String markAllRead = "/notifications/mark-all-read"; // PUT
    static const String deleteNotification = "/notifications/{id}"; // DELETE
    static const String clearAllNotifications = "/notifications/clear-all"; // DELETE

    // ------------------ Properties Endpoints ------------------

    static const String properties = "/properties"; // GET, POST
    static const String searchProperties = "/properties/search"; // GET
    static const String featuredProperties = "/properties/featured"; // GET
    static const String premiumProperties = "/properties/premium"; // GET
    static const String propertiesByLocation = "/properties/location/{city}/{state}"; // GET
    static const String newlyAddedProperties = "/properties/newly-added"; // GET
    static const String myProperties = "/properties/my-properties"; // GET
    static const String likedProperties = "/properties/user/liked"; // GET
    static const String likeProperty = "/properties/{id}/like"; // POST
    static const String singleProperty = "/properties/{id}"; // GET, PUT, DELETE
    static const String recentlyViewed = "/properties/user/recently-viewed"; // GET
    static const String contactedProperties = "/properties/user/contacted"; // GET
    static const String uploadPropertyImages = "/properties/{id}/upload-images"; // POST
    static const String propertyStats = "/properties/{id}/stats"; // GET

    // ------------------ Users Endpoints ------------------

    static const String userProfile = "/users/profile"; // GET
    static const String updateProfile = "/users/profile/update"; // PUT
    static const String userDashboard = "/users/dashboard"; // GET
    static const String uploadAvatar = "/users/avatar"; // POST
    static const String allUsers = "/users"; // GET (Admin only)
    static const String singleUser = "/users/{id}"; // GET, DELETE (Admin only)
    static const String updateUserStatus = "/users/{id}/status"; // PUT
    static const String changeUserRole = "/users/{id}/role"; // PUT

    // ------------------ Analytics Endpoints ------------------

    static const String analytics = "/analytics"; // GET
    static const String sellerDashboard = "/analytics/seller-dashboard"; // GET
    static const String sellerPropertiesAnalytics = "/analytics/seller/properties"; // GET

    // ------------------ Payments & Plans ------------------

    static const String payments = "/payments"; // GET
    static const String plans = "/plans"; // GET

    // ------------------ Support ------------------

    static const String support = "/support"; // GET

    // Headers
    static const String contentType = "application/json";
    static const String authorization = "Authorization";
    static const String acceptLanguage = "Accept-Language";

    // Timeouts
    static const int connectTimeout = 30000;
    static const int receiveTimeout = 30000;
    static const int sendTimeout = 30000;
}
