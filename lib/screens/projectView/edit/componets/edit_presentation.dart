import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project/data_layer/language_layer.dart';
import 'package:tuwaiq_project/helper/extinsion/size_config.dart';
import 'package:tuwaiq_project/screens/projectView/edit/bloc/edit_bloc.dart';
import 'package:tuwaiq_project/widget/button/custom_button.dart';

class EditPresentation extends StatelessWidget {
  const EditPresentation({
    super.key,
    required this.bloc,
    required this.languageLayer,
  });

  final EditBloc bloc;
  final LanguageLayer languageLayer;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.symmetric(horizontal: context.getWidth(multiply: 0.1)),
      child: BlocBuilder<EditBloc, EditState>(
        builder: (context, state) {
          Future<void> pickFile({
            required EditEvent Function(File) createEvent,
            required Function(File) updateFile,
          }) async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.any,
            );
            if (result != null) {
              final selectedFile = File(result.files.single.path!);
              updateFile(selectedFile);
              bloc.add(createEvent(selectedFile));
            }
          }

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    languageLayer.isArabic
                        ? 'تعديل العرض'
                        : 'Edit Presentation',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    '3 / 7 >',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
              context.addSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      languageLayer.isArabic
                          ? 'ارفع العرض'
                          : 'upload Presentation',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      ' *',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    )
                  ],
                ),
              ),
              context.addSpacer(multiply: 0.008),
              Container(
                  margin: const EdgeInsets.only(top: 7, bottom: 32),
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xffededed)),
                  child: state is ProjectImagesState &&
                          state.presentationFile != null
                      ? Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Center(
                                child: Text(state.presentationFile!.path
                                    .split('/')
                                    .last)),
                            Positioned(
                              left: context.getWidth(multiply: 0.68),
                              bottom: context.getHeight(multiply: 0.1),
                              child: IconButton(
                                  onPressed: () {
                                    bloc.presentation = null;
                                    bloc.add(DefaultEvent());
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ),
                          ],
                        )
                      : IconButton(
                          onPressed: () {
                            pickFile(
                              createEvent: (file) =>
                                  FilePickedEvent(selectedFile: file),
                              updateFile: (p0) => {},
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 65,
                            color: Color(0xff969696),
                          ))),
              CustomButton(
                englishTitle: 'Edit',
                arabicTitle: 'تعديل',
                onPressed: () {
                  if (bloc.presentation != null) {
                    bloc.add(ChangePresentationEvent());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Upload file first')));
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
