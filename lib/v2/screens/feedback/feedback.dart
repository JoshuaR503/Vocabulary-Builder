import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/repositories/feedback/feedback_client.dart';
import 'package:vocabulary_builder/v2/screens/feedback/helpers/platform.dart';
import 'package:vocabulary_builder/v2/screens/feedback/widgets/field.dart';

// TODO: Translate
class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  /// Widget related.
  bool _isButtonDisabled = false;
 
  /// Form realted.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _commentTextController = TextEditingController();

  /// Helpers.
  final PlatfromHelper _platfromHelper = PlatfromHelper();
  final FeedbackApiClient _feedbackApiClient = FeedbackApiClient();

  /// Makes HTTP request and returns an integer.
  Future<int> handler() async {
    final dynamic deviceData = 
      Platform.isAndroid ? await this._platfromHelper.androidHandler()
    : Platform.isIOS ? await this._platfromHelper.iosHandler()
    : null;

    return await _feedbackApiClient.post(data: {
      'title': this._titleTextController.text,
      'email': this._emailTextController.text,
      'text': this._commentTextController.text,
      'device_data': deviceData
    });
  }

  @override
  void dispose() {
    this._titleTextController.dispose();
    this._emailTextController.dispose();
    this._commentTextController.dispose();
    super.dispose();
  }

  /// Cleans controllers' text.
  void clean() {
    this._titleTextController.clear();
    this._emailTextController.clear();
    this._commentTextController.clear();
  }

  /// Disables the submit button.
  void disable() {
    setState(() => this._isButtonDisabled = true);
  }

  /// Submit button handler.
  void buttonHandler(BuildContext ctx) async {

    if (_formKey.currentState.validate()) {

      final int response = await this.handler();
      final String text = response == 1 
      ? 'Feedback sent'
      : 'There was an error';
    
      this.clean();
      this.disable();

      Scaffold
      .of(ctx)
      .showSnackBar(
        SnackBar(
          content: Text(text, style: TextStyle(color: Colors.white)), 
          backgroundColor: AppColors.snackBar,
        )
      );
    }
  }
  
  /// Title widger.
  Widget _title() {
    return Text(
      'Send Feedback', 
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 32
      )
    );
  }

  /// Main Function
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
                    this._title(),

                    SizedBox(height: 40),
                    FieldManager(text: 'Title', controller: _titleTextController),
                    
                    SizedBox(height: 20),
                    FieldManager(text: 'Email (optional)', controller: _emailTextController, isRequired: false),

                    SizedBox(height: 20),
                    FieldManager(text: 'Comment', controller: _commentTextController, maxLines: 5),

                    SizedBox(height: 20),
                    
                     MaterialButton(
                      height: 50,
                      child: Text('Submit'),
                      color: AppColors.indigo,
                      disabledColor: AppColors.kIndigoAccent,
                      onPressed: this._isButtonDisabled 
                      ? null 
                      : () => this.buttonHandler(ctx),
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
