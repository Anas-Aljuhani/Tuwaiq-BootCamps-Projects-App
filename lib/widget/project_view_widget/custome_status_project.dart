import 'package:flutter/material.dart';

class CustomeCampStatusProject extends StatelessWidget {
  const CustomeCampStatusProject({
    super.key,
    required this.borderColor,
    required this.continaerColor,
    required this.textContent,
    required this.heightContainer,
    required this.widthContainer,
    required this.sizeText,
    this.titleTextContainer,
    this.titleSize,
  });

  final Color borderColor;
  final Color continaerColor;
  final String textContent;
  final String? titleTextContainer;
  final double heightContainer;
  final double widthContainer;
  final double sizeText;
  final double? titleSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          titleTextContainer ?? "",
          style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.w500),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          constraints: BoxConstraints(
              minHeight: heightContainer, minWidth: widthContainer),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: continaerColor,
            boxShadow: [
              BoxShadow(
                color: borderColor,
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0.5, 2),
              ),
            ],
          ),
          child: Center(
              child: Text(
            textContent.substring(0, textContent.length),
            style: TextStyle(fontSize: sizeText, color: Colors.black),
          )),
        ),
      ],
    );
  }
}
