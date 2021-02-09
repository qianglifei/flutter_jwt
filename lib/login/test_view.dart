import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt/login/test_bloc.dart';
class TestPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // 创建BlocProvider的，表明该Page，我们是TestBloc，TestBloc 是属于该页面的bloc
    return BlocProvider(
      create: (BuildContext context){
        return TestBloc();
      },
      child: BodyPage(),
    );
  }

}

class BodyPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Bloc")),
      body: totalPage(),
    );
  }

}
Widget totalPage() {
  return Row(
    children: [
      navigationRailSide(),
      Expanded(child: Center(
        child: BlocBuilder<TestBloc, TestState>(builder: (context, state) {
          ///看这看这：刷新组件！
          return Text("selectedIndex:" + state.selectedIndex.toString());
        }),
      ))
    ],
  );
}

//增加NavigationRail组件为侧边栏
Widget navigationRailSide() {
  //顶部widget
  Widget topWidget = Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage("https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3383029432,2292503864&fm=26&gp=0.jpg"),
                fit: BoxFit.fill),
          )),
    ),
  );

  //底部widget
  Widget bottomWidget = Container(
    child: BlocBuilder<TestBloc, TestState>(
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: () {
            ///添加NavigationRail展开,收缩事件
            BlocProvider.of<TestBloc>(context).add(IsExtendEvent());
          },
          ///看这看这：刷新组件！
          child: Icon(state.isExtended ? Icons.send : Icons.navigation),
        );
      },
    ),
  );

  return BlocBuilder<TestBloc, TestState>(builder: (context, state) {
    return NavigationRail(
      backgroundColor: Colors.white12,
      elevation: 3,
      ///看这看这：刷新组件！
      extended: state.isExtended,
      labelType: state.isExtended ? NavigationRailLabelType.none : NavigationRailLabelType.selected,
      //侧边栏中的item
      destinations: [
        NavigationRailDestination(
            icon: Icon(Icons.add_to_queue),
            selectedIcon: Icon(Icons.add_to_photos),
            label: Text("测试一")),
        NavigationRailDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: Text("测试二")),
        NavigationRailDestination(
            icon: Icon(Icons.bubble_chart),
            selectedIcon: Icon(Icons.broken_image),
            label: Text("测试三")),
      ],
      //顶部widget
      leading: topWidget,
      //底部widget
      trailing: bottomWidget,
      selectedIndex: state.selectedIndex,
      onDestinationSelected: (int index) {
        ///添加切换tab事件
        BlocProvider.of<TestBloc>(context).add(SwitchTabEvent(selectedIndex: index));
      },
    );
  });
}