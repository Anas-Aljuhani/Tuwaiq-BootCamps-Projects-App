import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tuwaiq_project/data_layer/language_layer.dart';
import 'package:tuwaiq_project/helper/extinsion/size_config.dart';
import 'package:tuwaiq_project/screens/project_info/project_view_screen.dart';
import 'package:tuwaiq_project/screens/user_project/cubit/user_project_cubit.dart';
import 'package:tuwaiq_project/services/setup.dart';
import 'package:tuwaiq_project/widget/container/project_container.dart';
import 'package:tuwaiq_project/widget/search_screen/info_serch_coulm_widget.dart';

class UserProjectScreen extends StatelessWidget {
  const UserProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final language = languageLocaitor.get<LanguageLayer>();
    return BlocProvider(
      create: (context) => UserProjectCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<UserProjectCubit>();

        cubit.showProjectUser();
        return SizedBox(
          height: context.getHeight(multiply: 0.7),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: context.getWidth(multiply: 0.1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //context.addSpacer(),
                Text(
                  language.isArabic ? 'مشاريعي' : 'My project',
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                SizedBox(
                  height: context.getHeight(multiply: 0.65),
                  child: BlocBuilder<UserProjectCubit, UserProjectState>(
                    builder: (context, state) {
                      if (state is UserProjectSLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is UserProjectErrState) {
                        return InfoSerchCoulmWidget(
                          tex: state.msg,
                        );
                      }

                      if (state is UserProjectShowState) {
                        return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: state.projectList.length,
                          itemBuilder: (context, index) {
                            return ProjectContainer(
                              projectsModel: state.projectList[index],
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return ProjectViewScreen(
                                      projectsModel: state.projectList[index],
                                    );
                                  },
                                ));
                              },
                            );
                          },
                        );
                      }

                      return const InfoSerchCoulmWidget(
                        tex: "Not project...",
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
