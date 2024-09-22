import 'package:flutter/material.dart';
import 'package:tuwaiq_project/helper/extinsion/size_config.dart';
import 'package:tuwaiq_project/models/profile_model.dart';

class ProjectContainer extends StatelessWidget {
  final Function()? onTap;
  // final String imagePath, bootcamp, rate, projectName;

  final ProjectsModel projectsModel;
  const ProjectContainer({
    super.key,
    this.onTap,
    required this.projectsModel,
  });

  @override
  Widget build(BuildContext context) {
    print(projectsModel.logoUrl);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: context.getWidth(multiply: 0.01)),
        decoration: BoxDecoration(
            boxShadow: kElevationToShadow[4],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            projectsModel.logoUrl != null && projectsModel.logoUrl!.isNotEmpty
                ? Image.network(
                    projectsModel.logoUrl!,
                    height: context.getHeight(multiply: 0.2),
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/image/flutter.png",
                      );
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
                : Image.asset("assets/image/flutter.png"),
            //Later make sure for responsive
            Row(
              children: [
                Text(
                  projectsModel.projectName == null
                      ? "no name"
                      : '${projectsModel.projectName?.substring(0, projectsModel.projectName!.length > 8 ? 8 : projectsModel.projectName?.length)}...',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                const Icon(
                  Icons.star,
                  color: Colors.amberAccent,
                ),
                Text(
                  '${projectsModel.rating}/5',
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Text(
              projectsModel.bootcampName ?? "no name",
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0x55000000)),
            )
          ],
        ),
      ),
    );
  }
}
