// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tuwaiq_project/data_layer/language_layer.dart';
import 'package:tuwaiq_project/models/projects_model.dart';

import 'package:tuwaiq_project/screens/home_screen.dart';
import 'package:tuwaiq_project/widget/column/info_coulmn.dart';

import 'package:tuwaiq_project/data_layer/auth_layer.dart';
import 'package:tuwaiq_project/helper/extinsion/size_config.dart';
import 'package:tuwaiq_project/helper/method/open_url.dart';

import 'package:tuwaiq_project/screens/projectView/edit/edit_screen.dart';
import 'package:tuwaiq_project/screens/project_info/cubit/project_info_cubit.dart';
import 'package:tuwaiq_project/services/setup.dart';
import 'package:tuwaiq_project/shape/auth_shape.dart';
import 'package:tuwaiq_project/widget/project_view_widget/costumr_details_project.dart';
import 'package:tuwaiq_project/widget/project_view_widget/custome_carousel_slider.dart';
import 'package:tuwaiq_project/widget/project_view_widget/custome_member_of_project.dart';
import 'package:tuwaiq_project/widget/project_view_widget/custome_status_project.dart';
import 'package:tuwaiq_project/widget/project_view_widget/custome_top_action.dart';

class ProjectViewScreen extends StatelessWidget {
  ProjectViewScreen({super.key, required this.projectsModel});

  ProjectsModel projectsModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectInfoCubit(),
      child: Builder(builder: (context) {
        final language = languageLocaitor.get<LanguageLayer>();
        final cubit = context.read<ProjectInfoCubit>();
        final id = authLocator.get<AuthLayerData>().auth!.id;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                CustomPaint(
                  size: Size(context.getWidth(multiply: 1),
                      context.getHeight(multiply: 0.1)),
                  painter: AuthShape(),
                ),
                CustomeActionProject(
                  isAuthraize:
                      projectsModel.userId == id || projectsModel.adminId == id,
                  editClick: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditScreen(
                            projectId: projectsModel.projectId!,
                            isAuthraize: projectsModel.adminId == id,
                          ),
                        )).then(
                      (value) async {
                        if (value == true) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ));
                        }
                      },
                    );
                  },
                  qrCodeButton: () {
                    showDialog(
                      context: context,
                      builder: (context) => Center(
                        child: Container(
                          width: context.getWidth(multiply: 0.8),
                          height: context.getHeight(multiply: 0.4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Text(language.isArabic
                                  ? 'تقيم المشروع'
                                  : 'Rate me'),
                              QrImageView(
                                backgroundColor: Colors.white,
                                data: projectsModel.projectId!,
                                padding: EdgeInsets.zero,
                                version: QrVersions.auto,
                                size: context.getHeight(multiply: 0.3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  height: context.getHeight(multiply: 0.2),
                  width: context.getWidth(multiply: 0.3),
                  decoration: const BoxDecoration(
                      color: Color(0xffCACACA), shape: BoxShape.circle),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        projectsModel.logoUrl ?? " ",
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                              'assets/image/Search-amico(1).png');
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
                      )),
                ),
                SizedBox(
                  height: context.getHeight(multiply: 0.02),
                ),
                InfoCoulmn(language: language, projectsModel: projectsModel),
                CostomeDetailsProject(
                  titleText:
                      language.isArabic ? 'وصف المشروع' : 'Project details',
                  maxHeight: context.getHeight(multiply: 0.2),
                  readOnly: true,
                  heightContainer: context.getHeight(multiply: 0.3),
                  widthContainer: context.getWidth(multiply: 0.8),
                  cotentText: projectsModel.projectDescription ?? "nothing",
                ),
                SizedBox(
                  height: context.getHeight(multiply: 0.035),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomeCampStatusProject(
                      titleTextContainer:
                          language.isArabic ? 'بداية المشروع' : 'Start Date',
                      continaerColor: const Color(0xff00FF19).withOpacity(0.30),
                      borderColor: const Color(0xff00FF19).withOpacity(0.30),
                      textContent: projectsModel.startDate?.substring(0,7) ?? "not giveing",
                      heightContainer: context.getHeight(multiply: 0.043),
                      widthContainer: context.getWidth(multiply: 0.25),
                      sizeText: 16,
                    ),
                    CustomeCampStatusProject(
                      titleTextContainer:
                          language.isArabic ? 'نهاية المشروع' : 'End Date',
                      continaerColor: const Color(0xffFF0000).withOpacity(0.30),
                      borderColor: const Color(0xffFF0000).withOpacity(0.30),
                      textContent: projectsModel.endDate?.substring(0,7) ?? "not giveing",
                      heightContainer: context.getHeight(multiply: 0.043),
                      widthContainer: context.getWidth(multiply: 0.25),
                      sizeText: 16,
                    ),
                  ],
                ),
                SizedBox(
                  height: context.getHeight(multiply: 0.035),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    language.isArabic ? 'صور المشروع' : 'Project Images',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
                BlocBuilder<ProjectInfoCubit, ProjectInfoState>(
                  builder: (context, state) {
                    if (state is ImgChangeState) {
                      return CarouselSliderCustome(
                        carouselSliderWidget: projectsModel.imagesProject,
                        currentIndex: state.imgIndex,
                        onPageChanged: (p0, p1) {
                          cubit.onImgChange(imgIndex: p0);
                        },
                      );
                    }

                    return CarouselSliderCustome(
                      carouselSliderWidget: projectsModel.imagesProject,
                      currentIndex: 0,
                      onPageChanged: (p0, p1) {
                        cubit.onImgChange(imgIndex: p0);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: context.getHeight(multiply: 0.035),
                ),
                InkWell(
                  child: GestureDetector(
                    onTap: () {
                      final url = projectsModel.presentationUrl;

                      openUrl(context: context, url: url);
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: context.getWidth(multiply: 0.095)),
                        padding: EdgeInsets.symmetric(
                            horizontal: context.getWidth(multiply: 0.015),
                            vertical: context.getWidth(multiply: 0.03)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 196, 196, 196),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0.5, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          textDirection: language.isArabic
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          children: [
                            Text(
                              language.isArabic ? 'العرض' : 'Presentation',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            CustomeCampStatusProject(
                              titleSize: 0,
                              continaerColor:
                                  const Color(0xff00FF19).withOpacity(0.30),
                              borderColor:
                                  const Color(0xff00FF19).withOpacity(0.30),
                              textContent: projectsModel.presentationDate ??
                                  "not giveing",
                              heightContainer:
                                  context.getHeight(multiply: 0.043),
                              widthContainer: context.getWidth(multiply: 0.25),
                              sizeText: 16,
                            ),
                            language.isArabic
                                ? Icon(
                                    Icons.chevron_left,
                                    size: context.getWidth(multiply: 0.06),
                                  )
                                : Icon(
                                    Icons.chevron_right,
                                    size: context.getWidth(multiply: 0.06),
                                  )
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: context.getHeight(multiply: 0.035),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    language.isArabic ? 'روابط المشروع' : 'Project Links',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
                Wrap(
                  spacing: context.getWidth(multiply: 0.02),
                  runSpacing: context.getHeight(multiply: 0.02),
                  children: List.generate(
                    projectsModel.linksProject.length,
                    (index) {
                      return Container(
                        width: context.getWidth(multiply: 0.2),
                        height: context.getHeight(multiply: 0.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color.fromARGB(255, 253, 253, 253)
                              .withOpacity(0.70),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 196, 196, 196),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0.5, 2),
                            ),
                          ],
                        ),
                        child: TextButton(
                            onPressed: () async {
                              final url = projectsModel.linksProject[index].url;

                              openUrl(context: context, url: url);
                            },
                            child:
                                Text(projectsModel.linksProject[index].type)),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: context.getHeight(multiply: 0.035),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    language.isArabic ? 'اعضاء المشروع' : 'Project Team',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: context.getHeight(multiply: 0.035),
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                      horizontal: context.getWidth(multiply: 0.05)),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.56,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: projectsModel.membersProject.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: context.getWidth(multiply: 2),
                      child: CustomeMemberContainer(
                        membersProject: projectsModel.membersProject[index],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: context.getHeight(multiply: 0.15),
                ),
                SizedBox(
                  height: context.getHeight(multiply: 0.04),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
