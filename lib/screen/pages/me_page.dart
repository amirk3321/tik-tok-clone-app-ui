import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
            actions: <Widget>[
              Icon(Icons.more_vert)
            ],
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.person,size: 90,),
                SizedBox(height: 15,),
                Text("Sign up for an account",style: TextStyle(fontSize: 16),),
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 80),
                  padding: EdgeInsets.symmetric(horizontal: 80,vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Text("Sign up",style: TextStyle(fontSize: 18),),
                )
              ],
            )
          ),
        );
      },
    );
  }
}
