part of 'edit_bloc.dart';

@immutable
sealed class EditState {}

final class EditInitial extends EditState {}

final class LoadingState extends EditState {}

final class SucsessState extends EditState {
  final String msg;

  SucsessState({required this.msg});
}

final class ErrorState extends EditState {
  final String msg;

  ErrorState({required this.msg});
}

class EditChangeState extends EditState {
  final bool isEdit;
  EditChangeState({required this.isEdit});
}

final class ProjectImagesState extends EditState {
  final File? logoImage;
  final List<File>? projectImage;
  final File? presentationFile;

  ProjectImagesState({
    this.logoImage,
    this.projectImage,
    this.presentationFile,
  });

}


 final class AddMembersState extends EditState {
  final List<String> names;
  final List<String> position;
  AddMembersState( {required this.names , required this.position});

}