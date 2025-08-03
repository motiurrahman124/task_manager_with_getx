import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_with_getx/data/service/network_caller.dart';
import 'package:task_manager_with_getx/data/urls.dart';

class VerifyOtpController extends GetxController{
  bool _inProgress = false;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> verifyOtp(String otp) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? Email = sharedPreferences.getString('email') ?? '';

    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.verifyOtpUrl(Email,otp)
    );

    if (response.isSuccess) {
      await sharedPreferences.setString('otp', otp);
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