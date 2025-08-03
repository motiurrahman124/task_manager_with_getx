import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_with_getx/data/models/user_model.dart';
import 'package:task_manager_with_getx/data/service/network_caller.dart';
import 'package:task_manager_with_getx/data/urls.dart';
import 'package:task_manager_with_getx/ui/controllers/auth_controller.dart';

class UpdateProfileController extends GetxController{
  bool _inProgress = false;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> updateProfile(String email, String firstName, String lastName, String mobile, String? password, XFile? photo) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Uint8List? imageBytes;

    Map<String, String> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (password != null && password.isNotEmpty) {
      requestBody['password'] = password;
    }

    if (photo != null) {
      imageBytes = await photo.readAsBytes();
      requestBody['photo'] = base64Encode(imageBytes);
    }

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfileUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      UserModel userModel = UserModel(
          id: AuthController.userModel!.id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          mobile: mobile,
          photo: imageBytes == null
              ? AuthController.userModel?.photo
              : base64Encode(imageBytes)
      );

      await AuthController.updateUserData(userModel);
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