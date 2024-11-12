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