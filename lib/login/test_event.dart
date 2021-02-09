part of 'test_bloc.dart';
///这里执行的是各种事件，有点类似fish_redux的action 层
@immutable
abstract class TestEvent extends Equatable{
    const TestEvent();
}
///切换NavigationRail的tab
class SwitchTabEvent extends TestEvent{
  final int selectedIndex;
  const SwitchTabEvent({@required this.selectedIndex});

  @override
  // TODO: implement props
  List<Object> get props => [selectedIndex];

}
///展开NavigationRail，这个逻辑比较简单，就不用传参数
class IsExtendEvent extends TestEvent{
  const IsExtendEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}