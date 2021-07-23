import 'dart:async';

import 'package:flutter/material.dart';

class OneFieldLoginForm extends StatefulWidget {
  const OneFieldLoginForm({
    required this.animationDuration,
    required this.textEditingController,
    required this.onEmailSubmit,
    required this.onPasswordSubmit,
    required this.login,
    this.validateEmail,
    this.validatePassword,
    this.widthUpperBound = 200,
    this.widthLowerBound = 55,
    this.widthAnimationWeight = 50,
    this.widthAnimationCurve = Curves.easeOut,
    this.iconTranslateBegin = 0,
    this.iconTranslateEnd = 160,
    this.iconTranslateAnimationWeight = 50,
    this.iconTranslateAnimationCurve = Curves.easeOut,
    this.iconHeight = 55.0,
    this.iconWidth = 55.0,
    this.iconBorder,
    this.iconSize = 55 * 4 / 7,
    this.emailIcon = Icons.mail_outline_rounded,
    this.passwordIcon = Icons.lock_outline,
    this.successIcon = Icons.arrow_forward_ios,
    this.iconColor = Colors.white,
    this.textFieldHeight = 55.0,
  });

  /// [Duration] of the animation
  final Duration animationDuration;

  /// Determines the width of the [TextField] after expansion
  /// set to [200] by default
  final double widthUpperBound;

  /// Determines the initial width of the [TextField]
  /// set to [55] by default
  final double widthLowerBound;

  /// Determines the [weight] of the animation
  /// All animations are set at equal priority by default i.e 50
  final double widthAnimationWeight;

  /// Curve of the [Animation]
  final Curve widthAnimationCurve;

  /// Initial position of the [Icon] before [Translation]
  /// By default it is set to [0]
  final double iconTranslateBegin;

  /// Final position of the [Icon] after the [Translation]
  /// It is set to [160] by default
  final double iconTranslateEnd;

  /// Weight of [Icon] translate animation
  /// Set to 50 by default
  final double iconTranslateAnimationWeight;

  /// Curve of the [Tranlate] animation
  final Curve iconTranslateAnimationCurve;

  /// [TextEditingController] to get the values from the [TextField]
  ///
  /// As there is only a single [TextField] the values can be stored in
  /// different variables whenever the [onSubmit] is triggered
  final TextEditingController textEditingController;

  /// This [Function] will be called when email is submitted
  final Function onEmailSubmit;

  /// [Function] for email validation
  final Function? validateEmail;

  /// [Function] for password validation
  final Function? validatePassword;

  /// This [Function] will be called when password is submitted
  final Function onPasswordSubmit;

  /// [Function] to log users in
  final Function login;

  /// Height of the [TextField]
  final double textFieldHeight;

  /// Height of the [IconButton]
  /// By default it's set to 55.0
  final double iconHeight;

  /// Width of the [IconButton]
  /// By default it's set to 55.0
  final double iconWidth;

  /// [Border] for [IconButton]
  final BoxBorder? iconBorder;

  /// [Size] of the icon
  final double iconSize;

  /// This [Icon] will be displayed when user enters email
  final IconData emailIcon;

  /// This [Icon] will be displayed when user enters password
  final IconData passwordIcon;

  /// This [Icon] will be displayed when user is successfully logged in
  final IconData successIcon;

  /// [Color] for the icon
  final Color iconColor;

  @override
  _OneFieldLoginFormState createState() => _OneFieldLoginFormState();
}

class _OneFieldLoginFormState extends State<OneFieldLoginForm>
    with TickerProviderStateMixin {
  /// Checks whether the form is open
  bool _isOpened = false;
  bool _isEmail = true;
  bool _passwordEntered = false;
  bool _emailEntered = false;
  bool _isComplete = false;

  /// [Controller] for the base animation
  late AnimationController _controller;
  late AnimationController _passwordController;
  late Animation<double> _slidingAnimation;
  late Animation<double> _widthAnimation;
  late Animation<double> _fadeOutAnimation;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: widget.animationDuration, vsync: this);

    _passwordController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    _fadeOutAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1, end: 0),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(
      parent: _passwordController,
      curve: Curves.easeOut,
    ));

    _fadeInAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: 1),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(
      parent: _passwordController,
      curve: Curves.easeIn,
    ));

    _slidingAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
            tween: Tween<double>(
                begin: widget.iconTranslateBegin, end: widget.iconTranslateEnd),
            weight: widget.iconTranslateAnimationWeight),
      ],
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.iconTranslateAnimationCurve,
      ),
    );

    _widthAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(
            begin: widget.widthLowerBound, end: widget.widthUpperBound),
        weight: widget.widthAnimationWeight,
      ),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: widget.widthAnimationCurve),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isOpened = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          _isOpened = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        return Stack(
          children: [
            Opacity(
              opacity: _fadeInAnimation.value,
              child: Center(
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: 1,
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(left: 55, right: 20, top: 3),
                  height: widget.textFieldHeight,
                  width: _widthAnimation.value,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(55),
                      color: Colors.black),
                  child: TextField(
                    autofocus: true,
                    maxLines: 1,
                    controller: widget.textEditingController,
                    style: TextStyle(color: Colors.white),
                    obscureText: !_isEmail,
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: _isEmail ? "Your email" : "Password",
                        hintStyle: TextStyle(color: Colors.grey)),
                    onSubmitted: (value) {
                      if (!_emailEntered && !_isComplete) {
                        if (widget.validateEmail != null) {
                          widget.validateEmail!();
                        }
                        widget.onEmailSubmit();

                        _controller.reverse();
                        Timer(Duration(milliseconds: 200), () {
                          _controller.forward();
                        });

                        setState(() {
                          widget.textEditingController.clear();
                          _isEmail = false;
                          _emailEntered = true;
                        });
                      } else if (_emailEntered && !_isComplete) {
                        if (widget.validatePassword != null) {
                          widget.validatePassword!();
                        }
                        widget.onPasswordSubmit();

                        setState(() {
                          _passwordEntered = true;
                          // _passwordController.forward();
                        });
                        _controller.reverse();
                      } else if (_passwordEntered && !_isComplete) {
                        setState(() {
                          _isComplete = true;
                        });
                        widget.login();
                        _controller.forward();
                      }
                    },
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: _passwordEntered ? _fadeOutAnimation.value : 1,
              child: Center(
                child: Container(
                  height: widget.iconHeight,
                  width: widget.iconWidth,
                  margin: EdgeInsets.only(right: _slidingAnimation.value),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: widget.iconBorder,
                    borderRadius: BorderRadius.circular(55),
                  ),
                  child: IconButton(
                    color: widget.iconColor,
                    icon: _isEmail
                        ? Icon(widget.emailIcon)
                        : (_passwordEntered
                            ? Icon(widget.successIcon)
                            : Icon(widget.passwordIcon)),
                    iconSize: widget.iconSize,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      if (_isOpened && !_isComplete) {
                        _controller.reverse();
                      } else if (!_isOpened && !_isComplete) {
                        _controller.forward();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
