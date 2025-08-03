import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/task_model.dart';
import 'package:task_manager_with_getx/data/service/network_caller.dart';
import 'package:task_manager_with_getx/data/urls.dart';
import 'package:task_manager_with_getx/ui/controllers/cancelled_task_list_controller.dart';
import 'package:task_manager_with_getx/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/snack_bar_message.dart';
import 'package:task_manager_with_getx/ui/widgets/task_card.dart';

class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});

  @override
  State<CancelledTaskListScreen> createState() => _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CancelledTaskListController>().getCancelledTaskList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GetBuilder<CancelledTaskListController>(
        builder: (controller) {
          return Visibility(
            visible: controller.inProgress == false,
            replacement: CenteredCircularProgressIndicator(),
            child: ListView.builder(
              itemCount: controller.cancelledTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskType: TaskType.cancelled,
                  taskModel: controller.cancelledTaskList[index],
                  onStatusUpdate: () {
                    Get.find<CancelledTaskListController>().getCancelledTaskList();
                  },
                );
              },
            ),
          );
        }
      ),
    );
  }

}
