import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jwt/http/dio_utils.dart';
import 'package:jwt/utils/encode_utils.dart';
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
  String _photoBase64 = "";
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
                  flex: 1,//flex用来设置当前可用空间的占优比
                  child: _takePictureLayout(),//拍照操作区域布局
                ),
              ],
            ),
          ),
          getPhotoPreview(),//图片预览布局
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
          height: ScreenUtil().uiSize.height,
          width: ScreenUtil().uiSize.width,
          color: Colors.black,
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
                //保存图片
                _savePicture(_photoPath);
                //把照片变为Base64字符串
                EncodeUtil.image2Base64(_photoPath).then((value) {
                   _photoBase64 = value;
                   print(_photoBase64);
                });
              }else{
                _cameraPreviewLayoutIsVisible = true;
              }
          });
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
                    setState(() {
                      _cameraPreviewLayoutIsVisible = true;
                      _photoBase64 = "";
                      _photoPath = "";
                    });
                  },
                  child: Text("删除"),
                ),
                RaisedButton(
                  color: Colors.amberAccent,
                  onPressed: () {
                    Map<String,dynamic> requestBody = new Map();
                    requestBody.addAll({
                      "app_id": "ocr2cd56676a4904f27",
                      "idcard": _photoBase64
                    });
                    FormData data = FormData.fromMap(requestBody);
//                   //请求网络
//                   DioUtils.instance.postHttp(
//                       url: "http://ocr.beikongyun.com/ocr/api/idcardocr/base64",
//                       method: DioUtils.POST,
//                       parameters:data,
//                       onSuccess: (data){
//                          print(data);
//                          Navigator.of(context).pop();
//                       },
//                      onError: (error){
//                        print(error);
//                      }
//                   );
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
            width:ScreenUtil().uiSize.width,
            height: ScreenUtil().setWidth(1800),
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

  ///保存并且裁切图片
  Future<String> _savePicture(String imagePath) async {
    //我们需要将图像保存在内存储目录中，以便在图库中显示图像，代替获取临时目录，而获取存储目录。
    final directory = await getApplicationDocumentsDirectory();
    //我们要创造一个名叫MyImages的文件夹，并将新图像添加到该文件夹中
    final myImagePath = '${directory.path}/MyImages';
    await new Directory(myImagePath).create();
    //然后创建新的文件名
    final String filePath = '$myImagePath/${timestamp()}.jpg';
    File file = new File(imagePath);
    //把临时文件 复制到自己的文件夹中
    file.copy(filePath);

    return filePath;
  }

//  Future<String> _cutPicture(String filePath) async{
//    ByteData byteData = await filePath.getByteData(quality: 80);
//    return "";
//  }



}