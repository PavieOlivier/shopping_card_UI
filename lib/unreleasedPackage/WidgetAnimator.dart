import 'dart:async';
import 'package:flutter/material.dart';

class WidgetAnimatorController
{
 Function _hiddenFunction;
 Future <void> reverseAnimation() async{
   await _hiddenFunction();
 }  
}
class Animator extends StatefulWidget {
  final Widget child;
  final Duration time;
  final Duration duration;
  final Curve curves;
  final bool animateFromTop;
  final WidgetAnimatorController controller;

  Animator(this.child, this.time, {this.duration, this.curves, this.animateFromTop, this.controller});

  @override
  _AnimatorState createState() => _AnimatorState();
}

class _AnimatorState extends State<Animator>
    with SingleTickerProviderStateMixin {

     Future <void> reverseAnimation () async {
        await _animationController.reverse().then((onValue){
         
           //Future.delayed(widget.duration + Duration(milliseconds: 300) , (){});
        });
        
       
      }
  Timer _timer;
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: widget.duration, vsync: this);
    _animation =
        CurvedAnimation(parent: _animationController, curve: widget.curves);
    _timer = Timer(widget.time, _animationController.forward);
    if (widget.controller != null )
    {
      widget.controller._hiddenFunction =  reverseAnimation ;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _animationController.dispose();
   // print('disposing WidgetAnimator');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.translate(
            offset: widget.animateFromTop? Offset(0.0, ( -1+_animation.value) * 20):Offset(0.0, (1- _animation.value) * 20),
            child: child,
          ),
        );
      },
    );
  }
}

Timer timer;
Duration duration = Duration();
Duration _wait() {
  if (timer == null || !timer.isActive) {
    timer = Timer(Duration(microseconds: 120), () {
      duration = Duration();
    });
  }
  duration += Duration(milliseconds: 100);
  return duration;
}

class WidgetAnimator extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final bool animateFromTop;
  final WidgetAnimatorController controller;
  /*
   * Duration is optional, by default is set to 290ms,
   * coz best practice is 290ms *wink*
   */
  WidgetAnimator({
    this.duration = const Duration(milliseconds: 290),
    this.curve = Curves.easeInOut,
    this.animateFromTop = true,
    this.controller,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Animator(
      child,
      _wait(),
      duration: duration,
      curves: curve,
      animateFromTop: animateFromTop,
      controller:  controller?? null,
    );
  }
}
