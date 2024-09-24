

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:tuwaiq_project/data_layer/language_layer.dart';

import 'package:tuwaiq_project/models/profile_model.dart';
import 'package:tuwaiq_project/networking/networking_api.dart';
import 'package:tuwaiq_project/services/setup.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final language = languageLocaitor.get<LanguageLayer>();
  ProfileCubit() : super(ProfileInitial());

  getProfile() async {
    emit(ProfileInitial());

    ProfileModel profileModel = await NetworkingApi().profileGet();
    emit(ShowProfileState(profileModel: profileModel));
  }

  translate() {
    language.isArabic = !language.isArabic;
    emit(ArabicState(isArabic: language.isArabic));
  }

  
}
