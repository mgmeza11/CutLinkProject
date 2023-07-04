import 'package:cut_link_project/domain/repositories/link_repository.dart';
import 'package:cut_link_project/domain/usecases/link_usecases.dart';
import 'package:cut_link_project/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

void main() {
  Get.put(LinkRepository());
  Get.put(LinkUseCases());
  Get.put(MainController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CutLink',
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(213, 216, 220, 1.0)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late double _deviceHeight, _deviceWidth;
  final controllerLinkTextField = TextEditingController();
  MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: _deviceHeight,
            width: _deviceWidth,
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: _imageWidget(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_titleWidget(), _containerForm()],
                ),
              ],
            )),
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

  Widget _imageWidget() {
    return Container(
      width: _deviceWidth * 0.7,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage("assets/images/link_icon.png"))),
    );
  }

  Widget _containerForm() {
    return Container(
      height: _deviceHeight * 0.25,
      padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _fieldLinkWidget(),
          _textShortLinkResultWidget("shortLink"),
          _actionButton(),
        ],
      ),
    );
  }

  Widget _fieldLinkWidget() {
    return TextField(
      key: Key('TextFieldLink'),
      controller: controllerLinkTextField,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: 'Ingrese el link',
        labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
      ),
      style: TextStyle(fontSize: 18, color: Colors.black),
    );
  }

  Widget _textShortLinkResultWidget(String shortLink) {

    return Obx(() =>
        Container(
            width: _deviceWidth,
            child: Text(
              mainController.currentShortLink.value,
              style:
              TextStyle(
                  color: Color.fromRGBO(52, 152, 219, 1.0),
                  fontSize: 18),
              textAlign: TextAlign.left,
            ))
    );
  }

  Widget _actionButton() {
    return Container(
      width: _deviceWidth,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(52, 152, 219, 1.0),
          borderRadius: BorderRadius.circular(10)),
      child: MaterialButton(
        onPressed: () {
          var text = controllerLinkTextField.text;
          log.printInfo(info: "text $text");
          mainController.getShortLink(text);
        },
        child: const Text(
          "Acortar link",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
