import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
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
  String _photoPath ="";
  bool _cameraLayoutIsVisible = false;
  bool _cameraPreviewLayoutIsVisible = true;
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
        child: Stack(children: <Widget>[
          getPhotoPreview(),//图片预览布局
          Offstage(
            offstage: _cameraLayoutIsVisible,
            child: Column(
              children: <Widget>[
                Expanded(
                  //flex 用来设置当前可用空间占优比
                    flex: 4,
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
                  child: Expanded(
                    flex: 1,//flex用来设置当前可用空间的占优比
                    child: _takePictureLayout(),//拍照操作区域布局
                  ),
                ),
              ],
            ),
          )
        ])
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
          height: ScreenUtil().uiSize.height * 3 /4,
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
          child:new Image.asset(
              'images/icon_bg_identify_idcard.png',
              height: ScreenUtil().setWidth(1000),
              width: ScreenUtil().setHeight(1500),
              fit: BoxFit.contain,
          ),
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
    // 强制竖屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile filePath) {
      if (mounted) {
        if (filePath != null){
          setState(() {
            _photoPath = filePath.path;
            print(filePath.path);
              if(_photoPath != null && _photoPath != ""){
                _cameraPreviewLayoutIsVisible = false;
                _cameraLayoutIsVisible = true;
                //保存图片
                _savePicture(_photoPath);
              }else{
                _cameraPreviewLayoutIsVisible = true;
                _cameraLayoutIsVisible = false;
              }
          });
//          Navigator.of(context).pop(filePath.path);
        }
      }
    });
  }

  Future<XFile> takePicture() async {
    if (!controller.value.isInitialized) {
      print('Error: select a camera first.');
      return null;
    }
    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      XFile file = await controller.takePicture();
      return file;
    } on CameraException catch (e) {
      print("出现异常$e");
      return null;
    }
  }


  Widget _takePictureLayout() {
    return RotatedBox(
        quarterTurns: 1,
        child:
        Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RaisedButton(
                  color: Colors.amberAccent,
                  onPressed: () {

                  },
                  child: Text("删除"),
                ),
                RaisedButton(
                  color: Colors.amberAccent,
                  onPressed: () {

                  },
                  child: Text("确认"),
                ),
                RaisedButton(
                  color: Colors.amberAccent,
                  onPressed: () {

                  },
                  child: Text("重拍"),
                ),
                RaisedButton(
                  color: Colors.amberAccent,
                  onPressed: () {
                    onTakePictureButtonPressed();
                  },
                  child: Text("拍照"),
                ),
              ],
            )
        )
        );
   }

  Widget getPhotoPreview(){
    if( null != _photoPath){
      return Offstage (
          offstage: _cameraPreviewLayoutIsVisible, // 设置是否可见：true:不可见 false:可见
          child: new Container(
            width:double.infinity,
            height: double.infinity,
            color: Colors.black,
            alignment: Alignment.center,
            child: Image.file(File(_photoPath)),
          )
      );
    }else{
      return new Container(
        height: 1.0,
        width: 1.0,
        color: Colors.black,
        alignment: Alignment.bottomLeft,
      );
    }
  }

  ///保存图片
  Future _savePicture(String imagePath) async{
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/ID_Card';
    print(dirPath);
    await Directory(dirPath).create(recursive: true);
    String filePath = '$dirPath/${timestamp()}.jpg';
  }

}