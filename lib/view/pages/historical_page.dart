import 'package:cut_link_project/view/widgets/container_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/historical_controller.dart';

class HistoricalPage extends StatefulWidget {
  const HistoricalPage({super.key});

  @override
  State<HistoricalPage> createState() => _HistoricalPageState();
}

class _HistoricalPageState extends State<HistoricalPage> {
  late double _deviceHeight, _deviceWidth;
  final controllerLinkTextField = TextEditingController();
  HistoricalController historicalController = Get.find();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    historicalController.getAllLinks();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: _titleWidget(),
      ),
      body: SafeArea(
        child: Obx(() => ContainerLoadingWidget(
              Container(
                height: _deviceHeight,
                width: _deviceWidth,
                padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_getXlistView()],
                ),
              ),
              historicalController.statusLoading.value,
            )),
      ),
    );
  }

  Widget _titleWidget() {
    return const Text(
      "#CutLink",
      style: TextStyle(
          color: Color.fromRGBO(52, 152, 219, 1.0),
          fontSize: 30,
          fontWeight: FontWeight.w800),
    );
  }

  Widget _getXlistView() {
    return SizedBox(
      height: _deviceHeight * 0.7,
      child: ListView.builder(
          itemCount: historicalController.linkList.length,
          itemBuilder: (context, index) {
            final link = historicalController.linkList[index];
            return ListTile(
              enabled: false,
              leading: const CircleAvatar(
                backgroundImage: AssetImage("assets/images/link_icon.png"),
              ),
              title: Text(link.shortLink!,
                style: const TextStyle(
                    color: Color.fromRGBO(52, 152, 219, 1.0),
                    fontSize: 16),
              ),
              subtitle: Text(link.originalLink,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16),),
              trailing: IconButton(
                onPressed: () { 
                  
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,),
                
              ),
            );
          },
        ),
    );
  }
}
