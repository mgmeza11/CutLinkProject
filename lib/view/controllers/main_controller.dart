import 'package:cut_link_project/domain/models/LinkData.dart';
import 'package:get/get.dart';

import '../../domain/usecases/link_usecases.dart';

class MainController extends GetxController {
  LinkUseCases linkUseCase = Get.find();
  var _linkList = <LinkData>[].obs;
  final _currentShortLink = ''.obs;
  final _isLoading = false.obs;

  List<LinkData> get linkList => _linkList;
  RxString  get currentShortLink => _currentShortLink;
  RxBool get isLoading => _isLoading;

  Future<void> getShortLink(link) async {
    _currentShortLink.value = '';
    _isLoading.value = true;
   var newShortLink = await linkUseCase.getShortLink(link);
   _currentShortLink.value = newShortLink;
   _isLoading.value = false;
  }

  Future<void> getAllLinks() async {
    var list = await linkUseCase.getAllLinks();
    _linkList.value = list;
  }
}