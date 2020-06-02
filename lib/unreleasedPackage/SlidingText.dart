import 'package:flutter/material.dart';

class _TextElementController {
  Function _animateDismiss;

  Function _animateReveal;

  ///This will reverse the animation
  Future<void> animateDismiss() async {
    await _animateDismiss();
  }

  ///This will reveal the card
  Future<void> animateReveal() async {
    await _animateReveal();
  }
}

class SlidingTextController {
  Function _animateDismiss;

  Function _animateReveal;

  Duration _awaitDuration;
  ///This will reverse the animation
  Future<void> animateDismiss({bool forceAwait }) async {
    await _animateDismiss();

    if(forceAwait ==true)
    await Future.delayed(Duration(milliseconds:_awaitDuration.inMilliseconds),(){
      return;
    });
  }

  ///This will reveal the card
  Future<void> animateReveal({bool forceAwait }) async {
    await _animateReveal();
    if(forceAwait ==true)
    await Future.delayed(_awaitDuration,(){
      return;
    });
  }
}

///Welcome to Sliding text
///Use this widget to animate the text
class SlidingText extends StatefulWidget {
  ///Use this to perform some animations
  final SlidingTextController controller;

  ///The text to animate
  final String text;

  ///How long should the animation take place
  final Duration animationDuration;

  ///enabled by default,for ease in design apearance
  final bool addFading;

  /// the Text textStyle
  final TextStyle style;

  const SlidingText(
      {Key key,
      @required this.text,
      this.controller,
      this.animationDuration = const Duration(milliseconds: 2000),
      this.addFading = true,
      this.style})
      : super(key: key);
  @override
  _SlidingTextState createState() => _SlidingTextState();
}

class _SlidingTextState extends State<SlidingText> {
  List<_TextElement> textElementList;
  List<Function> _dimissfunctionBackup;
  List<Function> _revealfunctionBackup;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller._animateDismiss = dismissLetters;
      widget.controller._animateReveal = revealLetters;
      widget.controller._awaitDuration = widget.animationDuration;
    }
    textElementList = [];
    _dimissfunctionBackup = [];
    _revealfunctionBackup = [];
    //divideString();
  }

  @override
  Widget build(BuildContext context) {
    if (textElementList.isEmpty == true) {
      divideString();
    } else {
      textElementList.clear();
      divideString();
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: textElementList,
      ),
    );
  }

  ///we use this to create text elements
  void divideString() async {
    int letterNumber = 0;
    int textAnimationDelay = 150;
    int textAnimationReverseDelay =
        textAnimationDelay + (80 * (widget.text.length - 1));
    do {
      if (letterNumber == 0) {
        textElementList.add(_TextElement(
          reverseAnimationDelay: textAnimationReverseDelay,
          textElementController: _TextElementController(),
          animationduration: widget.animationDuration,
          useOpacity: widget.addFading,
          text: widget.text[letterNumber],
          isInitialLetter: true,
          textAnimationDelay: 0,
          textStyle: widget.style,
        ));
        textAnimationReverseDelay = textAnimationReverseDelay - 80;
      } else {
        textAnimationDelay = textAnimationDelay + 80;
        textElementList.add(_TextElement(
          reverseAnimationDelay: textAnimationReverseDelay,
          textElementController: _TextElementController(),
          animationduration: widget.animationDuration,
          useOpacity: widget.addFading,
          text: widget.text[letterNumber],
          isInitialLetter: false,
          textAnimationDelay: textAnimationDelay,
          textStyle: widget.style,
        ));
        textAnimationReverseDelay = textAnimationReverseDelay - 80;
        if (letterNumber + 1 == widget.text.length - 1) {
          textAnimationReverseDelay = 0;
        }
      }

      letterNumber++;
    } while (letterNumber != widget.text.length);
  }

  ///Use this to ask the main class to animate in reverse
  Future<void> dismissLetters() async {
    int letterNumber = widget.text.length - 1;
    if (textElementList[0].textElementController._animateDismiss == null) {
      print('null object at letter ${textElementList[0].text}');

      do {
        textElementList[letterNumber].textElementController._animateDismiss = _dimissfunctionBackup[letterNumber];
        await textElementList[letterNumber]
            .textElementController
            .animateDismiss();
        letterNumber--;
      } while (letterNumber != -1);
      
    } else {
      textElementList.forEach((element) {
        _dimissfunctionBackup
            .add(element.textElementController._animateDismiss);
        _revealfunctionBackup.add(element.textElementController._animateReveal);
      });
      do {
        await textElementList[letterNumber]
            .textElementController
            .animateDismiss();
        letterNumber--;
      } while (letterNumber != -1);
      
    }
  }

  ///Use this to ask the main class to animate in reverse
  Future<void> revealLetters() async {
    int letterNumber = 0;
    
    if (textElementList[0].textElementController._animateDismiss == null) {
      print('null object at letter ${textElementList[0].text}');

      
    }
    do {
      if(textElementList[letterNumber].textElementController._animateDismiss == null)
      textElementList[letterNumber].textElementController._animateDismiss = _revealfunctionBackup[letterNumber];
      await textElementList[letterNumber]
          .textElementController
          .animateDismiss();
      letterNumber++;
    } while (letterNumber != widget.text.length);
  }
}

//================ TextElement
class _TextElement extends StatefulWidget {
  final _TextElementController textElementController;
  final String text;
  final bool isInitialLetter;
  final int textAnimationDelay;
  final TextStyle textStyle;
  final bool useOpacity;
  final Duration animationduration;
  final int reverseAnimationDelay;
  const _TextElement({
    Key key,
    @required this.text,
    @required this.isInitialLetter,
    @required this.textAnimationDelay,
    @required this.textStyle,
    @required this.useOpacity,
    @required this.animationduration,
    @required this.textElementController,
    @required this.reverseAnimationDelay,
  }) : super(key: key);

  @override
  __TextElementState createState() => __TextElementState();
}

class __TextElementState extends State<_TextElement>
    with TickerProviderStateMixin {
  AnimationController textTranslationController;
  CurvedAnimation curvedAnimation;
  Animation mainAnimation;
  double opacity;
  bool isRevealing;

  @override
  void initState() {
    super.initState();

    if (widget.textElementController != null) {
      widget.textElementController._animateDismiss = dismiss;
      widget.textElementController._animateReveal = reveal;
    }
    isRevealing = true;
    //If we want to have an opacity effect
    if (widget.useOpacity == true) {
      opacity = 0;
    } else {
      opacity = 1;
    }
    //Change the duration to a mathematical duration later
    textTranslationController = AnimationController(
        vsync: this,
        duration: widget.animationduration,
        reverseDuration:
            widget.animationduration - (widget.animationduration * 0.62));

    curvedAnimation = CurvedAnimation(
        parent: textTranslationController,
        curve: Curves.fastLinearToSlowEaseIn);
    //Change the begining also
    mainAnimation = Tween<double>(begin: 90, end: 0).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    reveal();
  }

  Future<void> dismiss() async {
    setState(() {
      isRevealing = false;
    });
    if (widget.isInitialLetter == true) {
      Future.delayed(Duration(milliseconds: widget.reverseAnimationDelay),
          () async {
        await textTranslationController.reverse();
        if (widget.useOpacity == true) {
          opacity = 0;
        }
      });
    } else {
      Future.delayed(Duration(milliseconds: widget.reverseAnimationDelay),
          () async {
        // print(widget.text);
        // print(widget.reverseAnimationDelay);
        await textTranslationController.reverse();
        if (widget.useOpacity == true) {
          opacity = 0;
        }
      });
    }
  }

  Future<void> reveal() async {
    setState(() {
      isRevealing = true;
    });
    // print(widget.text);
    // print(widget.reverseAnimationDelay);
    if (widget.isInitialLetter == true) {
      if (widget.useOpacity == true) {
        opacity = 1;
      }
      textTranslationController.forward();
    } else {
      Future.delayed(Duration(milliseconds: widget.textAnimationDelay), () {
        if (widget.useOpacity == true) {
          opacity = 1;
        }
        textTranslationController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    print('Disposing the text animation controller');
    textTranslationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(mainAnimation.value, 0),
        child: AnimatedOpacity(
          opacity: opacity,
          duration: isRevealing
              ? Duration(milliseconds: widget.textAnimationDelay)
              : Duration(milliseconds: widget.reverseAnimationDelay),
          child: Text(
            widget.text,
            style: widget.textStyle,
          ),
        ));
  }
}
