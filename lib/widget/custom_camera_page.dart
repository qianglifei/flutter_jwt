import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class CustomCameraPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomCameraPageState();
  }
}

class CustomCameraPageState extends State<CustomCameraPage> {



  CameraController controller;
  List<CameraDescription> cameras;

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void _camera() async{
    cameras = await availableCameras();
    if(cameras != null){
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _camera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cameras==null ? Container(
        child: Center(child: Text("加載中..."),),
      ) :
      Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
              Expanded(
                //flex 用来设置当前可用空间占优比
                flex: 3,
                child: Stack(
                  children: [
                    //相机预览Widget
                    _cameraPreviewWidget(),
                    //悬浮的身份证框图
                    _cameraIDCardFloatImage()
                  ],
                )
              ),
              Expanded(
                //flex用来设置当前可用空间的占优比
                flex: 1,
                //拍照操作区域布局
                child: Text("jalsdkjf"),

              ),
          ],
        ),
      ),
    );
  }

  Widget _cameraWidget(){
    return Expanded(
      flex: 1,
      child: Stack(
        children: <Widget>[
          _cameraPreviewWidget(),
          _cameraScan()
        ],
      ),
    );
  }

  ///相机预览图
  Widget _cameraPreviewWidget(){
     if(controller == null || !controller.value.isInitialized){
        return const Text(
          'Top a Camera',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        );
     }else{
        return new Container(
          width: double.infinity,
          //AspectRatio 根据设置调整子元素child 的宽高比
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
        );
     }
  }

  ///身份证预览图
  Widget _cameraIDCardFloatImage() {
    return new Positioned(
        child: new Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(50, 50, 50, 50),
          child:new Image.asset('images/icon_bg_identify_idcard.png'),
        ));
  }

  Widget _cameraScan(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Image.asset("images/scan.png"),
    );
  }

  Widget _cameraButton(){
    return GestureDetector(
      onTap: onTakePictureButtonPressed,
      child: Container(
        height: 70,
        color: Colors.black,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Text("返回",style: TextStyle(color: Colors.white)),
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                  onTap: onTakePictureButtonPressed,
                  child: Icon(Icons.camera_alt,color: Colors.white,size: 50)
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        if (filePath != null){
          Navigator.of(context).pop(filePath);
        }
      }
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      print('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      //await controller.takePicture(filePath);
    } on CameraException catch (e) {
      print("出现异常$e");
      return null;
    }
    return filePath;
  }


  Widget _takePictureLayout() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            RaisedButton(
                onPressed:(){

                },
              child: Text("拍照"),
            ),
            RaisedButton(
              onPressed:(){

              },
              child: Text("拍照"),
            ),
            RaisedButton(
              onPressed:(){

              },
              child: Text("拍照"),
            ),
            RaisedButton(
              onPressed:(){

              },
              child: Text("拍照"),
            ),
        ],
      ),
    );
  }

}