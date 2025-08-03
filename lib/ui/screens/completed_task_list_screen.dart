import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/task_model.dart';
import 'package:task_manager_with_getx/data/service/network_caller.dart';
import 'package:task_manager_with_getx/data/urls.dart';
import 'package:task_manager_with_getx/ui/controllers/completed_task_list_controller.dart';
import 'package:task_manager_with_getx/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/snack_bar_message.dart';
import 'package:task_manager_with_getx/ui/widgets/task_card.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() => _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CompletedTaskListController>().getCompletedTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GetBuilder<CompletedTaskListController>(
        builder: (controller) {
          return Visibility(
            visible: controller.inProgress == false,
            replacement: CenteredCircularProgressIndicator(),
            child: ListView.builder(
              itemCount: controller.completedTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskType: TaskType.completed,
                  taskModel: controller.completedTaskList[index],
                  onStatusUpdate: () {
                    Get.find<CompletedTaskListController>().getCompletedTaskList();
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
