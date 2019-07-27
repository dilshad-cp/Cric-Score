import 'package:score_calculator_app/values/color_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonCalculator extends StatelessWidget {
  final Color _buttonColorWhite = Colors.white;
  final Color _buttonColorGreen = Colors.green;
  final Color _buttonColorBlue = Colors.blue;
  final Color _buttonColorOrange = Colors.orange;
  final Color _buttonColorGray = Colors.grey;
  final Color _buttonColorRed = Colors.red;
  final Color _buttonHightlightColor = Colors.grey[800];
  final Color _textColorGrey = Colors.grey;
  final Color _textColorWhite = Colors.white;
  

  final double _buttonFontSizeCalculator = 24.0;
  final double _buttonFontSizeCalculatorSmall = 18.0;

  final String typeButton;
  final VoidCallback actionOnPressed;
  final VoidNavigate actionOnPressedWithParameter;
  final int valueActionOnPressedWithParameter;
  final String label;

  ButtonCalculator(this.typeButton,
      {this.actionOnPressed,
      this.actionOnPressedWithParameter,
      this.valueActionOnPressedWithParameter,
      this.label});

  @override
  Widget build(BuildContext context) {
    debugPrint(typeButton);
    if (typeButton == "general") {
      return Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 21.0, right: 12.0, bottom: 21.0),
          child: new RaisedButton(
            color: _buttonColorBlue,
            // highlightColor: _buttonHightlightColor,
            child: Text(
              label,
              style: TextStyle(
                color: _textColorWhite,
                fontSize: _buttonFontSizeCalculatorSmall,
                fontWeight: FontWeight.w200,
              ),
            ),
            onPressed: () {
              actionOnPressedWithParameter(valueActionOnPressedWithParameter);
            },
            shape: new RoundedRectangleBorder( borderRadius: new BorderRadius.circular(100.0)),
          ),
        );
    }else if (typeButton == "out") {
      return Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 21.0, right: 12.0, bottom: 21.0),
          child: new RaisedButton(
            color: _buttonColorRed,
            // highlightColor: _buttonHightlightColor,
            child: Text(
              'OUT',
              style: TextStyle(
                color: _textColorWhite,
                fontSize: _buttonFontSizeCalculatorSmall,
                fontWeight: FontWeight.w200,
              ),
            ),
            onPressed: actionOnPressed,
            shape: new RoundedRectangleBorder( borderRadius: new BorderRadius.circular(100.0)),
          ),
        );
    } else if (typeButton == "warning") {
      return  RaisedButton(
            color: _buttonColorOrange,
            highlightColor: _buttonHightlightColor,
            child: Text(
              label,
              style: TextStyle(
                color: _textColorWhite,
                fontSize: _buttonFontSizeCalculatorSmall,
                fontWeight: FontWeight.w200,
              ),
            ),
            onPressed: () {
              actionOnPressedWithParameter(valueActionOnPressedWithParameter);
            },
      );
    } else if (typeButton == "reset") {
      return Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 21.0, right: 12.0, bottom: 21.0),
          child: new RaisedButton(
          color: _buttonColorGray,
          highlightColor: _buttonHightlightColor,
          child: Icon(
            Icons.undo,
            color: _textColorWhite,
          ),
          onPressed: actionOnPressed,
          shape: new RoundedRectangleBorder( borderRadius: new BorderRadius.circular(100.0)),
        )
      );
    }  else if (typeButton == "countball") {
      return RaisedButton(
        color: _buttonColorGreen,
        highlightColor: _buttonHightlightColor,
        child: Text(
          "COUNT BALL",
          style: TextStyle(
            color: _textColorWhite,
            fontSize: _buttonFontSizeCalculator,
          ),
        ),
        onPressed: actionOnPressed,
      );
    } else if (typeButton == "finish") {
      return RaisedButton(
        color: _buttonColorWhite,
        highlightColor: _buttonHightlightColor,
        child: Text(
          "FINISH",
          style: TextStyle(
            color: ColorAssets.primarySwatchColor,
            fontSize: _buttonFontSizeCalculator,
          ),
        ),
        onPressed: actionOnPressed,
      );
    } else if (typeButton == "backspace") {
      return RaisedButton(
        color: _buttonColorWhite,
        highlightColor: _buttonHightlightColor,
        child: Icon(
          Icons.backspace,
          color: _textColorGrey,
        ),
        onPressed: actionOnPressed,
      );
    } 
    return null;
  }
}

typedef VoidNavigate = void Function(int route);
