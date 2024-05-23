import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mall_app/cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class Winner extends StatefulWidget {
  const Winner({super.key});

  @override
  State<Winner> createState() => _WinnerState();
}

class _WinnerState extends State<Winner> {
  void openWhatsApp(String phoneNumber) async {
    String url = 'https://wa.me/$phoneNumber';

    if (await launchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print('Could not launch WhatsApp');
    }
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    bool wl500 = width > 500;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20,),

              SizedBox(height: 20,),
              Lottie.asset(
                'lib/assets/images/congrats.json',
                width: 300,
              ),
              Text(
                  'The winner is',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  )
              ),
              SizedBox(height: 20,),
              Text(
                '${AppCubit.get(context).winner}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )
              ),
              SizedBox(height: 20,),
              Container(
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[100]!,
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ]
                ),
                child: TextButton(
                    onPressed: () {
                      openWhatsApp(AppCubit.get(context).winner!);
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Contact him via whatsapp',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: wl500?18:16,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          SizedBox(width: 10,),
                          FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.blue,
                            size: wl500?20:18,
                          ),
                        ],
                      ),
                    )
                ),
              ) ,
              SizedBox(height: 10,),
              Text(
                'or',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )
              ),
              SizedBox(height: 10,),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent)
                ),
                  onPressed: () {
                    setState(() {
                      AppCubit.get(context).GetRandom();
                    });
                  },
                  child: Text(
                    'Choose another one',
                    style: TextStyle(
                      color: Colors.blue,
                        fontSize: wl500?18:15,
                      fontWeight: FontWeight.w500
                    )
                  )
              )
            ]
          ),
        ),
      ),
    );
  }
}
