import 'package:flutter/material.dart';

import '../widgets/ui/list_cell.dart';
import '../widgets/ui/divider.dart';
import '../utils/settings.dart';

class AboutScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return AboutScreenState();
  }
}

class AboutScreenState extends State<AboutScreen> {

  @override
    Widget build(BuildContext context) {
      return WillPopScope(

        onWillPop: () {
          Navigator.pop(context, false);
        },
        
        child: Scaffold(
          appBar: AppBar(
            title: Text('Información'),
            centerTitle: true,
          ),  
          body: Scrollbar(
            child: ListView(children: <Widget>[
              ListCell(
                leading: const Icon(Icons.info, size: 42.0),
                title: (appname),
                subtitle: ('Versión pública'),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: const Icon(Icons.person, size: 42.0),
                title: ('Desarrollado por Joshua García'),
                subtitle: ('Contacto: joshuagarcia@outlook.es'),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: const Icon(Icons.lock_open, size: 42.0),
                title: ('Licencias de código abierto'),
                subtitle: ('Información sobre las licencias de código abierto'),
              )
            ])
          )
        )
      );
    }
}