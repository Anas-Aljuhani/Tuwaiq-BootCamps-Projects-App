import 'package:flutter/material.dart';
import 'package:tuwaiq_project/data_layer/language_layer.dart';
import 'package:tuwaiq_project/helper/extinsion/size_config.dart';
import 'package:tuwaiq_project/services/setup.dart';

class CustomButton extends StatelessWidget {
  final String arabicTitle, englishTitle;
  bool? arabic = false;
  final Function() onPressed;
  final Color? color;
  final double? fontSize;
  CustomButton({
    super.key,
    required this.englishTitle,
    this.arabic,
    required this.arabicTitle,
    required this.onPressed,
    this.color, this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final language = languageLocaitor.get<LanguageLayer>();
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(context.getWidth(multiply: 0.5),
              context.getHeight(multiply: 0.05)),
          backgroundColor: color ?? const Color(0xff4D2EB4)),
      child: Text(
        arabic! || language.isArabic ? arabicTitle : englishTitle,
        style:  TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize:fontSize ?? 20),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
