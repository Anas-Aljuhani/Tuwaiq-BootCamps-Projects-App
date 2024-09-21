import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tuwaiq_project/helper/extinsion/size_config.dart';

class CustomeMemberContainer extends StatelessWidget {
  const CustomeMemberContainer({
    super.key,
    required this.name,
    required this.positions,
    required this.img,
    this.onPressedIcon,
  });

  final String name;
  final String positions;
  final Image img;
  final Function()? onPressedIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(multiply: 0.4),
      height: context.getHeight(multiply: 0.38),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 196, 196, 196),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0.5, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: context.getHeight(multiply: 0.2),
            width: context.getWidth(multiply: 0.2),
            decoration: const BoxDecoration(
                color: Color(0xffCACACA), shape: BoxShape.circle),
            child: img,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Text(
            positions,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onPressedIcon,
                icon: const FaIcon(
                  FontAwesomeIcons.discord,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: onPressedIcon,
                icon: const FaIcon(
                  FontAwesomeIcons.linkedinIn,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: onPressedIcon,
                icon: const FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: onPressedIcon,
                icon: const FaIcon(
                  FontAwesomeIcons.googleDrive,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}