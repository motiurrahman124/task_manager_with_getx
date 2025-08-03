import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/service/network_caller.dart';
import 'package:task_manager_with_getx/data/urls.dart';

class SignupController extends GetxController{
  bool _inProgress = false;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> signUp(String email, String firstName, String lastName, String mobile, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, String> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password":  password
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.registrationUrl,
      body: requestBody,
    );

    _inProgress = false;
    update();

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage!;
    }

    return isSuccess;
  }
}