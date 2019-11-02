import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/translation/bloc.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';

import 'package:vocabulary_builder/v2/widgets/components/spinner.dart';

class TranslatorScreen extends StatefulWidget {
  @override
  _TranslatorScreenState createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {

  bool shouldShowResponse = false;

  String _firstLanguage = "English";
  String _secondLanguage = 'Spanish';

  // Methods

  void _changeLanguage() {
    if (_firstLanguage == 'Spanish') {
      setState(() => {
        this._firstLanguage = 'English',
        this._secondLanguage = 'Spanish'
      });
    } 
    
    if (_secondLanguage == 'English') {
      setState(() => {
        this._firstLanguage = 'Spanish',
        this._secondLanguage = 'English'
      });
    } 
    
  }

  void _changeState() async {
    setState(() => this.shouldShowResponse = true);
  }

  void _submitHandler(String text) async {
    this._changeState();

    BlocProvider
      .of<TranslationBloc>(context)
      .add(TranslationText(
        sl: 'en',
        tl: 'es',
        text: text
      ));
  }
  
  // Helpers
  Widget _buildCard({Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Card(
        color: Colors.white10,
        margin: EdgeInsets.all(0.0),
        elevation: 2.0,
        child: child
      )
    );
  }

  BlocBuilder<TranslationBloc, TranslationState> _buildTranslationSaved() {
    return BlocBuilder<TranslationBloc, TranslationState>(
      builder: (BuildContext context, TranslationState state) {

        if (state is LoaedTranslationSavedState) {

          return SelectableText(
            state.translation, 
            style:TextStyle(
              fontSize: 21,
              color: Colors.white,
            )
          );
        }

        return VocabularyBuilderSpinner(color: AppColors.tealAccent);
      }
    );
  }

  // Actual Widgets
  Widget _languages() {
    return Container(
 
      height: 55.0,
      color: AppColors.snackBar,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Material(
              color: AppColors.snackBar,
              child: Center(
                child: Text(
                  this._firstLanguage,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),

          Material(
            color: AppColors.snackBar,
            child: IconButton(
              icon: Icon(
                Icons.compare_arrows,
                color: Colors.white
              ),
              onPressed: () => _changeLanguage(),
            ),
          ),

          Expanded(
            child: Material(
              color: AppColors.snackBar,
              child: Center(
                child: Text(
                  this._secondLanguage,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              )
            ),
          ),
        ],
      )
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: TextField(
        maxLines: null,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20
        ),

        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type here..',
        ),

        onSubmitted: (value) => {
          if (value.length > 1) {
            _submitHandler(value)
          }
        },
      ),
    );
  }

  Widget _buildTranslation() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: _buildTranslationSaved()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.tealAccent,
        title: Text('Dummy Translator'),
        centerTitle: true,
      ),
      
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Theme.of(context).accentColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[

              Flexible(
                flex: 2,
                child: ListView(
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                      child: _languages()
                    ),

                    _buildCard(child: _buildInputField()),
                    if (shouldShowResponse) _buildCard(child: _buildTranslation()),
                  ],
                ),
              ),

              // Flexible(
              //   flex: 1,
              //   child: Translations(),
              // )
            ],
          )
        )
      ),
    );
  }
}

