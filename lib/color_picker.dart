import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:kaptur_alpha_v1/sreen_constants.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  bool _displayThumbColor2 = true;
  bool _enableAlpha2 = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
          child: HueRingPicker(
        portraitOnly: true,
        colorPickerHeight: 100 / 360 * ScreenConstants.screenWidth,
        pickerColor: widget.pickerColor,
        onColorChanged: widget.onColorChanged,
        enableAlpha: _enableAlpha2,
        displayThumbColor: _displayThumbColor2,
      )),
    );
  }
}
