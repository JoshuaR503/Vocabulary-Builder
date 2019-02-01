import 'package:scoped_model/scoped_model.dart';
import './palabra.scoped-model.dart';

class MainModel extends Model with ConnectedModel, PalabrasModel, UtilityModel {}