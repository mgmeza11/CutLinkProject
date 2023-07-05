import 'package:cut_link_project/domain/models/LinkData.dart';
import 'package:get/get.dart';
import 'dart:developer';
import '../../domain/usecases/link_usecases.dart';

class MainController extends GetxController {
  LinkUseCases linkUseCase = Get.find();
  final _currentShortLink = ''.obs;
  final _isLoading = false.obs;

  RxString  get currentShortLink => _currentShortLink;
  RxBool get isLoading => _isLoading;

  Future<void> getShortLink(link) async {
    _currentShortLink.value = '';
    _isLoading.value = true;
   var newShortLink = await linkUseCase.getShortLink(link);
    log.printInfo(info: 'short $newShortLink');
   _currentShortLink.value = newShortLink;
   _isLoading.value = false;
  }
}