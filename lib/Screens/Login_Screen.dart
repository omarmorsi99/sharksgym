
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sharksgym/Cubit/AuthenticationCubit.dart';
import 'package:sharksgym/Screens/Home.dart';
import 'package:sharksgym/Screens/Register_Screen.dart';

class Login_Screen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),),
          title: Text('Login' , style: GoogleFonts.hahmlet(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),),
        ),

        body: Container(
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8),
                  BlendMode.dstATop
              ),
              image: const AssetImage(
                'assets/images/background2.jpg',
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Login",style: GoogleFonts.hahmlet(
                        fontSize: 46.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),),
                      const SizedBox(height: 20.0,),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        onFieldSubmitted: (value){

                        },
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Email cannot be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder()
                        ),
                      ),
                      const SizedBox(height: 20.0,),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'password cannot be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Icon(Icons.visibility),
                            border: OutlineInputBorder()
                        ),

                      ),
                      const SizedBox(height: 20.0,),
                      MaterialButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()) {

                            AuthenticationCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                            // Navigator.push(context, MaterialPageRoute(
                            //     builder: (context) =>  Home_Screen()));
                            Navigator.push(context,
                                PageTransition(type: PageTransitionType.rightToLeft,
                                    duration: const Duration(seconds: 2),
                                    child: Home_Screen()));
                          }
                        },

                        child: Text("Submit".toUpperCase() , style: GoogleFonts.hahmlet(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),),
                      ),
                      const SizedBox(height: 20.0,),
                      ElevatedButton.icon(
                        icon: const FaIcon(FontAwesomeIcons.google , color: Colors.blue,),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.blue,
                            minimumSize: const Size(double.infinity,50)
                        ),
                        onPressed: (){
                        },
                        label: Text("Google Sign In" ,style: GoogleFonts.hahmlet(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),),),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text("Don't have an Account," ,style: GoogleFonts.hahmlet(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),
                          ),

                          TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Register_Screen()));
                            },
                            child: const Text("Register", ),),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
