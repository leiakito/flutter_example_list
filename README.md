# flutter组件融合基本示例

## 底部导航栏BottomNavigationBar+IndexedStack管理底部导航对应的页面

——————————————————————————————————————————————————————————————————————

第一步

> Routes管理类，tab, homepage,home list error对应页面 添加新页面则添加 case

## 主要涉及的类为 routes routeUtils app  

```dart
import 'package:example_list/page/home_list.dart';
import 'package:example_list/page/home_page.dart';
import 'package:example_list/page/tab_page.dart';
import 'package:flutter/material.dart';
import 'error.dart';
//路由管理类
class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutePath.tab:
          return pageRoute( TabPage(),settings: settings);
      case RoutePath.homepage:
        // return pageRoute( WebViewPage(title: '', url: '',),settings: settings);
        return pageRoute(const HomePage(),settings: settings);
      case RoutePath.homelist:
        // return pageRoute( const LoginPage(),settings: settings);
        return pageRoute(const HomeList(),settings: settings);
      case RoutePath.error:
      // return pageRoute( const LoginPage(),settings: settings);
        return pageRoute( const ErrorPage(),settings: settings);
    }
    //路由不存在则返回一张图片
    return pageRoute(const ErrorPage());
  }

    static MaterialPageRoute pageRoute(Widget page,{
      RouteSettings?settings,
      bool? fullscreenDialog,
      bool? maintainState,
      bool? allowSnapshotting
    }){
      return MaterialPageRoute(builder: (context){
        return page;
      },
      settings: settings,
        fullscreenDialog: fullscreenDialog ?? false,
        maintainState: maintainState ?? true,
        allowSnapshotting: allowSnapshotting ?? true
      );
    }

}

//路由地址
class RoutePath{
    //首页
    static const String tab="/";

    static const String homepage="home_page";

    static const String homelist="home_list";
    static const String error ='error';
}
```

第二步

> app.dart  tab_page.dart

在app页面中 将动态生成路由表，默认路由页面，`任何地方通过 navigatorKey.currentState 访问 Navigator`

```dart
 Size get designSize{
  final firstView =WidgetsBinding.instance.platformDispatcher.views.first;
  //逻辑短边
  final logicalShortSide=firstView.physicalSize.shortestSide/firstView.devicePixelRatio;
  //逻辑长边
  final logicalLongSide=firstView.physicalSize.longestSide/firstView.devicePixelRatio;
  //缩放比例 desginSize越小 元素越大
  const scaleFactor =0.95;
  //缩放后的逻辑短边和长边
  return  Size(logicalShortSide*scaleFactor,logicalLongSide*scaleFactor);
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //toast提示必须作为APP顶层组件
    return OKToast(
        child: ScreenUtilInit(
          designSize: designSize,
          builder: (context,child){
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              // home: const HomePage(),
              //动态生成路由，当你使用命名路由，在路由表中寻找
              onGenerateRoute: Routes.generateRoute,
              //默认路由页面
              initialRoute: RoutePath.tab,
              navigatorKey: RouteUtils.navigatorKey,
            );
          },
        )
    );
  }
}
```

第三步 tab_page

bottomnavigationBar + IndexedStack 设置主页面

```dart
import 'package:example_list/page/home_list.dart';
import 'package:example_list/page/home_page.dart';
import 'package:example_list/route/RouteUtils.dart';
import 'package:example_list/route/error.dart';
import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}
//底部导航栏的索引，用于索引当前显示的页面
int _currentIndex = 0;

class _TabPageState extends State<TabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex, //索引位置
          children: const [
            HomePage(),  //几个页面
            HomeList(),
            ErrorPage(),
            ErrorPage(),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, highlightColor: Colors.transparent,),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(
                fontSize: 13, color: Colors.black),
            unselectedLabelStyle: const TextStyle(
                fontSize: 13, color: Colors.grey),
            currentIndex: _currentIndex, //索引位置 
            onTap: (value) {
              //点击切换页面
              _currentIndex = value; //点击事件，根据value更改索引值
              setState(() {}); //更新状态方法 
            },
            items: _barItemList()),
      ),
    );
  }
  List<BottomNavigationBarItem>_barItemList(){
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: "热点"),
      BottomNavigationBarItem(icon: Icon(Icons.bolt), label: "体系"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "个人"),
    ];
  }

}

```
