import 'package:clearApp/util/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

import 'data_manage/form_subject.dart';

class AddPrchButton extends StatefulWidget {
  //screen size
  final Function tapCallback;

  const AddPrchButton({
    Key key,
    this.tapCallback,
  }) : super(key: key);

  @override
  _AddPrchButtonState createState() => _AddPrchButtonState();
}

class _AddPrchButtonState extends State<AddPrchButton>
    with SingleTickerProviderStateMixin {
  ButtonState buttonState = ButtonState.Small;
  AnimationController _controller;
  Animation<double> _buttonTextAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 450), vsync: this);
    _buttonTextAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Interval(0.7, 1.0), parent: _controller));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formSubject = Provider.of<FormSubject>(context);

    _controller.forward();

    return Container(
      height: ScreenUtil().setHeight(180),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFF36D1DC),
            Color(0xFF5B86E5),
          ],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (!formSubject.isAddingNewHstr) widget.tapCallback();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              SizeTransition(
                sizeFactor: _buttonTextAnimation,
                axis: Axis.horizontal,
                axisAlignment: -1.0,
                child: Center(
                  child: formSubject.isAddingNewHstr
                      ? JumpingText('BUY',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: ScreenUtil().setSp(50),
                              color: Colors.white))
                      : Text(
                          'BUY',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: ScreenUtil().setSp(50)),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ButtonState { Small, Enlarged }
