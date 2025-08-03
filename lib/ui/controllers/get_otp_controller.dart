import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_with_getx/data/service/network_caller.dart';
import 'package:task_manager_with_getx/data/urls.dart';

class GetOtpController extends GetxController{
  bool _inProgress = false;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> getOtp(String email) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    // SharedPreferences prefs = await SharedPreferences.getInstance();

    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.recoverVerifyEmailUrl(email)
    );

    if (response.isSuccess) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('email', email);
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