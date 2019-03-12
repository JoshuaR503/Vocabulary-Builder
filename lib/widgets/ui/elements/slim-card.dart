import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:moblie/model/main.dart';
import 'package:moblie/model/palabra.model.dart';
import 'package:moblie/pages/palabra-single-screen.dart';

class SlimCard extends StatefulWidget {

  @required final String title;
  @required final String subtitle;

  @required final CircleAvatar firstAvatar;
  @required final CircleAvatar secondtAvatar;
  @required final Function firstFunction;

  @required final Palabra palabra;
  @required final MainModel model;
  
  SlimCard({
    this.title,
    this.subtitle,
    this.firstAvatar,
    this.secondtAvatar,
    this.firstFunction,
    this.palabra,
    this.model
  });

  @override
    State<StatefulWidget> createState() => _SlimCardState();
}

class _SlimCardState extends State<SlimCard> with TickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this
    );

    _animation = CurvedAnimation(
      parent: _controller, 
      curve: Curves.easeIn
    );

    _controller.forward();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return FadeTransition(
      opacity: _animation,
      child: Card(
        elevation: 2.0,
        child: ListTile(

          leading: widget.firstAvatar,

          trailing: GestureDetector(
            child: widget.secondtAvatar,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SinglePalabraScreen(
                  widget.palabra, 
                  widget.model
                )
              ),
            )
          ),

          title: Text(
            widget.title, 
            style: titleStyle
          ),
          
		    	subtitle: Text(
            widget.subtitle
          ),

          onTap: () => widget.firstFunction(),
        ),
      ),
    );
  }
}