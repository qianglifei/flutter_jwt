import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'test_event.dart';
part 'test_state.dart';
///主要写逻辑的页面
///state 是框架内部定义的，会默认保存上一次同步的MainState对象的值
class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestState(selectedIndex :0,isExtended: false));

  @override
  Stream<TestState> mapEventToState(TestEvent event) async* {
    // TODO: implement mapEventToState
    // test_view 中添加的事件，会在此处回掉，此处处理完数据，将数据yield，BlocBuilder就会刷新组件
    if(event is SwitchTabEvent){
      //获取到event 事件传递过来的值，我们拿到值，把他塞进MainState中
      //直接在state直接改变内部的值，然后yield，只能出发一次BlocBuilder，他内部会比较上次的MainState对象
      //如果相同就不build
      yield TestState()
            ..selectedIndex  = event.selectedIndex
            ..isExtended = state.isExtended;
    }else if(event is IsExtendEvent){
      yield TestState()
          ..selectedIndex = state.selectedIndex
          ..isExtended = !state.isExtended;
    }
  }
}
