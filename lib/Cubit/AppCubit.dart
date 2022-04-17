import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sharksgym/Component/Component.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/CommentsModel.dart';
import 'package:sharksgym/Models/Constants_Training_Model.dart';
import 'package:sharksgym/Models/LikesModel.dart';
import 'package:sharksgym/Models/MessegeModel.dart';
import 'package:sharksgym/Models/PostModel.dart';
import 'package:sharksgym/Models/ProductModel.dart';
import 'package:sharksgym/Models/TrainingModel.dart';
import 'package:sharksgym/Models/UserModel.dart';
import 'package:sharksgym/Post/Add_Post.dart';
import 'package:sharksgym/Screens/Home_Pages/Feeds.dart';
import 'package:sharksgym/Screens/Home_Pages/Chats.dart';
import 'package:sharksgym/Product/Products.dart';
import 'package:sharksgym/Screens/Home_Pages/Workout.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  final userRef = FirebaseFirestore.instance.collection('users');
  final trainingRef = FirebaseFirestore.instance.collection('training');
  final postsRef = FirebaseFirestore.instance.collection('posts');
  final currentUserRef = FirebaseAuth.instance;
  String? postId;
  bool isLiked = false;
  user_model? userModel;
  user_model? userDisplay;
  post_model? postModel;
  training_model? trainingModel;
  List<post_model> userPosts = [];
  List<post_model> adminPosts = [];
  List<training_model> trainings = [];
  List<training_model> archivedTrainings = [];
  List<constant_training_model>? allTrainings = [];
  List<user_model> users = [];
  List<String> likerIds = [];
  List<String> commenterIds = [];
  List<user_model> commenterUsers = [];
  List<product_model> products = [];
  List<user_model> likerUsers = [];
  List<user_model> adminUsers = [];
  List<messege_model> messeges = [];
  List<comments_model> comments = [];


  int currentIndex = 0;
  File? profileImage;
  File? trainingImage;
  File? coverImage;
  File? postImage;
  File? postAdminImage;
  File? productImage;
  File? recordMessage;

  VideoPlayerController? postVideo;
  File? postVideoFile;
  String? postVideoPass;

  final ImagePicker picker = ImagePicker();


  List<Widget> screens = [
    Feeds(),
    Workout(),
    const AddPost(),
    const Products(),
    Chats(),
  ];
  List<String> titles = [
    'Feeds',
    'Workout',
    'AddPost',
    'Products',
    'Chats',
  ];

  double get subtotal => products.fold(0, (total,current) => total + current.price!.toDouble());

  double deliveryFee(subtotal) {
    if(subtotal >= 30)
    {
      return 0.0;
    }
    else {
      return 10.0;
    }
  }

  String get getSubtotalString => subtotal.toStringAsFixed(2);

  String get getDeliveryFeeString => deliveryFee(subtotal).toStringAsFixed(2);


  // Future startRecording() async{
  //   await chatRecord!.start();
  // }
  //
  // Future stopRecording() async{
  //   await chatRecord!.stop();
  // }
  //
  // Future toogleRecording() async{
  //   if( chatRecord!.isPaused())
  //     {await startRecording();}
  //   else {
  //     await stopRecording();
  //   }
  //
  // }

  void getUserData() {
    emit(AppGetUserDataLoadingState());
    userRef.
    doc(currentUserRef.currentUser!.uid)
        .get()
        .then((value) {
      userModel = user_model.fromJson(value.data()!);
      emit(AppGetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUsersErrorState(error.toString()));
    });
  }

  void getExactData(String uId) {
    emit(AppGetUserDataLoadingState());
    userRef.
    doc(uId)
        .get()
        .then((value) {
      userModel = user_model.fromJson(value.data()!);
      emit(AppGetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUsersErrorState(error.toString()));
    });
  }

  void getUserFromPost(String uId) {
    emit(AppGetUserDataLoadingState());
    userRef
        .get()
        .then((value) {
          value.docs.forEach((element) {
            if(element.id == uId){
              userDisplay = user_model.fromJson(element.data());
            }
          });

      emit(AppGetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUsersErrorState(error.toString()));
    });
  }


  void changeBottomNav(int index) {

    if (index == 2) {
      emit(AddPostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavState());
    }
  }

  void changeAnimatedIcon() {

    emit(AppGetUserDataSuccessState());
  }

  Future<void> getPostImage() async {
    emit(PostImagePickedLoadingState());
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    }
    else {
      emit(PostImagePickedErrorState());
    }
  }

  Future<void> getPostVideo() async {
    emit(PostVideoPickedLoadingState());
    final pickedFile = await picker.pickVideo(
        source: ImageSource.gallery
    );

    if (pickedFile != null) {
      postVideoFile = File(pickedFile.path);
      postVideo = VideoPlayerController.file(postVideoFile!)
        ..initialize();
      emit(PostVideoPickedSuccessState());
    }
    else {
      emit(PostVideoPickedErrorState());
    }
  }

  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    }
    else {
      emit(ProfileImagePickedErrorState());
    }
  }

  Future<void> getTrainingImage() async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      trainingImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    }
    else {
      emit(ProfileImagePickedErrorState());
    }
  }

  Future<void> getProductImage() async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      productImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    }
    else {
      emit(ProfileImagePickedErrorState());
    }
  }

  void uploadTrainingImage({

    required String name,
    required String sets,
    required String reps,
  }) {
    emit(UploadProfileLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('training/${Uri
        .file(trainingImage!.path)
        .pathSegments
        .last}')
        .putFile(trainingImage!)
        .then((value) {
      value.ref.getDownloadURL().
      then((value) {
        createConstantTraining(
          image: value,
          name: name,
          sets: sets,
          reps: reps,
        );
      })
          .catchError((error) {
        emit(UploadProfilePickedErrorState());
      });
    }
    );
  }


  void createConstantTraining({
    required String name,
    required String sets,
    required String reps,
    String? image,
  }) {
    emit(CreatePostLoadingState());

    constant_training_model model = constant_training_model(
      name: name,
      sets: sets,
      reps: reps,
      image: image,
      id: '',
    );

    FirebaseFirestore.instance.collection('ConstantTraining')
        .add(model.toMap())
        .then((value) {
      model.id = value.id.trim();

      FirebaseFirestore.instance.collection('ConstantTraining')
          .doc(value.id)
          .update(model.toMap());

      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void uploadProductImage({
    required String name,
    required double price,
  }) {
    emit(UploadProfileLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('products/${Uri
        .file(productImage!.path)
        .pathSegments
        .last}')
        .putFile(productImage!)
        .then((value) {
      value.ref.getDownloadURL().
      then((value) {
        createProduct(
          image: value,
          name: name,
          price: price,
        );
        productImage = File('');
      })
          .catchError((error) {
        emit(UploadProfilePickedErrorState());
      });
    }
    );
  }

  void createProduct({
    required String name,
    required double price,
     String? image,
  }) {
    emit(CreatePostLoadingState());

    product_model model = product_model(
      name: name,
      price: price,
      imageUrl: image,
    );

    FirebaseFirestore.instance.collection('Products')
    .doc(model.name)
        .set(model.toMap())
        .then((value) {

      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void deleteProduct({
    required String name,
  }) {
    emit(CreatePostLoadingState());

    FirebaseFirestore.instance.collection('Products')
        .doc(name)
        .delete();
    emit(CreatePostSuccessState());
  }

  void getProducts() {
    emit(CreatePostLoadingState());

    FirebaseFirestore.instance.collection('Products')
        .get()
    .then((value) {
      products =[];
      value.docs.forEach((element) {
        products.add(product_model.fromJson(element.data()));
      });
    });

    emit(CreatePostSuccessState());
  }

  void deleteConstantTraining({
    required String id,
  }) {
    emit(CreatePostLoadingState());

    FirebaseFirestore.instance.collection('ConstantTraining')
        .doc(id)
        .delete();
    emit(CreatePostSuccessState());
  }


  void getAllTrainings() {
    emit(AppGetUserDataLoadingState());
    allTrainings = [];
    if (allTrainings!.isEmpty) {
      FirebaseFirestore.instance
          .collection('ConstantTraining')
          .snapshots()
          .forEach((element) {
        element.docs.forEach((element) {
          allTrainings!.add(constant_training_model.fromJson(element.data()));
        });
      });
    }
  }

  Future<void> getCoverImage() async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
      showToast(text: "Changed Successfully");
    }
    else {
      emit(CoverImagePickedErrorState());
      showToast(text: "No image selected");
    }
  }


  void uploadProfileImage({
    required String userName,
    required String phone,
    required String bio,
  }) {
    emit(UploadProfileLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().
      then((value) {
        updateUserData(
          userName: userName,
          phone: phone,
          bio: bio,
          profile: value,
        );
        emit(UploadProfileSuccessState());
        emit(UploadProfilePickedSuccessState());
        showToast(text: "Profile Picture Has Been Changed");
      })
          .catchError((error) {
        emit(UploadProfilePickedErrorState());
      });
    }
    ).catchError((error) {
      emit(UploadProfilePickedErrorState());
      showToast(text: "Error during Uploading Profile Picture");
    });
  }

  void uploadCoverImage({
    required String userName,
    required String phone,
    required String bio,
  }) {
    emit(UploadCoverLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().
      then((value) {
        updateUserData(
          userName: userName,
          phone: phone,
          bio: bio,
          cover: value,
        );
        emit(UploadProfilePickedSuccessState());
        showToast(text: "Cover Picture Has Been Changed");
      })
          .catchError((error) {
        emit(UploadProfilePickedErrorState());
        showToast(text: "Error during Uploading Cover Picture");
      });
    }
    ).catchError((error) {
      emit(UploadProfilePickedErrorState());
    });
  }


  updateUserData({
    required String userName,
    required String phone,
    required String bio,
    String? cover,
    String? profile,
    int? postsCount,
  }) {
    emit(UpdateUserLoadingState());
    user_model model = user_model(
      userName: userName,
      uId: userModel!.uId,
      phone: phone,
      bio: bio,
      coverUrl: cover ?? userModel!.coverUrl,
      profileUrl: profile ?? userModel!.profileUrl,
      isAdmin: userModel!.isAdmin,

      postsCount: postsCount,
      isEmailVerified: userModel!.isEmailVerified,
    );

    FirebaseFirestore.instance.collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UploadProfilePickedErrorState());
    });
  }


  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().
      then((value) {
        createPostImage(
          text: text,
          dateTime: dateTime,
          imageUrl: value,
          postId: Uri
              .file(postImage!.path)
              .pathSegments
              .last,
        );
        emit(CreatePostSuccessState());
        showToast(text: "Your Post Uploaded Successfully");
      })
          .catchError((error) {
        emit(CreatePostErrorState());
        showToast(text: "Error during Uploading Your Post");
      });
    }
    ).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void uploadAdminPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().
      then((value) {
        createAdminPostImage(
          text: text,
          dateTime: dateTime,
          imageUrl: value,
          postId: Uri
              .file(postImage!.path)
              .pathSegments
              .last,
        );
        emit(CreatePostSuccessState());
        showToast(text: "Your Post Uploaded Successfully");
      })
          .catchError((error) {
        emit(CreatePostErrorState());
        showToast(text: "Error during Uploading Your Post");
      });
    }
    ).catchError((error) {
      emit(CreatePostErrorState());
    });
  }




  // void uploadPostVideo({
  //   required String text,
  //   required DateTime dateTime,
  // }){
  //
  //   emit(CreatePostLoadingState());
  //   firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri.file(PostVideofile!.path).pathSegments.last}')
  //       .putFile(PostVideofile!)
  //       .then((value){
  //     value.ref.getDownloadURL().
  //     then((value) {
  //       createPost(
  //         text: text,
  //         dateTime: dateTime,
  //         videoUrl:value,
  //       );
  //       emit(CreatePostSuccessState());
  //       showToast(text:"Your Post Uploaded Successfully");
  //     })
  //         .catchError((error){
  //       emit(CreatePostErrorState());
  //       showToast(text:"Error during Uploading Your Post");
  //     });
  //   }
  //   ).catchError((error){
  //     emit(CreatePostErrorState());
  //   });
  // }
  //
  // void uploadPostVideoImage({
  //   required String text,
  //   required DateTime dateTime,
  // }){
  //   emit(CreatePostLoadingState());
  //   firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri.file(PostImage!.path).pathSegments.last}')
  //       .putFile(PostImage!)
  //       .then((value){
  //     value.ref.getDownloadURL().
  //     then((value) {
  //       PostVideoPass = value;
  //     })
  //         .catchError((error){
  //     });
  //   }
  //   ).catchError((error){
  //   });
  //
  //   firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri.file(PostVideofile!.path).pathSegments.last}')
  //       .putFile(PostVideofile!)
  //       .then((value){
  //     value.ref.getDownloadURL().
  //     then((value) {
  //       createPost(
  //         text: text,
  //         dateTime: dateTime,
  //         imageUrl:value,
  //         videoUrl: PostVideoPass,
  //       );
  //       emit(CreatePostSuccessState());
  //       showToast(text:"Your Post Uploaded Successfully");
  //     })
  //         .catchError((error){
  //       emit(CreatePostErrorState());
  //       showToast(text:"Error during Uploading Your Post");
  //     });
  //   }
  //   ).catchError((error){
  //     emit(CreatePostErrorState());
  //   });
  // }

  void createAdminPost({
    required String text,
    String? imageUrl,
    String? videoUrl,
    required String dateTime,
    required String postId,
  }) {
    emit(CreatePostLoadingState());

    post_model model = post_model(
      ownerId: userModel!.uId,
      userName: userModel!.userName,
      userUrl: userModel!.profileUrl,
      description: text,
      mediaUrl: imageUrl ?? "",
      videoUrl: videoUrl ?? "",
      timeStamp: dateTime,
      postId: postId,
      likes: [],
    );

    userRef
    .doc(model.ownerId)
    .collection('userPosts')
    .doc(model.postId)
        .set(model.toMap())
        .then((value) {
      updateUserData(
        userName: userModel!.userName!,
        phone: userModel!.phone!,
        bio: userModel!.bio!,
        postsCount: (userModel!.postsCount! + 1),
      );
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void createAdminPostImage({
    required String text,
    String? imageUrl,
    String? videoUrl,
    required String dateTime,
    String? postId,
  }) {
    emit(CreatePostLoadingState());

    post_model model = post_model(
      ownerId: userModel!.uId,
      userName: userModel!.userName,
      userUrl: userModel!.profileUrl,
      description: text,
      mediaUrl: imageUrl ?? "",
      videoUrl: videoUrl ?? "",
      timeStamp: dateTime,
      postId: postId,
      likes: [],
    );

    userRef
        .doc(model.ownerId)
        .collection('userPosts')
        .doc(model.postId)
        .set(model.toMap())
        .then((value) {
      updateUserData(
        userName: userModel!.userName!,
        phone: userModel!.phone!,
        bio: userModel!.bio!,
        postsCount: (userModel!.postsCount! + 1),
      );
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void createPost({
    required String text,
    String? imageUrl,
    String? videoUrl,
    required String dateTime,
    required String postId,
  }) {
    emit(CreatePostLoadingState());

    post_model model = post_model(
      ownerId: userModel!.uId,
      userName: userModel!.userName,
      userUrl: userModel!.profileUrl,
      description: text,
      mediaUrl: imageUrl ?? "",
      videoUrl: videoUrl ?? "",
      timeStamp: dateTime,
      postId: postId,
      likes: [],
    );

    postsRef
        .doc(model.ownerId)
        .collection('UserPosts')
        .doc(postId)
        .set(model.toMap())
        .then((value) {
      updateUserData(
        userName: userModel!.userName!,
        phone: userModel!.phone!,
        bio: userModel!.bio!,
        postsCount: (userModel!.postsCount! + 1),
      );
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void createPostImage({
    required String text,
    String? imageUrl,
    String? videoUrl,
    required String dateTime,
    String? postId,
  }) {
    emit(CreatePostLoadingState());

    post_model model = post_model(
      ownerId: userModel!.uId,
      userName: userModel!.userName,
      userUrl: userModel!.profileUrl,
      description: text,
      mediaUrl: imageUrl ?? "",
      videoUrl: videoUrl ?? "",
      timeStamp: dateTime,
      postId: postId,
      likes: [],
    );

        postsRef
        .doc(model.ownerId)
        .collection('UserPosts')
        .doc(postId)
        .set(model.toMap())
        .then((value) {
      updateUserData(
        userName: userModel!.userName!,
        phone: userModel!.phone!,
        bio: userModel!.bio!,
        postsCount: (userModel!.postsCount! + 1),
      );
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });

  }


  void getUserPosts(user_model model) {

    emit(GetPostsLoadingState());
    postsRef
        .doc(model.uId)
        .collection('UserPosts')
        .snapshots()
        .listen((event) {
      userPosts = [];
      for (var element in event.docs) {
        userPosts.add(post_model.fromJson(element.data()));
      }
    });
    emit(GetPostsSuccessState());
  }

  void getAdminUserPosts(user_model model) {

    emit(GetPostsLoadingState());
    userRef
        .doc(model.uId)
        .collection('userPosts')
        .snapshots()
        .listen((event) {
      userPosts = [];
      for (var element in event.docs) {
        userPosts.add(post_model.fromJson(element.data()));
      }
    });
    emit(GetPostsSuccessState());
  }

  void getAdminPosts() {

    userRef
        .get()
    .then((value){
      users =[];
      for (var element in value.docs) {
         users.add(user_model.fromJson(element.data()));
      }
    });
    adminUsers =[];
    for (var element in users) {
      if(element.isAdmin == true)
      {
        adminUsers.add(element);
      }

    }
    List<String> adminUsersIds =[];
    adminUsers.forEach((element) {
      adminUsersIds.add(element.uId!);
    });
    adminPosts = [];
    adminUsersIds.forEach((element) {
      userRef
          .doc(element)
          .collection('userPosts')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          adminPosts.add(post_model.fromJson(element.data()));
        });
      });
    });


  }

  void getAdminUsers() {
    userRef
        .get()
    .then((value){
      users =[];

      value.docs.forEach((elementt) {
         users.add(user_model.fromJson(elementt.data()));
      });
    });

    adminUsers =[];
    users.forEach((element) {
      if(element.isAdmin == true)
      {
        if(element.uId == currentUserRef.currentUser!.uid)
          {}
          else{
        adminUsers.add(element);
        }
      }

    });




  }


  void likeAdminPost(post_model model) {

    emit(CommentPostLoadingState());
    likes_model likesModel = likes_model(
      isLiked: true,
      likerId: currentUserRef.currentUser!.uid,
    );
    model.likes!.add(likesModel);
    for (var element in model.likes!) {
      if(element.isLiked == true) {
        userRef
          .doc(model.ownerId)
          .collection('userPosts')
          .doc(model.postId)
          .collection('likes')
          .doc(element.likerId)
          .set(likesModel.toMap())
          .then((value) {
            likesModel.isLiked = false;
        model.likes!.add(likesModel);
        emit(CommentPostSuccessState());
      }).catchError((error) {
        emit(CommentPostErrorState(error.toString()));
      });
      }
      else{
        userRef
            .doc(model.ownerId)
            .collection('userPosts')
            .doc(model.postId)
            .collection('likes')
            .doc(element.likerId)
            .delete();
        model.likes!.removeWhere((element) => element.likerId == likesModel.likerId);
      }
    }
  }


  void getLikeAdminPostCount(post_model model) {
    userRef
        .doc(model.ownerId)
        .collection('userPosts')
        .doc(model.postId)
        .collection('likes')
        .get()
        .then((value) {
      likerIds =[];
       for (var element in value.docs) {
         likerIds.add(element.id);
       }
    });

  }

  void getLikeAdminPostUsers(post_model model) {
    userRef
        .get()
        .then((value) {
      likerUsers =[];
       for (var element in value.docs) {
        for(int i =0 ; i < likerIds.length;i++){
          if(element.id == likerIds[i]){
            likerUsers.add(user_model.fromJson(element.data()));
          }
        }
       }
    });


  }


  void removePostData() {
    postImage = null;
    postVideo = null;
    postVideoFile = null;
    emit(RemovePostDataState());
  }


  void getUsers() {
    emit(GetUsersLoadingState());
    users = [];
    if (users.isEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .listen((event) {
        for (var element in event.docs) {
          users.add(user_model.fromJson(element.data()));
        }
      });
    }
  }


  void updateAdminPostModel({
    required String comment,
    required post_model model,})
  {
    model = post_model(
      ownerId: userModel!.uId,
      userName: userModel!.userName,
      userUrl: userModel!.profileUrl,
      description: model.description,
      mediaUrl: model.mediaUrl ?? "",
      videoUrl: model.videoUrl ?? "",
      timeStamp: model.timeStamp,
    );
  }



  void commentAdminPost({
    required post_model model,
    required String comment,
    required String dateTime,
  }) {
    emit(CommentPostLoadingState());
    comments_model commentModel = comments_model(
      text: comment,
      SenderId: userModel!.uId,
      dateTime: dateTime,
    );

    userRef
    .doc(model.ownerId)
    .collection('userPosts')
        .doc(model.postId)
        .collection('comments')
        .add(commentModel.toMap()).then((value) {
      emit(CommentPostSuccessState());
      commentPostCount(model);
    }).catchError((error) {
      emit(CommentPostErrorState(error.toString()));
    });
  }

  void commentPostCount(post_model model) {
    emit(CommentPostLoadingState());

    userRef
        .doc(model.ownerId)
        .collection('userPosts')
        .doc(model.postId)
    .collection('comments')
        .get().then((value) {
      for (var element in value.docs) {
        // commenterIds.add(comments_model.fromJson(element.data()));
      }
      emit(CommentPostSuccessState());
    }).catchError((error) {
      emit(CommentPostErrorState(error.toString()));
    });
    // ignore: avoid_single_cascade_in_expression_statements
    postsRef
        .doc(model.postId)
      ..update(
          {"commentsCount": FieldValue.increment(1)}
      ).then((value) {}).catchError(() {});
  }

  void getCommentsUsers(post_model model) {
    userRef
        .get()
        .then((value) {
      commenterUsers =[];
      for (var element in value.docs) {
        for(int i = 0 ; i < commenterIds.length;i++){
          if(element.id == commenterIds[i]){
            commenterUsers.add(user_model.fromJson(element.data()));
          }
        }
      }
    });












  }

  void getComments(post_model model, String userId) {
    emit(CommentPostLoadingState());

    userRef
        .doc(model.ownerId)
        .collection('userPosts')
        .doc(model.postId)
        .collection('comments')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      comments = [];
      commenterIds =[];
      for (var element in event.docs) {
        comments.add(comments_model.fromJson(element.data()));
      }
      for (var element in comments) {
        commenterIds.add(element.SenderId!);
      }
      emit(GetMessegesSuccessState());
    });
  }

  void sendMessege({
    required String recieverId,
    required String dateTime,
     String? text,
     File? record,
  }) {
    messege_model model = messege_model(
      text: text??'',
      record: record,
      senderId: userModel!.uId,
      recieverId: recieverId,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messeges')
        .add(model.toMap())
        .then((value) {
      emit(SendMessegeSuccessState());
    }).catchError((error) {
      emit(SendMessegeErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messeges')
        .add(model.toMap())
        .then((value) {
      emit(SendMessegeSuccessState());
    }).catchError((error) {
      emit(SendMessegeErrorState(error.toString()));
    });
  }

  void getMesseges({
    required String receiverId
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messeges')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messeges = [];
      for (var element in event.docs) {
        messeges.add(messege_model.fromJson(element.data()));
      }
      emit(GetMessegesSuccessState());
    });
  }


  void addTraining({
    required user_model uModel,
    required List<constant_training_model> cmodel,
    required int? selectedDay,
    required String? trainingTitle,
  }) {
    training_model model = training_model(
      selectedDay: selectedDay,
      title: trainingTitle,
      uId: uModel.uId,
      trainings: cmodel,
    );

    userRef
        .doc(uModel.uId)
        .collection('training')
        .add(model.toMap())
        .then((value) {
      model.tId = value.id.trim();

      userRef
          .doc(uModel.uId)
          .collection('training')
          .doc(model.tId)
          .update(model.toMap());
    });

  }

  void archiveTraining(training_model model){
    userRef
        .doc(userModel!.uId)
        .collection('archivedTraining')
        .doc()
        .set(model.toMap())
        .then((value) {
        archivedTrainings.add(model);
        trainings.remove(model);
      userRef
          .doc(userModel!.uId)
          .collection('training')
          .doc(model.tId)
          .delete();
    });

  }

  void getTraining(user_model model) {
    emit(AppGetUserDataLoadingState());

      FirebaseFirestore.instance
          .collection('users')
          .doc(model.uId)
          .collection('training')
          .get()
          .then((value) {
        trainings = [];
            for (var element in value.docs) {
                 trainings.add(training_model.fromJson(element.data()));
            }
      });

  }

  void getArchivedTraining(user_model model) {
    emit(AppGetUserDataLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('archivedTraining')
        .get()
        .then((value) {
      archivedTrainings = [];
      for (var element in value.docs) {
        archivedTrainings.add(training_model.fromJson(element.data()));
      }
    });

  }

  void deleteTraining({
    required user_model model,
    required training_model tModel,
  }) {
    emit(CreatePostLoadingState());

    userRef
        .doc(model.uId)
        .collection('training')
        .doc(tModel.tId)
        .delete();

    trainings.remove(tModel);
  }


  void likePost(post_model model) {

    emit(CommentPostLoadingState());
    likes_model likesModel = likes_model(
      isLiked: true,
      likerId: currentUserRef.currentUser!.uid,
    );
    model.likes!.add(likesModel);
    for (var element in model.likes!) {
      if(element.isLiked == true) {
        postsRef
            .doc(model.ownerId)
            .collection('UserPosts')
            .doc(model.postId)
            .collection('likes')
            .doc(element.likerId)
            .set(likesModel.toMap())
            .then((value) {
          likesModel.isLiked = false;
          model.likes!.add(likesModel);
          emit(CommentPostSuccessState());
        }).catchError((error) {
          emit(CommentPostErrorState(error.toString()));
        });
      }
      else{
        postsRef
            .doc(model.ownerId)
            .collection('userPosts')
            .doc(model.postId)
            .collection('likes')
            .doc(element.likerId)
            .delete();
        model.likes!.removeWhere((element) => element.likerId == likesModel.likerId);
      }
    }

  }

  void getLikePostCount(post_model model) {

    postsRef
        .doc(model.ownerId)
        .collection('userPosts')
        .doc(model.postId)
        .collection('likes')
        .get()
        .then((value) {
      likerIds =[];
      value.docs.forEach((element) {
        likerIds.add(element.id);
      });
    });












  }

  void getLikePostUsers(post_model model) {
    userRef
        .get()
        .then((value) {
      likerUsers =[];
      value.docs.forEach((element) {
        for(int i =0 ; i < likerIds.length;i++){
          if(element.id == likerIds[i]){
            likerUsers.add(user_model.fromJson(element.data()));
          }
        }
      });
    });












  }

  void deleteAdminPost({
    required post_model model,
  }) {
    emit(CreatePostLoadingState());

    userRef
        .doc(model.ownerId)
        .collection('userPosts')
        .doc(model.postId)
        .delete();

    adminPosts.remove(model);
  }

}