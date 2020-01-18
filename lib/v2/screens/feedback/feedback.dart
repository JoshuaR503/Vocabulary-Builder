import 'dart:io';

import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';

import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/device/android.dart';

class FeedbackScreen extends StatelessWidget {

  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final TextStyle labelTextStyle = TextStyle(
    color: Colors.white70,
    fontSize: 18,
    fontWeight: FontWeight.w700
  );

  void androidHandler() async {
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final AndroidDeviceData deviceData = AndroidDeviceData(
      device: androidInfo.device,
      host: androidInfo.host,
      model: androidInfo.model,
      manufacturer: androidInfo.manufacturer,
      type: androidInfo.type,
      sdk: androidInfo.version.sdkInt,
    );

    print(deviceData.toMap());
  }

  void handler() async {
    if (Platform.isAndroid) {
      this.androidHandler();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.tealAccent,
        title: Text('Feedback'),
      ),

      body: SafeArea(
        child: Container(
          color: Theme.of(context).accentColor,

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView(

            
              children: <Widget>[

                SizedBox(height: 40),

                Text(
                  'Send Feedback', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32
                  )
                ),
                
                SizedBox(height: 40),


                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
            
                  decoration:BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),

                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(fontSize: 15.5),
                      border: InputBorder.none,
                    ),
  
                    onFieldSubmitted: (value) {}
                  )
                ),

                SizedBox(height: 20),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
            
                  decoration:BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),

                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email (optional)',
                      hintStyle: TextStyle(fontSize: 15.5),
                      border: InputBorder.none,
                    ),
  
                    onFieldSubmitted: (value) {}
                  )
                ),

                SizedBox(height: 20),


                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
            
                  decoration:BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),

                  child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Comment',
                      hintStyle: TextStyle(fontSize: 15.5),
                      border: InputBorder.none,
                    ),
  
                    onFieldSubmitted: (value) {}
                  )
                ),

                SizedBox(height: 20),

                MaterialButton(
                  height: 50,
                  onPressed: () => this.handler(),
                  child: Text(
                    'Submit',
                  
                  ),
                  color: Color(0XFF05985f),
                )


                



                

                

              ],

            ),
          ),
        ),
      ),


    );
  }
}