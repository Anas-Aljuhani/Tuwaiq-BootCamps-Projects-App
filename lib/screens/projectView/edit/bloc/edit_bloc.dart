import 'dart:async';

import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project/networking/networking_api.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final api = NetworkingApi();

  String projectId = '';
  bool isEdit = true;
  bool isPublic = true;
  bool allowRating = true;
  File? logoImage;
  List<File>? projectImages;
  File? presentation;
  List<int>? presentationAsList;
  String startDate = '';
  String endDate = '';
  String presentationDate = '';
  //====base controller========
  TextEditingController projectNameController =
      TextEditingController(text: 'test');
  TextEditingController bootcampNameController =
      TextEditingController(text: 'Flutter Bootcamp');
  TextEditingController typeController = TextEditingController(text: 'app');

  TextEditingController projectDescriptionController = TextEditingController(
      text: 'This is a sample project description for testing purposes.');
  //==========================

  //=====Links Controller=============
  TextEditingController githubController =
      TextEditingController(text: 'https://github.com/example');
  TextEditingController figmaController =
      TextEditingController(text: 'https://figma.com/example');
  TextEditingController videoController =
      TextEditingController(text: 'https://youtube.com/example');
  TextEditingController pinterestController =
      TextEditingController(text: 'https://pinterest.com/example');
  TextEditingController playstoreController = TextEditingController(
      text: 'https://play.google.com/store/apps/details?id=example');
  TextEditingController applestoreController =
      TextEditingController(text: 'https://apps.apple.com/app/idexample');
  TextEditingController apkController =
      TextEditingController(text: 'https://example.com/app.apk');
  TextEditingController weblinkController =
      TextEditingController(text: 'https://example.com');

  TextEditingController memberIdController =
      TextEditingController(text: 'ammar');

  TextEditingController memberPositionController =
      TextEditingController(text: 'logic');

  final List<String> nameList = [];
  final List<String> positionList = [];
//=====================
  EditBloc() : super(EditInitial()) {
    on<EditEvent>((event, emit) async {});
    on<DefaultEvent>((event, emit) async {
      emit(EditInitial());
    });

    on<ChangeStatusEvent>((event, emit) async {
      try {
        final res = await api.changeProjectState(
            timeEndEdit: endDate.trim(),
            allowEdit: isEdit,
            allowRating: allowRating,
            allowPublic: isPublic,
            projectId: event.projectId);

        emit(SucsessState(msg: 'state change sucsessfuly'));
      } on DioException catch (error) {
        emit(ErrorState(msg: '${error.message}'));
      } catch (e) {
        emit(ErrorState(msg: '$e'));
      }
    });

    on<ChangeImagesEvent>(changeImagesMethod);
    on<ChangeLogoEvent>(changeLogoMethod);
    on<ChangeLinksEvent>(changeLinksMethod);
    on<ChangePresentationEvent>(changePresentationMethod);

    on<ChangeBaseEvent>(changeBaseMethod);

    on<AddMembersEvent>(addMemberMethod);
    on<IsEditEvent>((event, emit) {
      isEdit = event.isEdit;
      emit(EditStatusState(isEdit: isEdit));
    });
    on<IsPublicEvent>((event, emit) {
      isPublic = event.isPublic;
      emit(PublicStatusState(isPublic: isPublic));
    });
    on<AllowRatingEvent>((event, emit) {
      allowRating = event.allowRating;
      emit(RatingStatusState(allowRating: allowRating));
    });
    on<ChangeMembersEvent>((event, emit) async {
      List<Map<String, dynamic>> lis = [];

      for (int i = 0; i < positionList.length; i++) {
        lis.add({
          "user_id": nameList[i],
          "position": positionList[i],
        });

        try {
          emit(LoadingState());
          final res =
              await api.chnageMembers(projectId: projectId, members: lis);
          emit(SucsessState(msg: res.toString()));
        } on DioException catch (error) {
          emit(ErrorState(msg: '${error.message}'));
        } catch (e) {
          emit(ErrorState(msg: '$e'));
        }
      }
    });

    //file picker event
    on<FilePickedEvent>((event, emit) async {
      try {
        presentation = event.selectedFile;

        emit(LoadingState());

        Uint8List fileAsList = await presentation!.readAsBytes();

        presentationAsList = fileAsList.toList();

        emit(SucsessState(msg: 'File upload susessfully'));
        emit(ProjectImagesState(presentationFile: presentation));
      } catch (e) {
        emit(ErrorState(msg: '$e'));
      }
    });
    //image picker event
    on<LogoImageChangeEvent>((event, emit) async {
      logoImage = event.selectedImage;
      emit(ProjectImagesState(
        logoImage: logoImage,
      ));
    });

    on<ProjectImagesChangeEvent>((event, emit) {
      projectImages = event.selectedImages;
      emit(ProjectImagesState(projectImage: projectImages));
    });
  }

  FutureOr<void> changeImagesMethod(event, emit) async {
    try {
      List<Uint8List> imagesAsList = [];
      for (var element in projectImages!) {
        imagesAsList.add(element.readAsBytesSync());
      }
      emit(LoadingState());
      await api.chnageImage(projectImgs: imagesAsList, projectId: projectId);

      emit(SucsessState(msg: 'Project images change sucsessfully'));
      logoImage = null;
    } on DioException catch (error) {
      emit(ErrorState(msg: '${error.message}'));
    } catch (e) {
      emit(ErrorState(msg: '$e'));
    }
  }

  FutureOr<void> changeLinksMethod(event, emit) async {
    try {
      emit(LoadingState());
      final res = await api.chnageLinks(
          links: generateLinksList(), projectId: projectId);
      emit(SucsessState(msg: 'Links change sucsessfully'));
    } on DioException catch (error) {
      emit(ErrorState(msg: '${error.message}'));
    } catch (e) {
      emit(ErrorState(msg: '$e'));
    }
  }

  FutureOr<void> changePresentationMethod(event, emit) async {
    try {
      emit(LoadingState());
      final res = await api.chnagePresentation(
          presentationFile: presentationAsList!, projectId: projectId);

      emit(SucsessState(msg: 'Presentation change susessfully'));
    } on DioException catch (error) {
      emit(ErrorState(msg: '${error.message}'));
    } catch (e) {
      emit(ErrorState(msg: '$e'));
    }
  }

  FutureOr<void> changeBaseMethod(event, emit) async {
    try {
      emit(LoadingState());
      final res = await api.chnageBaseData(
          projectId: projectId,
          projectName: projectNameController.text.trim(),
          bootcampName: bootcampNameController.text.trim(),
          type: typeController.text.trim(),
          startDate: startDate,
          endDate: endDate,
          presentationDate: presentationDate,
          projectDescription: projectDescriptionController.text.trim());

      emit(SucsessState(msg: 'Base change susesfully'));
    } on DioException catch (error) {
      emit(ErrorState(msg: '${error.message}'));
    } catch (e) {
      emit(ErrorState(msg: '$e'));
    }
  }

  FutureOr<void> changeLogoMethod(event, emit) async {
    try {
      emit(LoadingState());
      Uint8List imageAsList = await logoImage!.readAsBytes();
      await api.chnagelogo(
          logoImg: imageAsList.toList(growable: false), projectId: projectId);
      emit(SucsessState(msg: 'Project logo change sucsessfully'));
      logoImage = null;
    } on DioException catch (error) {
      emit(ErrorState(msg: '${error.message}'));
    } catch (e) {
      emit(ErrorState(msg: '$e'));
    }
  }

  List<Map<String, String?>> generateLinksList() {
    List<Map<String, String?>> links = [];

    if (githubController.text.isNotEmpty) {
      links.add({"type": "github", "url": githubController.text});
    }
    if (figmaController.text.isNotEmpty) {
      links.add({"type": "figma", "url": figmaController.text});
    }
    if (videoController.text.isNotEmpty) {
      links.add({"type": "video", "url": videoController.text});
    }
    if (pinterestController.text.isNotEmpty) {
      links.add({"type": "pinterest", "url": pinterestController.text});
    }
    if (playstoreController.text.isNotEmpty) {
      links.add({"type": "playstore", "url": playstoreController.text});
    }
    if (applestoreController.text.isNotEmpty) {
      links.add({"type": "applestore", "url": applestoreController.text});
    }
    if (apkController.text.isNotEmpty) {
      links.add({"type": "apk", "url": apkController.text});
    }
    if (weblinkController.text.isNotEmpty) {
      links.add({"type": "weblink", "url": weblinkController.text});
    }

    return links;
  }

  addMemberMethod(event, emit) async {
    nameList.add(memberIdController.text);
    positionList.add(memberPositionController.text);
    memberIdController.clear();
    memberPositionController.clear();

    emit(AddMembersState(names: nameList, position: positionList));
  }
}
