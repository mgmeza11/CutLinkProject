import 'package:cut_link_project/domain/models/LinkData.dart';
import 'package:cut_link_project/view/widgets/container_loading_widget.dart';
import 'package:get/get.dart';
import 'dart:developer';
import '../../domain/usecases/link_usecases.dart';

class HistoricalController extends GetxController {
  LinkUseCases linkUseCase = Get.find();

  final _linkList = <LinkData>[].obs;
  List<LinkData> get linkList => _linkList;

  final _statusLoading = ContainerLoadingWidgetConfiguration(ContainerStatus.content, null, null).obs;
  Rx<ContainerLoadingWidgetConfiguration> get statusLoading => _statusLoading;

  Future<void> getAllLinks() async {
    try{
      setLoadingStatus('Obteniendo lista de links...');
      var list = await linkUseCase.getAllLinks();
      _linkList.value = list;
      if(list.isEmpty){
        setEmptyStatus('No se han encontrado links');
      }else{
        showContent();
      }
    }catch(ex){
      print(ex);
      setEmptyStatus('Ha ocurrido un error');
    }

  }

  void setLoadingStatus(String? loadingMessage){
    ContainerLoadingWidgetConfiguration currentStatus = _statusLoading.value;
    currentStatus.status = ContainerStatus.loading;
    currentStatus.loadingMessage = loadingMessage;
    _statusLoading.value = currentStatus;
  }

  void setEmptyStatus(String? emptyMessage){
    ContainerLoadingWidgetConfiguration currentStatus = _statusLoading.value;
    currentStatus.status = ContainerStatus.empty;
    currentStatus.emptyMessage = emptyMessage;
    _statusLoading.value = currentStatus;
  }

  void showContent(){
    ContainerLoadingWidgetConfiguration currentStatus = _statusLoading.value;
    currentStatus.status = ContainerStatus.content;
    _statusLoading.value = currentStatus;
  }
}