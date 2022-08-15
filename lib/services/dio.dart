import 'package:dio/dio.dart';

class DioInstance {
  static final DioInstance _singleton = DioInstance._internal();
  late Dio dio;
  late String baseURL;
  late String apiKey;
  factory DioInstance({
    bool settingConfig = false,
    String? baseURL,
    String? apiKey,
  }) {
    if (settingConfig) {
      _singleton.baseURL = baseURL!;
      _singleton.apiKey = apiKey!;
    }
    return _singleton;
  }

  DioInstance._internal() {
    BaseOptions options = BaseOptions();
    dio = Dio(options);
  }
}

initializeDio(String baseURL, String apiKey) {
  DioInstance(settingConfig: true, baseURL: baseURL, apiKey: apiKey);
}
