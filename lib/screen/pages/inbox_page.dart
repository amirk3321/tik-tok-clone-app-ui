import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class InboxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        return Scaffold(
          appBar: AppBar(
            title: Text("All activity"),
          ),
          body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.message,size: 90,),
                  SizedBox(height: 15,),
                  Text("Messages and notifications will appear here",style: TextStyle(fontSize: 16),),
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
