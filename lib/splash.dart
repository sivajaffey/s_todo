
import 'dart:async';
import 'package:flutter/material.dart';
import 'database.dart';
import 'home.dart';  

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
   SplashScreenState createState() => SplashScreenState();  
  // State<Splash> createState() => _SplashState();
}
class SplashScreenState extends State {  
  @override  
  void initState() {  
    super.initState();  
    Timer(Duration(seconds: 3),  
            ()=>Navigator.pushReplacement(context,  
            MaterialPageRoute(builder:  
                (context) => MyHomePage()  
            )  
         )  
    );  
  }  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(
      body: Container(  
        color: Colors.blue[900],  
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Align(alignment: Alignment.center,child: 
                Icon(Icons.check_circle_outline, size: 100, color: Colors.white,),
            ),
            Align(alignment: Alignment.center,child: 
                Text('${APPNAME}',style: TextStyle(fontFamily: "NexaRegular", color: Colors.white,fontSize: 45.0,
              fontWeight:FontWeight.bold),),
            ),
            Align(alignment: Alignment.center,child: 
                Text('${APPESC}',style: TextStyle(fontFamily: "NexaRegular", color: Colors.white,fontSize: 18.0,
              fontWeight:FontWeight.bold),),
            )
          ],
        ),
      )
    );
  }  
}  