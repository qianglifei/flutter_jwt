import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


// ignore: must_be_immutable
class CustomButton extends StatefulWidget{
  double width;
  double height;
  double radius;
  Color colors;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomButtonState(this.width,this.height,this.colors = Colors.white);
  }

}

class CustomButtonState extends State<CustomButton>{
  CustomButtonState(double width, double height, Color color);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:
      ),
    );
  }

}