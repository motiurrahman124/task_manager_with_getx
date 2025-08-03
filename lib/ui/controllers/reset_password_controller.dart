import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_with_getx/data/service/network_caller.dart';
import 'package:task_manager_with_getx/data/urls.dart';

class ResetPasswordController extends GetxController{
  bool _inProgress = false;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> resetPassword(String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? Email = sharedPreferences.getString('email') ?? '';
    String? Otp = sharedPreferences.getString('otp') ?? '';

    Map<String, String> requestBody = {
      "email": Email,
      "OTP": Otp,
      "password": password,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.resetPasswordUrl, body: requestBody, isFromLogin: true
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage!;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}