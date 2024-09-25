import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project/data_layer/language_layer.dart';
import 'package:tuwaiq_project/helper/extinsion/size_config.dart';
import 'package:tuwaiq_project/screens/projectView/edit/bloc/edit_bloc.dart';
import 'package:tuwaiq_project/widget/button/custom_button.dart';
import 'package:tuwaiq_project/widget/column/date_coulmn.dart';

import 'package:tuwaiq_project/widget/textformfeild/normal_text_form_feild.dart';

class EditBase extends StatelessWidget {
  const EditBase({
    super.key,
    required this.languageLayer,
    required this.bloc,
  });

  final LanguageLayer languageLayer;
  final EditBloc bloc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.symmetric(horizontal: context.getWidth(multiply: 0.08)),
      child: BlocBuilder<EditBloc, EditState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    languageLayer.isArabic ? 'تعديل المتن' : 'Edit base',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    '2 / 7 >',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
              context.addSpacer(multiply: 0.025),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    languageLayer.isArabic ? 'اسم المشروع' : 'Project name',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  context.addSpacer(multiply: 0.008),
                  NormalTextFormFeild(
                    hintText: 'Clothes app',
                    controller: bloc.projectNameController,
                  ),
                  context.addSpacer(multiply: 0.008),
                  Text(
                    languageLayer.isArabic ? 'اسم المعسكر' : 'Boot-Camp Name',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  context.addSpacer(multiply: 0.008),
                  NormalTextFormFeild(
                    hintText: 'Flutter bootcamp',
                    controller: bloc.bootcampNameController,
                  ),
                  context.addSpacer(multiply: 0.02),
                  Text(
                    languageLayer.isArabic ? 'نوع المشروع' : 'project type',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  context.addSpacer(multiply: 0.008),
                  NormalTextFormFeild(
                    hintText: 'apps',
                    controller: bloc.typeController,
                  ),
                  context.addSpacer(multiply: 0.02),
                  DateCoulmn(bloc: bloc),
                  context.addSpacer(multiply: 0.02),
                  Text(
                    languageLayer.isArabic
                        ? 'وصف المشروع'
                        : 'Project Description',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  context.addSpacer(multiply: 0.008),
                  NormalTextFormFeild(
                    hintText: 'Write Project Description',
                    minLines: 4,
                    controller: bloc.projectDescriptionController,
                  ),
                ],
              ),
              context.addSpacer(multiply: 0.02),
              CustomButton(
                englishTitle: 'Edit Base',
                arabicTitle: 'تعديل المتن',
                onPressed: () {
                  if (bloc.startDate.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Start date is required'),
                      backgroundColor: Colors.red,
                    ));
                  }
                  if (bloc.startDate.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Start date is required'),
                      backgroundColor: Colors.red,
                    ));
                  }
                  if (bloc.startDate.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Start date is required'),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    bloc.add(ChangeBaseEvent());
                  }
                },
                arabic: languageLayer.isArabic,
              ),
            ],
          );
        },
      ),
    );
  }
}
