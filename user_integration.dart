import 'package:dio/dio.dart';

class UserService {
  final Dio dio;

  // Constructor with base URL and logging setup
  UserService({String baseUrl = 'http://192.168.1.99:3000'})
      : dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    // Adding logging interceptor for debugging
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      logPrint: (object) => print(object),
    ));
  }

  // Method to handle create account
  Future<Response> createAccount({
    required String email,
    required String password,
    required String confirmPassword,
    required String fullname,
    required String phonenumber,
    required String country,
    required String city,
    required String houseNumber,
    required String streetNumber,
    required String postalCode,
    required String blockNumber,
  }) async {
    try {
      Response response = await dio.post(
        '/api/user/createAccount',
        data: {
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
          'fullname': fullname,
          'phonenumber': phonenumber,
          'country': country,
          'city': city,
          'houseNumber': houseNumber,
          'streetNumber': streetNumber,
          'postalCode': postalCode,
          'blockNumber': blockNumber,
        },
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        // Handle Dio-specific errors
        throw Exception(
            'Failed to create account: ${e.response?.data ?? e.message}');
      }
      throw Exception('Failed to create account: $e');
    }
  }

  // Method to handle user sign in
  Future<Response> signIn(String emailOrPhone, String password) async {
    try {
      Response response = await dio.post(
        '/api/user/signIn',
        data: {
          'email': emailOrPhone,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        // Handle Dio-specific errors
        throw Exception('Failed to sign in: ${e.response?.data ?? e.message}');
      }
      throw Exception('Failed to sign in: $e');
    }
  }
}
