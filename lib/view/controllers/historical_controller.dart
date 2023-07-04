import 'package:cut_link_project/domain/models/LinkData.dart';
import 'package:get/get.dart';
import 'dart:developer';
import '../../domain/usecases/link_usecases.dart';

class HistoricalController extends GetxController {
  LinkUseCases linkUseCase = Get.find();
  var _linkList = <LinkData>[].obs;

  List<LinkData> get linkList => _linkList;

  Future<void> getAllLinks() async {
    var list = await linkUseCase.getAllLinks();
    _linkList.value = list;
    int count = list.length;
    log.printInfo(info: "count $count");
  }
}