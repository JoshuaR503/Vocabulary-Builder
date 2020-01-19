import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';

import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/device/android.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _commentTextController = TextEditingController();

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
    Scaffold
    .of(context)
    .showSnackBar(SnackBar(content: Text('Thank you for your comments')));
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _emailTextController.dispose();
    _commentTextController.dispose();
    super.dispose();
  }

  Widget _titleField() {
    return Container(
      padding:EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 5),
      decoration:BoxDecoration(
        shape: BoxShape.rectangle,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: TextFormField(
        controller: _titleTextController,
        decoration: InputDecoration(
          hintText: 'Title',
          hintStyle: TextStyle(fontSize: 15.5),
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      )
    );
  }

  Widget _emailField() {
    return Container(
      padding:EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 5),
      decoration:BoxDecoration(
        shape: BoxShape.rectangle,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: TextFormField(
                controller: _emailTextController,

        decoration: InputDecoration(
          hintText: 'Email (optional)',
          hintStyle: TextStyle(fontSize: 15.5),
          border: InputBorder.none,
        ),
      )
    );
  }

  Widget _comentField() {
    return Container(
      padding:EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 5),
      decoration:BoxDecoration(
        shape: BoxShape.rectangle,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: TextFormField(
                controller: _commentTextController,

          keyboardType: TextInputType.multiline,
          maxLines: 5,
        decoration: InputDecoration(
          hintText: 'Comment',
          hintStyle: TextStyle(fontSize: 15.5),
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.indigo,
        title: Text('Feedback'),
      ),

      body: Builder(
        builder: (ctx) => SafeArea(
          child: Container(
            color: Theme.of(ctx).accentColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
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
                    this._titleField(),
                    SizedBox(height: 20),
                    this._emailField(),
                    SizedBox(height: 20),
                    this._comentField(),

                    SizedBox(height: 20),
                    MaterialButton(
                      height: 50,
                      child: Text('Submit' ),
                      color: AppColors.indigo,
                      onPressed: () {

                        if (_formKey.currentState.validate()) {

                          print(this._titleTextController.text);


                          final Text content = Text(
                            'Feedback sent!',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          );

                          Scaffold
                          .of(ctx)
                          .showSnackBar(SnackBar(content: content, backgroundColor: AppColors.snackBar));
                        }
                      },
                    )
                  ],
                ),
              )
            ),
          ),
        )
      )
    );
  }
}
