import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tuwaiq_project/helper/extinsion/size_config.dart';
import 'package:tuwaiq_project/helper/method/open_url.dart';
import 'package:tuwaiq_project/models/members_project_model.dart';

class CustomeMemberContainer extends StatelessWidget {
  const CustomeMemberContainer({
    super.key,
    this.onPressedIcon,
    required this.membersProject,
  });

  final MembersProjectModel membersProject;
  final Function()? onPressedIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.getWidth(multiply: 0.03)),
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
            height: context.getHeight(multiply: 0.17),
            width: context.getWidth(multiply: 0.2),
            decoration: const BoxDecoration(
                color: Color(0xffCACACA), shape: BoxShape.circle),
            child: membersProject.imageUrl != null &&
                    membersProject.imageUrl!.isNotEmpty
                ? Image.network(
                    membersProject.imageUrl!,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/image/Search-amico(1).png");
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return const Center(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                    fit: BoxFit.cover,
                  )
                : Image.asset("assets/image/Search-amico(1).png"),
          ),
          Text(
            "${membersProject.firstName} ${membersProject.lastName}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Text(
            membersProject.position,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    await openUrl(
                        context: context, url: membersProject.link.bindlink);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.discord,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await openUrl(
                        context: context, url: membersProject.link.linkedin);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.linkedinIn,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await openUrl(
                        context: context, url: membersProject.link.bindlink);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await openUrl(
                        context: context, url: membersProject.link.bindlink);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.googleDrive,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
