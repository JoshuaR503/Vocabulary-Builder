import 'package:flutter/material.dart';

import 'package:moblie/utils/settings.dart';
import 'package:moblie/widgets/ui/list_cell.dart';
import 'package:moblie/widgets/ui/text/subtitle.dart';
import 'package:moblie/widgets/ui/text/title.dart';

class HelpScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
      },
      
      child: Scaffold(
        appBar: AppBar(
          title: Text('Solución de problemas'),
          centerTitle: true,
        ),

        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              CommonTitle('No me aparecen palabras'),
              SubTitle('Siempre tengo el mensaje: $onServerConnection'),
              ListCell(
                leading: Image.asset(
                  'assets/wifi.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: ('Conexión a internet.'),
                subtitle: ('Una razón podría ser que conexión a internet puede estar fallando o es muy lenta, por favor comprueba la conexión a internet. Si no funciona, intenta más tarde.'),
                onTap: () {},
              ),

              CommonTitle('¡No puedo escuchar nada!'),
              SubTitle('En algunos dispositivos, la aplicación puede mostrar un comportamiento extraño, pero puedes solucionarlo con la siguiente guía.'),
              ListCell(
                title: ('Se paciente.'),
                subtitle: ('Esta aplicación está en fase beta y podría tardar un poco en responder, puede tardar hasta 20 segundos, por favor se paciente.'),
                onTap: () {},
              ),

              ListCell(
                title: ('Comprueba el volumen.'),
                subtitle: ('Podría ser obvio, pero ¿has intentado aumentar el volumen?'),
                onTap: () {},
              ),

              ListCell(
                title: ('Modo no molestar.'),
                subtitle: ('Es posible que tenga activado el modo "No molestar". Intente desactivarlo.'),
                onTap: () {},
              ),

              ListCell(
                title: ('Última revisión.'),
                subtitle: ('Si nada de esto funciona, tienes dos opciones, puede que tu teléfono tenga un altavoz que no funciona o tu dispositivo no es compatible con la aplicación.'),
                onTap: () {},
              ),

            ]
          )
        ),
      )
    );
  }
}