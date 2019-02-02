import 'package:scoped_model/scoped_model.dart';

import 'package:http/http.dart' as http;
import './palabra.model.dart';

import 'dart:convert';
import 'dart:async';

mixin ConnectedModel on Model {
  bool _isLoading = true;
  List _palabras = [];
}

mixin PalabrasModel on ConnectedModel {

  List<Palabra> get allPalabras {
    return List.from(_palabras);
  }

  Future<Null> obtenerPalabras() async {
    _isLoading = true;
    notifyListeners();

    return http
      .get('https://another-backend.herokuapp.com/palabras/azar')
      .then<Null>((http.Response response) {

        final List<Palabra> fetchedPalabrasList = [];
        final List<dynamic> palabraListData = json.decode(response.body);

        if (palabraListData == null) {
          _isLoading = false;
          notifyListeners();
          return;
        } 

        palabraListData.forEach((dynamic palabraData) {

          final Palabra singlePalabra = Palabra(
            palabra: palabraData['palabra'],
            traduccion: palabraData['traduccion'],
          );

          fetchedPalabrasList.add(singlePalabra);
        });  

        _palabras = fetchedPalabrasList; 
        _isLoading = false;
        notifyListeners();        
      })
      .catchError((error) {
        _isLoading = false;
        notifyListeners();
        return;
      });
  }
} 

mixin UtilityModel on ConnectedModel {
  bool get isLoading {
    return _isLoading;
  }
}