import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  
  FadeRoute({this.page})
    : super(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      }

      // ScaleTransition(
      //   scale: Tween<double>(begin: 0.0,end: 1.0, )
      //   .animate(
      //     CurvedAnimation(
      //       parent: animation,
      //       curve: Curves.fastOutSlowIn,
      //     ),
      //   ),

      //   child: child,
      // );

      // SlideTransition(
      //   position: Tween<Offset>(
      //     begin: Offset(1.0, 0.0),
      //     end: Offset.zero,
      //   )
      //   .animate(animation),
      //   child: child,
      // );
      
      // FadeTransition(
      //   opacity: animation,
      //   child: child,
      // ),
    );
}