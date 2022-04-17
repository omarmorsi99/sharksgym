import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/ProductModel.dart';
import 'package:sharksgym/Product/Super_Product_Content.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getProducts();
        return BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state){
            return  RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                AppCubit.get(context).getAdminPosts();
              },
              child: ConditionalBuilder(
                condition: AppCubit.get(context).products.isNotEmpty,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => buildProductItem(AppCubit.get(context).products[index],context),
                            separatorBuilder:(context,index) => Container( width: double.infinity,height: 1, color: Colors.grey,),
                            itemCount: AppCubit.get(context).products.length)
                      ],
                    ),
                  );
                }, fallback: (BuildContext context) {
                return  Center( child: Center(
                  child: Column(children:  [
                    const CircularProgressIndicator(color: Colors.blue,),
                    const SizedBox( height: 10,),
                    Text('NO PRODUCT ADDED YET'  ,style: GoogleFonts.hahmlet(
                    fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),)
                  ],),
                ), );
              },
              ),
              color: Colors.white,
              backgroundColor: Colors.blue,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
            );
          },

        );



  }
}

InkWell buildProductItem(product_model model,context) =>
    InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Super_Product_Content(model: model,)));
      },
      child: Container(
        color: Colors.amber[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage('${model.imageUrl}',),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(model.name!.toUpperCase() ,style: GoogleFonts.hahmlet(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('${model.price} EGP',style: GoogleFonts.hahmlet(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
