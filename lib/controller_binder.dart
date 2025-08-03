import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controllers/cancelled_task_list_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/completed_task_list_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/get_otp_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/new_task_list_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/progress_task_list_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/reset_password_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/signin_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/signup_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/update_profile_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/verify_otp_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignupController());
    Get.put(GetOtpController());
    Get.put(VerifyOtpController());
    Get.put(ResetPasswordController());
    Get.put(UpdateProfileController());
    Get.put(NewTaskListController());
    Get.put(ProgressTaskListController());
    Get.put(CompletedTaskListController());
    Get.put(CancelledTaskListController());
  }
}