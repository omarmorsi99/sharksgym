import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sharksgym/Cubit/AuthenticationCubit.dart';
import 'package:sharksgym/Cubit/AuthenticationStates.dart';
import 'package:sharksgym/Screens/Home.dart';
import 'package:sharksgym/Screens/Login_Screen.dart';

class Register_Screen extends StatefulWidget {
  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  var emailController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  bool isShark = false;

  var idController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Register',
            style: GoogleFonts.hahmlet(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.dstATop),
              image: const AssetImage(
                'assets/images/background1.jpg',
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
                      Text(
                        "Register",
                        style: GoogleFonts.hahmlet(
                          fontSize: 46.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'name cannot be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.account_circle_sharp),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone cannot be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            labelText: 'Phone',
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
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
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 150,
                        color: Colors.blueGrey[200],
                        child: Column(
                          children: [
                            Text(
                              'Are you Shark Member',
                              style: GoogleFonts.hahmlet(
                                  fontSize: 22, color: Colors.black),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            ListTile(
                              title: Text(
                                "Yes",
                                style: GoogleFonts.hahmlet(
                                    fontSize: 22, color: Colors.black),
                              ),
                              leading: Radio(
                                value: true,
                                groupValue: isShark,
                                onChanged: (value) {
                                  setState(() {
                                    isShark = true;
                                  });
                                },
                                activeColor: Colors.green,
                                toggleable: true,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "No",
                                style: GoogleFonts.hahmlet(
                                    fontSize: 22, color: Colors.black),
                              ),
                              leading: Radio(
                                value: false,
                                groupValue: isShark,
                                onChanged: (value) {
                                  setState(() {
                                    isShark = false;
                                  });
                                },
                                activeColor: Colors.green,
                                toggleable: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: idController,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
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
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.blue,
                        child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AuthenticationCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  isShark: isShark,
                                  password: passwordController.text);

                              // Navigator.push(context, MaterialPageRoute(
                              //     builder: (context) =>  Home_Screen()));
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      duration: const Duration(seconds: 2),
                                      child: Home_Screen()));
                            }
                          },
                          child: Text(
                            "Submit".toUpperCase(),
                            style: GoogleFonts.hahmlet(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Already Have An Account,",
                              style: GoogleFonts.hahmlet(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Screen()));
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      duration: const Duration(seconds: 1),
                                      child: Login_Screen()));
                            },
                            child: const Text(
                              "Login",
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
