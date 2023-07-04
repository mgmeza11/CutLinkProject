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
      body: SafeArea(
        child: Container(
            height: _deviceHeight,
            width: _deviceWidth,
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
            child:
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleWidget(),
                    _getXlistView()
                  ],
                ),

            ),
      ),
    );
  }

  Widget _titleWidget() {
    return const Text(
      "#CutLink",
      style: TextStyle(
          color: Color.fromRGBO(52, 152, 219, 1.0),
          fontSize: 70,
          fontWeight: FontWeight.w800),
    );
  }



  Widget _getXlistView() {
    return SizedBox(
      height: _deviceHeight * 0.7,
      child: Obx(
            () => ListView.builder(
          itemCount: historicalController.linkList.length,
          itemBuilder: (context, index) {
            final user = historicalController.linkList[index];
            return Card(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(user.link,
                    style:
                    TextStyle(
                        color: Color.fromRGBO(2, 51, 83, 1.0),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2
                    ),
                  )
              ),
            );
          },
        ),
      ),
    );

  }
}