
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class about_us_page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff7c94b6),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2),
                BlendMode.dstATop
            ),
            image: const AssetImage(
              'assets/images/Shark1.jpg',
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 800,
            child: Column(
              children: [
                AutoSizeText('Shark Gym', style: GoogleFonts.hahmlet(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),),
                const SizedBox(height: 10.0,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AutoSizeText('Categories :', style: GoogleFonts.hahmlet(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    Expanded(
                      child: AutoSizeText('', maxLines: 2, style: GoogleFonts.hahmlet(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AutoSizeText('Address :', style: GoogleFonts.hahmlet(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    Expanded(
                      child: AutoSizeText('', maxLines: 2, style: GoogleFonts.hahmlet(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AutoSizeText('Supplement Store :',maxLines: 1, style: GoogleFonts.hahmlet(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    Expanded(
                      child: AutoSizeText('', maxLines: 2, style: GoogleFonts.hahmlet(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AutoSizeText('Food Store :',maxLines: 1, style: GoogleFonts.hahmlet(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    Expanded(
                      child: AutoSizeText('', maxLines: 2, style: GoogleFonts.hahmlet(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
