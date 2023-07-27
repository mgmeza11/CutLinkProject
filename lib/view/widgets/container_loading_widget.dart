import 'package:flutter/material.dart';
enum ContainerStatus{
  content,
  loading,
  empty
}

class ContainerLoadingWidgetConfiguration{
  ContainerLoadingWidgetConfiguration(this.status, this.loadingMessage, this.emptyMessage);
  ContainerStatus status;
  String? loadingMessage;
  String? emptyMessage;
}
class ContainerLoadingWidget extends StatelessWidget{

  ContainerLoadingWidget(this.content,  this.configuration);

  final Widget content;
  ContainerLoadingWidgetConfiguration configuration;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Visibility(
          visible: configuration.status == ContainerStatus.content,
            child: content),
        Visibility(
            visible: configuration.status == ContainerStatus.loading,
            child: _loadingWidget()),
        Visibility(
            visible: configuration.status == ContainerStatus.empty,
            child: content),
      ],
    );
  }

  Widget _loadingWidget(){
    String? loadingMessage = configuration.loadingMessage;
    return  Center(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.blue.shade200,
            valueColor: AlwaysStoppedAnimation(Colors.blue.shade400),
          ),
          if(loadingMessage!= null)
            Padding(
              padding: EdgeInsets.all(15), //apply padding to all four sides
              child: Text(
                loadingMessage!,
                style: const TextStyle(
                    color: Color.fromRGBO(2, 51, 83, 1.0),
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              ),
            )
        ],
      )
    );
  }



}