import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Models/PostModel.dart';
var inputController = TextEditingController();

Widget defaultFButton ({
  required String text,
  required double width ,
  required Color background,
  required Function function,
}) => Container(
  width: width,
  color: background,
  child: MaterialButton(
    onPressed: function(),

    child: Text(text.toUpperCase() , style: GoogleFonts.lato(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),),
  ),

);

Widget imageDialog(String imageurl ) =>
    Dialog(
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration:  BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imageurl),
                  fit: BoxFit.cover
              )
          ),
        ),
      ),
    );


Widget TextForm({
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  required String text,
  required bool isHidden,
  required IconData prefix,
  IconData? suffix,
  required Function onSubmit,
  required Function onChange,

}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onChanged: onChange(),
  onFieldSubmitted: onSubmit(),
  obscureText: isHidden,
  validator: (value) {
    return validate(value);
  },
  decoration: InputDecoration(
      labelText: text,
      prefixIcon: Icon(prefix),
      suffixIcon: Icon(suffix!),
      border: const OutlineInputBorder()
  ),
);

void showToast({required String text}){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blueGrey,
      textColor: Colors.white,
      fontSize: 12.0
  );
}
void postPopup(context,post_model model, Color color) =>
       Alert(
         context: context,
        title: model.userName!.toUpperCase(),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model.timeStamp}',style: GoogleFonts.hahmlet(
                    fontSize: 10,
                    color: Colors.grey
                ),),

              if(model.description != null)
                Text('${model.description}',style: GoogleFonts.hahmlet(
                  fontSize: 16,
                  color: color
                ),),
                const SizedBox(height: 10,),
                if(model.mediaUrl != null)
                   Image.network('${model.mediaUrl}',
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/broken-1.png',
                          width: 300, height: 200, fit: BoxFit.contain);
                    },
                  ),

                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        likePopup(context, model,  color,);
                      },
                      child: Row(
                        children: [
                          Text('${AppCubit.get(context).likerUsers.length}',style: const TextStyle(
                            fontSize: 16,

                          ),),
                          const SizedBox(width: 5.0,),
                           Icon(Icons.monitor_heart_outlined,color: color,size: 26,)
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: (){
                        commentPopup(context, model,  color,);
                      },
                      child: Row(
                        children: [
                          Text('${AppCubit.get(context).commenterUsers.length}',style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,

                          ),),
                          const SizedBox(width: 5.0,),
                           Icon(Icons.mark_chat_read,color: color,size: 26,)
                        ],
                      ),
                    ),
                  ],
                ),


        ],
            ),
        buttons: [
          DialogButton(
        onPressed: () => Navigator.pop(context),
             child:  const Text(
              "Close",
           style: TextStyle(color: Colors.white, fontSize: 20),
          ),
            color: color,
    ),

      ]).show();

void likePopup(context,post_model model, Color color,)
{
  AppCubit.get(context).getLikeAdminPostCount(model);
  AppCubit.get(context).getLikeAdminPostUsers(model);
  Alert(
      context: context,
      title: '${AppCubit.get(context).likerIds.length}',
      content: SizedBox(
        width: 200,
        height: 400,
        child: SingleChildScrollView(
          child: ConditionalBuilder(
            condition: AppCubit.get(context).likerUsers.isNotEmpty,
            builder: (context){
           return  Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index) {

                        return Row(
                        children: [
                            CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage('${AppCubit.get(context).likerUsers[index].profileUrl}'),
                              ),
                          const SizedBox(width: 15,),
                          Text('${AppCubit.get(context).likerUsers[index].userName}',style: GoogleFonts.hahmlet(
                            fontSize: 18,
                            color: color,
                          ),
                          ),
                        ],
                      );
                      },

                    separatorBuilder: (context,index) => const SizedBox(
                      height: 8,
                    ),
                    itemCount: AppCubit.get(context).likerUsers.length),
              ],
            );
            }, fallback: (BuildContext context) {
              return const CircularProgressIndicator(color: Colors.redAccent,);
          },
          ),
        ),
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child:  const Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          color: color,
        ),

      ]).show();
}

void commentPopup(context,post_model model, Color color,)
{
  AppCubit.get(context).getCommentsUsers(model);
  AppCubit.get(context).getComments(model, model.ownerId!);

  Alert(
      context: context,
      title: '${AppCubit.get(context).comments.length}',
      content: SizedBox(
        width: 200,
        height: 400,
        child: SingleChildScrollView(
          child: ConditionalBuilder(
            fallback: (BuildContext context) {
              return const CircularProgressIndicator(color: Colors.redAccent,);
            },
            condition: AppCubit.get(context).commenterUsers.isNotEmpty,
            builder: (context){
            return Column(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index) {
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage('${AppCubit.get(context).commenterUsers[index].profileUrl}'),
                          ),
                          const Spacer(),
                          Text('${AppCubit.get(context).comments[index].text}',style: GoogleFonts.hahmlet(
                            fontSize: 12,
                            color: color,
                          ),)
                        ],
                      );
                    },
                    separatorBuilder: (context,index) => const SizedBox(
                      height: 1,
                    ),
                    itemCount: AppCubit.get(context).comments.length),
              ],
            );
            },
          ),
        ),
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child:  const Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          color: color,
        ),

      ]).show();
}



