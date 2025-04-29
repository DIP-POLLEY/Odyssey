

import 'package:farm_ai_agent/screens/introform.dart';
import 'package:farm_ai_agent/widgets/showErrorSnackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Otpscreen extends StatefulWidget {
  const Otpscreen({Key? key}) : super(key: key);
  static const String id = 'otpverify';

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {

  String otp="";
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/3,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(25.0),
                //   child: Center(
                //     child: TextField(
                //       keyboardType: TextInputType.phone,
                //       maxLength: 6,
                //       decoration: InputDecoration(
                //         labelText: 'OTP',
                //
                //         border: OutlineInputBorder(),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding:  EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width/6,
                    0,
                    MediaQuery.of(context).size.width/6,
                    0
                  ),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    onChanged: (value) {},
                    onCompleted: (value) {
                      setState(() {
                        otp = value.toString();
                      });
                      print("Entered OTP: $value");
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 40,
                      fieldWidth: 30,
                      activeColor: Colors.blue,
                      selectedColor: Colors.orange,
                      inactiveColor: Colors.grey,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width/3,
                      0,
                      MediaQuery.of(context).size.width/3,
                      0

                  ),
                  child: ElevatedButton(onPressed: (){
                    if(otp == '123456')
                      {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Introform()),
                        );
                      }
                    else
                      {
                        showErrorMessage(context, 'Invalid OTP');
                      }

                  },
                      child: Text('Verify OTP')

                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
