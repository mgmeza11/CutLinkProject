import 'package:cut_link_project/domain/models/LinkData.dart';
import 'package:get/get.dart';

import '../domain/usecases/link_usecases.dart';

class MainController extends GetxController {
  LinkUseCases linkUseCase = Get.find();
  var _linkList = <LinkData>[].obs;
  var _currentShortLink = ''.obs;

  List<LinkData> get linkList => _linkList;
  RxString  get currentShortLink => _currentShortLink;

  Future<void> getShortLink(link) async {
    _currentShortLink.value = '';
   var newShortLink = await linkUseCase.getShortLink(link);
   _currentShortLink.value = newShortLink;
  }

  Future<void> getAllLinks() async {
    var list = await linkUseCase.getAllLinks();
    _linkList.value = list;
  }
}