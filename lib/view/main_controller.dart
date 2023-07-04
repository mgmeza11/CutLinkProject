import 'package:get/get.dart';

import '../domain/usecases/link_usecases.dart';

class MainController extends GetxController {
  LinkUseCases linkUseCase = Get.find();

  Future<void> getShortLink(link) async {
    await linkUseCase.getShortLink(link);
  }
}