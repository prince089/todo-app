import 'package:get/get.dart';
import 'package:todo/app/data/provider/task/provider.dart';
import 'package:todo/app/data/services/storage/repository.dart';
import 'package:todo/app/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
