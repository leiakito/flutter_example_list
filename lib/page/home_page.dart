import 'package:example_list/route/RouteUtils.dart';
import 'package:example_list/route/error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
   return   Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
           RouteUtils.pushForNamed(context, "/error");
          },
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        )
      ),
    );
  }
}
