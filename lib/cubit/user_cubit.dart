// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable
import 'package:auth/core/api/api_consumer.dart';
import 'package:auth/core/api/end_points.dart';
import 'package:auth/core/errors/exceptions.dart';
import 'package:auth/cubit/user_state.dart';
import 'package:auth/functions/upload_image_to_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserCubit extends Cubit<UserState> {
  final ApiConsumer api;
  UserCubit(this.api) : super(UserInitial());
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  XFile? profilePic;
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();

  uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UploadingProfileImage());
  }

  Future SignUp() async {
    try {
      emit(SignUpLoading());
      final response = api.post(
        EndPoint.signUp,
        data: {
          ApiKey.name: signUpName.text,
          ApiKey.phone: signUpPhoneNumber.text,
          ApiKey.email: signUpEmail.text,
          ApiKey.password: signUpPassword.text,
          ApiKey.confirmPassword: confirmPassword.text,
          ApiKey.location:
              '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
          ApiKey.profilePic: await uploadImageToAPI(profilePic!)
        },
        isFormData: true,
      );
      emit(SignUpSuccess());
      return response;
    } on serverExceptions catch (e) {
      emit(SignUpFailure(errMessage: e.errorModel.errorMessage));
    }
  }

  Future SignIn() async {
    try {
      emit(SignInLoading());
      final response = await api.post(EndPoint.signIn, data: {
        ApiKey.email: signInEmail.text,
        ApiKey.password: signInPassword.text,
      });
      emit(SignInSuccess());
    } on serverExceptions catch (e) {
      emit(SignInFailure(errMessage: e.errorModel.errorMessage));
      print(e.toString());
    }
  }
}
