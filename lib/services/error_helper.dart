import 'package:dio/dio.dart';
import 'package:weather/models/error.dart';

Error getDioErrorMessage(DioError error) {
  if (error.type == DioErrorType.response) {
    return Error(
        title: "Who broke the Internet?",
        subtitle: "Please make sure your connected to the network",
        asset: "assets/networkerror.json");
  }

  return Error(
      title: "Oops!",
      subtitle: "Something went wrong, please try again",
      asset: "assets/somethingwentwrong.json");
}
