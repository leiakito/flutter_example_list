import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'route/routeUtils.dart';
import 'route/routes.dart';

//设计尺寸
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
