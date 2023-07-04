import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';
import '../controllers/main_controller.dart';
import 'historical_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late double _deviceHeight, _deviceWidth;
  final controllerLinkTextField = TextEditingController();
  MainController mainController = Get.find();
  final _formKey = GlobalKey<FormState>();

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
                  children: [_titleWidget(),
                    Obx(() =>
                    mainController.isLoading.value ? _progressBarWidget() : _containerForm()
                    ),
                  ],
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
      height: _deviceHeight * 0.33,
      padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.03),
      child: Form(
      key: _formKey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _fieldLinkWidget(),
          _textShortLinkResultWidget("shortLink"),
          _actionButton(),
          _historicalAccessWidget()
        ],
      ),
      )
    );
  }

  Widget _fieldLinkWidget() {
    return TextFormField(
      key: Key('TextFieldLink'),
      controller: controllerLinkTextField,
      validator: (value){
        String pattern = r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
        RegExp regExp = RegExp(pattern);
        if (value == null || value.isEmpty) {
          return 'Debe ingresar una url';
        }else if(!regExp.hasMatch(value)){
          return 'No es una url válida. Ejemplo: https://www.google.com';
        }
        return null;
      },
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
          if(_formKey.currentState!.validate()){
            var text = controllerLinkTextField.text;
            log.printInfo(info: "text $text");
            mainController.getShortLink(text);
          }

        },
        child: const Text(
          "Acortar link",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _progressBarWidget(){
    return  Container(
      padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.05),
      child: LinearProgressIndicator(
        backgroundColor: Colors.blue.shade200,
        valueColor: AlwaysStoppedAnimation(Colors.blue.shade400),
        minHeight: 15,
      ),
    );
  }

  Widget _historicalAccessWidget() {
    return
        Container(
            width: _deviceWidth,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoricalPage()),
                );
              },
              child: Text(
                'Ver histórico',
                style:
                TextStyle(
                    color: Color.fromRGBO(2, 51, 83, 1.0),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationThickness: 2
                ),
                textAlign: TextAlign.center,
              ),
            ));
  }
}