import 'package:flutter/material.dart';

class OverlayWidgets{

  static Widget fullWidthTextField({
    required Widget label,
    required Widget child,
    double height = 100,
    bool isHeight = false,
  }){

    return Padding(
        padding: const EdgeInsets.only(
            top: 6
        ),
        child: Container(
            padding: const EdgeInsets.only(
                left: 8,
                right: 5
            ),
            height: isHeight ? 120 : height,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8)
            ),
            child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16
                          ),
                          child: label
                      )
                  ),
                  child
                ]
            )
        )
    );

  }

}