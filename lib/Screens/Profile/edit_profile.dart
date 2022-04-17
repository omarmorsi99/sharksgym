import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Component/Component.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var bioController = TextEditingController();

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state) {
        var UserModel = AppCubit.get(context).userModel;
        var ProfileImage = AppCubit.get(context).profileImage;
        var CoverImage = AppCubit.get(context).coverImage;
        var name = AppCubit.get(context).userModel!.userName;
        var phone = AppCubit.get(context).userModel!.phone;
        var bio = AppCubit.get(context).userModel!.bio;

        nameController.text = name!;
        phoneController.text = phone!;
        bioController.text = bio!;
       return Scaffold(
          appBar: AppBar(
            elevation: 5.0,
            title:  Text('Edit Profile', style: GoogleFonts.hahmlet(
              color: Colors.redAccent
            )),
            backgroundColor: Colors.white,
            titleSpacing: 5.0,
            leading: IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back_ios),color: Colors.redAccent,),
            actions: [
              TextButton(onPressed: (){
                AppCubit.get(context).updateUserData(userName: nameController.text, phone: phoneController.text, bio: bioController.text);
                showToast(text: 'Profile Data Changed Successfully');

              }, child: Text('update'.toUpperCase(), style: GoogleFonts.hahmlet(
                color: Colors.redAccent,
              ),),),
              const SizedBox(width: 15.0,),
            ],
          ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if(state is UpdateUserLoadingState)
                  const LinearProgressIndicator(color: Colors.redAccent,),
                SizedBox(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                      child: Stack(
                         children: [
                            Container(
                             height: 130.0,
                             width: double.infinity,
                             decoration:   BoxDecoration(
                               borderRadius: const BorderRadius.only(
                                 topLeft: Radius.circular(4.0),
                                 topRight: Radius.circular(4.0),
                               ),

                               image: DecorationImage(
                                 image: CoverImage == null ? NetworkImage("${UserModel?.coverUrl}") : FileImage(CoverImage) as ImageProvider,
                                 fit: BoxFit.cover,
                               ),
                             ),
                           ),
                            CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.redAccent,
                              child: IconButton(onPressed: (){
                                AppCubit.get(context).getCoverImage();
                              },
                                  icon: const Icon(Icons.camera_alt_outlined),color: Colors.white,),
                            )
                         ],
                       ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 63.0,
                        backgroundColor: Colors.redAccent,
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: ProfileImage == null ? NetworkImage("${UserModel?.profileUrl}") : FileImage(ProfileImage) as ImageProvider,
                         child: Align(
                           child: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.redAccent,
                              child: IconButton(onPressed: () async {

                              AppCubit.get(context).getProfileImage();
                              },
                                icon: const Icon(Icons.camera_alt_outlined),color: Colors.white,),
                            ),
                           alignment: AlignmentDirectional.bottomEnd,
                         ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                if(AppCubit.get(context).coverImage != null || AppCubit.get(context).profileImage != null)
                  Row(
                    children: [
                      if(AppCubit.get(context).coverImage != null)
                       Expanded(
                        child: Column(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                AppCubit.get(context).uploadCoverImage(userName: nameController.text, phone: phoneController.text, bio: bioController.text, );
                              },
                              child: Text('Update Cover'.toUpperCase(), style: GoogleFonts.hahmlet(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.redAccent.withOpacity(0.8),
                              ),),
                            ),
                            const SizedBox(height: 2,),
                            if(state is UploadCoverLoadingState)
                               const LinearProgressIndicator(color: Colors.redAccent,
                                minHeight: 2,),


                          ],
                        ),
                      ),
                      const SizedBox(width: 5.0,),
                      if(AppCubit.get(context).profileImage != null)
                      Expanded(
                        child: Column(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                AppCubit.get(context).uploadProfileImage(userName: nameController.text, phone: phoneController.text, bio: bioController.text);

                              },
                              child: Text('Update Profile'.toUpperCase(), style: GoogleFonts.hahmlet(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.redAccent.withOpacity(0.8),
                              ),),
                            ),
                             const SizedBox(height: 2,),
                             if(state is UploadProfileLoadingState)
                             const LinearProgressIndicator(color: Colors.redAccent,
                            minHeight: 2,),
                          ],
                        ),
                      ),

                    ],
                  ),
                if(AppCubit.get(context).coverImage != null || AppCubit.get(context).profileImage != null)
                const SizedBox(height: 20,),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  onFieldSubmitted: (value){

                  },
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'name cannot be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.white60,
                      filled: true,
                      focusColor: Colors.redAccent,

                      labelStyle: TextStyle(color: Colors.redAccent),
                      prefixIcon: Icon(Icons.person_pin_circle_outlined,color: Colors.redAccent,),
                      focusedBorder: OutlineInputBorder(),

                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                  onFieldSubmitted: (value){

                  },
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'phone cannot be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.white60,
                      filled: true,
                      focusColor: Colors.redAccent,
                      labelStyle: TextStyle(color: Colors.redAccent),
                      prefixIcon: Icon(Icons.phone_locked_outlined,color: Colors.redAccent,),
                      focusedBorder: OutlineInputBorder(),

                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: bioController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  onFieldSubmitted: (value){

                  },
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'bio cannot be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.white60,
                      filled: true,
                      focusColor: Colors.redAccent,

                      labelStyle: TextStyle(color: Colors.redAccent),
                      prefixIcon: Icon(Icons.info,color: Colors.redAccent,),
                      focusedBorder: OutlineInputBorder(),

                  ),
                ),
              ],
            ),
          ),
        ),
        );
      }

    );
  }
}
