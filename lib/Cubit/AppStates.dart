import 'package:firebase_auth/firebase_auth.dart';
import 'package:sharksgym/Models/PostModel.dart';

abstract class AppStates{}

final currentUserRef = FirebaseAuth.instance;
class AppInitialState extends AppStates{}
class AppGetUserDataLoadingState extends AppStates{}
class AppGetUserDataSuccessState extends AppStates{}
class AppGetUserDataErrorState extends AppStates{
  String error;
  AppGetUserDataErrorState(this.error);
}

class ChangeBottomNavState extends AppStates{}
class AddPostState extends AppStates{}

class ProfileImagePickedSuccessState extends AppStates{}
class ProfileImagePickedErrorState extends AppStates{}

class CoverImagePickedSuccessState extends AppStates{}

class CoverImagePickedErrorState extends AppStates{}

class UploadProfilePickedLoadingState extends AppStates{}
class UploadProfilePickedSuccessState extends AppStates{}
class UploadProfilePickedErrorState extends AppStates{}

class UpdateUserLoadingState extends AppStates{}
class UpdateUserSuccessState extends AppStates{}
class UpdateUserErrorState extends AppStates{}

class UploadProfileLoadingState extends AppStates{}
class UploadProfileSuccessState extends AppStates{}
class UploadCoverLoadingState extends AppStates{}
class UploadCoverSuccessState extends AppStates{}


class CreatePostLoadingState extends AppStates{}
class CreatePostSuccessState extends AppStates{}
class CreatePostErrorState extends AppStates{}

class PostImagePickedLoadingState extends AppStates{}
class PostImagePickedSuccessState extends AppStates{}
class PostImagePickedErrorState extends AppStates{}

class PostVideoPickedLoadingState extends AppStates{}
class PostVideoPickedSuccessState extends AppStates{}
class PostVideoPickedErrorState extends AppStates{}

class RemovePostDataState extends AppStates{}


class GetPostsLoadingState extends AppStates{}
class GetPostsSuccessState extends AppStates{}
class GetPostsErrorState extends AppStates{
  String error;
  GetPostsErrorState(this.error);
}
class RemovePostsLoadingState extends AppStates{}
class RemovePostsSuccessState extends AppStates{}
class RemovePostsErrorState extends AppStates{
  String error;
  RemovePostsErrorState(this.error);
}

class GetUsersLoadingState extends AppStates{}
class GetUsersSuccessState extends AppStates{}
class GetUsersErrorState extends AppStates{
  String error;
  GetUsersErrorState(this.error);
}

class LikePostLoadingState extends AppStates{}
class LikePostSuccessState extends AppStates{}
class unLikePostSuccessState extends AppStates{}

class CommentPostLoadingState extends AppStates{}
class CommentPostSuccessState extends AppStates{}
class CommentPostErrorState extends AppStates{
  String error;
  CommentPostErrorState(this.error);
}

class SendMessegeSuccessState extends AppStates{}
class SendMessegeErrorState extends AppStates{
  String error;
  SendMessegeErrorState(this.error);
}
class GetMessegesSuccessState extends AppStates{}

class GetCurrentUserPostSuccessState extends AppStates{}


