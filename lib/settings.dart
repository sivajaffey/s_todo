import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'main.dart';

class SettingsContent extends StatefulWidget {
  const SettingsContent({super.key});

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  var username = '';
  var password = '';
  String page = 'Login';
  var uid = getSession()?.uid;
  @override

  void initState () {
    print(this.uid);
    if (this.uid != null) {
      this.setState(() {
        this.page = 'loggedIn';
      });
    }
  }

  sendResetEmail() {
    if (this.username.trim() != "") {
          showDialog(context: context, builder: ((context) => Center(child:CircularProgressIndicator())));
          try {
            ResetPassword(this.username.trim(),context);
            setState(() {
              this.username = '';
            });
          } on FirebaseAuthException catch(e) {
            appAlert(context, 'Something went wrong',(){});
          }
        } else {
          appAlert(context, 'Enter valid email',(){});
        }
  }

  Register() {
    if (this.username.trim() == "" || this.password.trim() == "") {
      appAlert(context, 'Enter email and password',(){});
    } else {
      try {
        // showDialog(context: context, builder: ((context) => Center(child:CircularProgressIndicator())));
        RegisterUser(this.username.trim(),this.password.trim(), context);
      } on FirebaseAuthException catch(e) {
        appAlert(context, 'Something Went wrong',(){});
      }
     }
  }

  LoginApp () {
    try {
        if (this.username.trim() != "" && this.password.trim() != "") {
        setState(() {
           LoginUser(this.username.trim(),this.password.trim(), context);
        });
        } else {
          appAlert(context, 'Enter valid email and password',(){});
        }
      } on FirebaseAuthException catch(e) {
        appAlert(context, 'Something went wrong',(){});
      }
  }

  BackupProgress() {
    
  }
  
  RenderSettingsOnLogout () {
    switch(this.page) { 
      case "loggedIn": {
          return RenderSettingsOnLogin();
      }
      break;
      
      case "Forgot": { 
          return RenderForgotPassword();
      } 
      break; 
      
      case "Register": { 
          return RenderRegister();
      } 
      break; 

      case "Login": { 
          return RenderLogin();
      } 
      break; 
          
      default: { 
          return RenderSettingsOnLogin();
      }
      break; 
    } 
  }

  RenderSettingsOnLogin () {
    return Scaffold(
      appBar: AppBar(
        title : Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () =>  Navigator.pop(context),
        ), 
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(child: Align(alignment: Alignment.center ,child: Card(surfaceTintColor: Colors.grey[400] , child: 
      Container(child: Column(children: [
        SizedBox(height: 30.0,),
        ListTile(
              leading: Icon(Icons.backup),
              title: Text('Backup', style: TextStyle(color: Colors.black)),
              hoverColor:Colors.blue[200],
              subtitle:
                  Text('Click to Backup your progress.'),
              onTap: () => {
                BackupProgress(),
              },
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new_sharp),
              hoverColor:Colors.blue[200],
              title: Text('Logout', style: TextStyle(color: Colors.black)),
              onTap:() => {
                LogoutUser(),
                NavigatePage(MyApp(),context)
              },
            ),
          // SizedBox(height: 30.0,),
      ]),)
      ,),),),
    ],),
    );
  }
  RenderLogin() {
    return  Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () =>  NavigatePage('back', context),
            ), 
        ),
          body: Padding(padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${APPNAME}',
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 28.9,
              fontWeight:FontWeight.bold
            ),
          ),
          Text(
            'Login into app ( Backup you progress ) ',
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 15.0,
              fontWeight:FontWeight.bold
            ),
          ),
          SizedBox(height: 44.0,),
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Icon(Icons.mail, color: Colors.black87,)
            ),
            onChanged: (value) => setState((){this.username = value; })
          ),
          SizedBox(height: 26.0,),
          TextField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Password",
              prefixIcon: Icon(Icons.lock, color: Colors.black87,)
            ),
            onChanged: (value) => setState((){this.password = value; })
          ),
          SizedBox(height: 12.0,),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "Forgot password",
                    style: TextStyle(color: Colors.blue[300]),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        this.setState(() {
                          this.page = "Forgot";
                        });
                      }),
                TextSpan(
                    text: " Or ",
                    style: TextStyle(color: Colors.black87)),
                TextSpan(
                    text: "Register",
                    style: TextStyle(color: Colors.blue[300]),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        this.setState(() {
                          this.page = "Register";
                        });
                      }),
              ],
            ),
          ),
          SizedBox(height: 70.0,),
          Container(
            width: double.infinity,
            child: RawMaterialButton(onPressed:()=>{
              LoginApp(),
            }, 
                    child: Text('Login', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0
                    ),),
                    fillColor: Colors.blue[900],
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),),
          ),
        ],)
        ),
        );
    }
    RenderRegister() {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () =>  this.setState(() {
                          this.page = "Login";
                        }),
            ), 
        ),
        body: Padding(padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${APPNAME}',
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 28.9,
              fontWeight:FontWeight.bold
            ),
          ),
          Text(
            'Register with us',
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 15.0,
              fontWeight:FontWeight.bold
            ),
          ),
          SizedBox(height: 44.0,),
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Icon(Icons.mail, color: Colors.black87,)
            ),
            onChanged: (value) => setState((){this.username = value; })
          ),
          SizedBox(height: 26.0,),
          TextField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Password",
              prefixIcon: Icon(Icons.lock, color: Colors.black87,)
            ),
            onChanged: (value) => setState((){this.password = value; })
          ),
          // SizedBox(height: 12.0,),
          SizedBox(height: 40.0,),
          Container(
            width: double.infinity,
            child: RawMaterialButton(onPressed:Register, 
                    child: Text('Register', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0
                    ),),
                    fillColor: Colors.blue[900],
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),),
          ),
        ],)
        ),
        );
    }

    RenderForgotPassword() {
      return  Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () =>  this.setState(() {
                          this.page = "Login";
                        }),
            ), 
          ),
          body: Padding(padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${APPNAME}',
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 28.9,
              fontWeight:FontWeight.bold
            ),
          ),
          Text(
            'Forgot you password?',
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 15.0,
              fontWeight:FontWeight.bold
            ),
          ),
          SizedBox(height: 44.0,),
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Icon(Icons.mail, color: Colors.black87,)
            ),
            onChanged: (value) => setState((){this.username = value; })
          ),
          SizedBox(height: 12.0,),
          SizedBox(height: 88.0,),
          Container(
            width: double.infinity,
            child: RawMaterialButton(onPressed:sendResetEmail, 
                    child: Text('Send Reset Link to Email', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0
                    ),),
                    fillColor: Colors.blue[900],
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),),
          ),
        ],)
        ),
        );
    }

   Widget build(BuildContext context) {
    return RenderSettingsOnLogout();
  }
}

