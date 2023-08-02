import 'package:cut_link_project/view/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';
import '../controllers/main_controller.dart';
import '../widgets/status_icon_widget.dart';
import 'historical_page.dart';

class MyHomePage extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;
  late BuildContext context;
  final controllerLinkTextField = TextEditingController();
  MainController mainController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    this.context = context;
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
      padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.02),
      child: Form(
      key: _formKey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _fieldLinkWidget(),
          _actionButton(),
          _historicalAccessWidget()
        ],
      ),
      )
    );
  }

  Widget _fieldLinkWidget() {
    return TextFormField(
      key: const Key('TextFieldLink'),
      controller: controllerLinkTextField,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Debe ingresar una url';
        }else if(_validateFromatLink(value)){
          return 'No es una url válida. Ejemplo: https://www.google.com';
        }
        return null;
      },
      decoration: const InputDecoration(
        filled: true,
        labelText: 'Ingrese el link',
        labelStyle: TextStyle( fontSize: 18),
      ),
      style: TextStyle(fontSize: 18),

    );
  }

  Widget _actionButton() {
    return Container(
      width: _deviceWidth,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          ),
      child: MaterialButton(
        onPressed: () async {
          if(_formKey.currentState!.validate()){
            var text = controllerLinkTextField.text;
            log.printInfo(info: "text $text");
            await mainController.getShortLink(text);
            _dialogBuilder(context, 'Su link es: ${mainController.currentShortLink.value}', StatusIconType.ok);
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
        key: Key('progressBarIndicator'),
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
                    color: Theme.of(context).focusColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationThickness: 2
                ),
                textAlign: TextAlign.center,
              ),
            ));
  }

  bool _validateFromatLink(String link){
    String pattern = r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = RegExp(pattern);
    return !regExp.hasMatch(link);
  }

  Future<void> _dialogBuilder(BuildContext context, String message, StatusIconType statusIconType) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return DialogWidget(statusIconType, message);
        });}
}