import 'package:cut_link_project/domain/repositories/link_repository.dart';
import 'package:get/get.dart';

class LinkUseCases{
  LinkRepository repository = Get.find();

  Future<String> getShortLink(String link) async =>
      await repository.getShortLink(link);
}