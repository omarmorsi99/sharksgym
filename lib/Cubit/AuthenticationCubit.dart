
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sharksgym/Cubit/AuthenticationStates.dart';
import 'package:sharksgym/Models/PostModel.dart';
import 'package:sharksgym/Models/UserModel.dart';


class AuthenticationCubit extends Cubit<AuthenticationStates> {
  AuthenticationCubit() : super(AuthenticationInitialState());

  static AuthenticationCubit get(context) => BlocProvider.of(context);
  final userRef = FirebaseFirestore.instance.collection('users');
  final DateTime timestamp = DateTime.now();
  final currentUserRef = FirebaseAuth.instance;

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required DateTime timestamp,
    bool? isShark,
  }){
    emit(CreateUserInitialState());
    user_model model = user_model(
      userName:name,
      phone:phone,
      bio: 'write your bio...',
      profileUrl: 'https://img.freepik.com/free-vector/no-data-concept-illustration_114360-626.jpg?t=st=1647968280~exp=1647968880~hmac=62d0e8273ca96bb057b05c60e0871c10e64ca22ecd8b8aa7b6e39a81f7605073&w=996',
      coverUrl: 'https://img.freepik.com/free-vector/no-data-concept-illustration_114360-626.jpg?t=st=1647968280~exp=1647968880~hmac=62d0e8273ca96bb057b05c60e0871c10e64ca22ecd8b8aa7b6e39a81f7605073&w=996',
      uId:uId,
      isEmailVerified: false,
      postsCount: 0,
      isAdmin: false,
      isShark: isShark??false,
      mGoal: 'No Goals Yet',
      fGoal: 'No Goals Yet',
      pGoal: 'No Goals Yet',
    );
    emit(CreateUserLoadingState());
    userRef
        .doc(uId)
        .set(
        model.toMap()
    ).then((value) {
      emit(CreateUserSuccessState(uId));
    }
    ).catchError((error){
      emit(CreateUserErrorState(error));
    });

  }

  void userRegister ({
    required String name,
    required String phone,
    required email,
    required password,
    required bool isShark,

  })async{
    emit(RegisterLoadingState());
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(RegisterSuccessState());
      userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid,
          timestamp:timestamp,
          isShark:isShark,
      );
    }).catchError((e) {
      emit(RegisterErrorState(e));
    });

  }

  GoogleSignIn get _googleSignIn => GoogleSignIn(
      scopes: [
        'email',
      ]
  );


  void userLogin({
    String? profileUrl,
    String? name,
    String? phone,
    required email,
    required password,
    int? level,
    String? workoutLevel,
    int? followers,
  }){
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccessState());
    }).catchError((e) {
      emit(LoginErrorState(e.toString()));
    });

  }



  void userLogout(){
    emit(LogoutLoadingState());
    FirebaseAuth.instance.signOut();
    emit(LogoutSuccessState());
  }


  Future<GoogleSignInAccount?> googleSignIn() async{
    emit(GoogleLoginInitialState());

    GoogleSignInAccount? currentuser;


    _googleSignIn.onCurrentUserChanged.listen((account) {
      currentuser = account;
      _googleSignIn.signInSilently();
      emit(GoogleLoginSuccessState());
    });
    await _googleSignIn.signIn();
    return currentuser;
  }
  void googleSignout() async {
    _googleSignIn.disconnect();
    emit(GoogleLogoutSuccessState());
  }

}