// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tuwaiq_project/data_layer/auth_layer.dart';
import 'package:tuwaiq_project/data_layer/language_layer.dart';
import 'package:tuwaiq_project/helper/extinsion/size_config.dart';
import 'package:tuwaiq_project/helper/method/open_url.dart';

import 'package:tuwaiq_project/screens/auth/login_screen.dart';
import 'package:tuwaiq_project/screens/manage/manage_project_screen.dart';
import 'package:tuwaiq_project/screens/profile/cubit_profile/profile_cubit.dart';
import 'package:tuwaiq_project/screens/profile/profile_information_screen.dart';
import 'package:tuwaiq_project/services/setup.dart';
import 'package:tuwaiq_project/widget/links_profile/custome_links_profile.dart';
import 'package:tuwaiq_project/widget/links_profile/custome_title_text_profile.dart';
import 'package:tuwaiq_project/widget/list_tile/custome_listtile_profile.dart';
import 'package:tuwaiq_project/widget/status_profile/custome_status_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final language = languageLocaitor.get<LanguageLayer>();
      context.read<ProfileCubit>().getProfile();
      String rating = '0';
      () async {
        rating = await context.read<ProfileCubit>().showProjectRating();
      };
      return BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ShowProfileState) {
            return SizedBox(
              height: context.getHeight(multiply: 0.75),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await Clipboard.setData(
                                    ClipboardData(text: state.profileModel.id));

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('ID Copied to clipboard'),
                                  backgroundColor: Color(0xff7822d2),
                                ));
                              },
                              icon: const Icon(FontAwesome.copy)),
                          IconButton(
                            onPressed: () {
                              context.read<ProfileCubit>().translate();
                            },
                            icon: const Icon(Icons.translate_sharp),
                            color:
                                language.isArabic ? Colors.blue : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProfileInformationScreen(
                                profileModel: state.profileModel,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.getHeight(multiply: 0.03),
                            vertical: context.getWidth(multiply: 0.03)),
                        child: ListTile(
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Colors.black),
                          leading: CircleAvatar(
                              radius: 30,
                              onBackgroundImageError: (exception, stackTrace) {
                                const AssetImage(
                                    'assets/image/Search-amico(1).png');
                              },
                              backgroundImage: state.profileModel.imageFile !=
                                      null
                                  ? NetworkImage(state.profileModel.imageFile!)
                                  : const AssetImage(
                                      'assets/image/Search-amico(1).png')),
                          title: Text(
                            '${state.profileModel.firstName} ${state.profileModel.lastName}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            '${state.profileModel.role}  ${state.profileModel.id}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff6E7386),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: context.getHeight(multiply: 0.030),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomeStatusProfile(
                        icon: Icon(
                          Icons.library_books_rounded,
                          size: context.getHeight(multiply: 0.05),
                        ),
                        rating: '${state.profileModel.projects.length}',
                        textTitle: language.isArabic ? 'المشاريع' : 'Projects',
                      ),
                      CustomeStatusProfile(
                        textTitle: language.isArabic ? 'التقييم' : 'Rating',
                        rating: rating,
                        icon: Icon(
                          Icons.star,
                          size: context.getHeight(multiply: 0.05),
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.getHeight(multiply: 0.01),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomeLinksProfile(
                        iconLinks: const FaIcon(
                          FontAwesomeIcons.linkedinIn,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          await openUrl(
                              context: context,
                              url:
                                  "https://${state.profileModel.link.linkedin}");
                        },
                      ),
                      CustomeLinksProfile(
                        iconLinks: const FaIcon(
                          FontAwesomeIcons.github,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          await openUrl(
                              context: context,
                              url: "https://${state.profileModel.link.github}");
                        },
                      ),
                      CustomeLinksProfile(
                        iconLinks: const FaIcon(
                          FontAwesomeIcons.discord,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          await openUrl(
                              context: context,
                              url:
                                  "https://${state.profileModel.link.bindlink}");
                        },
                      ),
                      CustomeLinksProfile(
                        text: 'CV',
                        onTap: () async {
                          await openUrl(
                              context: context,
                              url: state.profileModel.link.resumeFile);
                        },
                      ),
                    ],
                  ),
                  CustomeTitleText(
                    title: language.isArabic ? 'المزيد' : 'More',
                    isArabic: language.isArabic,
                  ),
                  SizedBox(height: context.getHeight(multiply: 0.01)),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: context.getWidth(multiply: 0.03)),
                    padding: EdgeInsets.symmetric(
                        horizontal: context.getWidth(multiply: 0.015),
                        vertical: context.getWidth(multiply: 0.03)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(213, 231, 231, 231)
                              .withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0.5, 0.5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomeListTileProfile(
                          onTap: () {},
                          iconListTile: Icon(
                            LineAwesome.user_astronaut_solid,
                            size: context.getHeight(multiply: 0.035),
                            color: const Color(0xff7822d3),
                          ),
                          colorText: Colors.black,
                          text: language.isArabic
                              ? 'المساعدة والدعم الفني'
                              : 'Help & Support',
                          isArabic: language.isArabic,
                        ),
                        SizedBox(
                          height: context.getHeight(multiply: 0.02),
                        ),
                        CustomeListTileProfile(
                          onTap: () {},
                          iconListTile: Icon(
                            Icons.info_outline,
                            size: context.getHeight(multiply: 0.035),
                            color: const Color(0xff7822d3),
                          ),
                          colorText: Colors.black,
                          text: language.isArabic ? 'عن التطبيق' : 'About App',
                          isArabic: language.isArabic,
                        ),
                        CustomeListTileProfile(
                          onTap: () {
                            if (state.profileModel.role != "user") {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return const ManageProjectScreen();
                                },
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  "You don't have acsess",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          iconListTile: Icon(
                            LineAwesome.user_check_solid,
                            size: context.getHeight(multiply: 0.035),
                            color: const Color(0xff7822d3),
                          ),
                          colorText: Colors.black,
                          text:
                              language.isArabic ? 'ادارة مشروع' : 'Manage project',
                          isArabic: language.isArabic,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.getHeight(multiply: 0.02),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: context.getWidth(multiply: 0.03)),
                    padding: EdgeInsets.symmetric(
                        horizontal: context.getWidth(multiply: 0.015),
                        vertical: context.getWidth(multiply: 0.03)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(213, 231, 231, 231)
                              .withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0.5, 0.5),
                        ),
                      ],
                    ),
                    child: CustomeListTileProfile(
                      onTap: () {
                        authLocator.get<AuthLayerData>().logOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                      },
                      iconListTile: Icon(
                        Icons.logout_outlined,
                        size: context.getHeight(multiply: 0.035),
                        color: const Color.fromARGB(255, 255, 0, 0)
                            .withOpacity(0.70),
                      ),
                      colorText: const Color.fromARGB(255, 255, 0, 0),
                      text: language.isArabic ? 'تسجيل الخروج' : 'Logout',
                      isArabic: language.isArabic,
                    ),
                  ),
                ],
              )),
            );
          }

          if (state is ErorrState) {
            return Center(
              child: Text(state.msg),
            );
          }
          return Column(
            children: [
              context.addSpacer(multiply: 0.3),
              const CircularProgressIndicator(
                color: Color(0xff7822d2),
              ),
            ],
          );
        },
      );
    });
  }
}
