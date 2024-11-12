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
          index: _currentIndex,
          children: const [
            HomePage(),
            HomeList(),
            ErrorPage(),
            ErrorPage(),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle:
                const TextStyle(fontSize: 13, color: Colors.black),
            unselectedLabelStyle:
                const TextStyle(fontSize: 13, color: Colors.grey),
            currentIndex: _currentIndex,
            onTap: (value) {
              //点击切换页面
              _currentIndex = value;
              setState(() {});
            },
            items: _barItemList()),
      ),
    );
  }

  List<BottomNavigationBarItem> _barItemList() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: "热点"),
      BottomNavigationBarItem(icon: Icon(Icons.bolt), label: "体系"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "个人"),
    ];
  }
}
