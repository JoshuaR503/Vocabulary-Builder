import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../widgets/ui/list_cell.dart';
import '../widgets/ui/divider.dart';
import '../utils/settings.dart';

class AboutScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _AboutScreenState();
  }
}

class _AboutScreenState extends State<AboutScreen> {

  @override
    Widget build(BuildContext context) {
      return WillPopScope(

        onWillPop: () {
          Navigator.pop(context, true);
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
                title: ('Autor Joshua García'),
                subtitle: ('Contacto: joshuagarcia@outlook.es'),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: const Icon(Icons.verified_user, size: 42.0),
                title: ('Supporting Open Source'),
                subtitle: ('El código es abierto y se puede encontrar en Github'),
                onTap: () => FlutterWebBrowser.openWebPage(url: flutterUrl)
              )
            ])
          )
        )
      );
    }
}