

import 'package:farm_ai_agent/screens/otpscreen.dart';
import 'package:farm_ai_agent/widgets/showErrorSnackbar.dart';
import 'package:farm_ai_agent/utilities/storeLocalDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  static const String id = 'loginscreen';
  const Loginscreen({Key? key}) : super(key: key);



  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {

  late TextEditingController _phonenum;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phonenum = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phonenum.dispose();
  }

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
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextField(
                              controller: _phonenum,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                prefixText: '+91-',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        Padding(
                          padding:  EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width/3,
                            0,
                            MediaQuery.of(context).size.width/3,
                            0

                          ),
                          child: ElevatedButton(
                              onPressed: (){
                                String number = _phonenum.text;
                                if(number.length<10)
                                  {
                                    showErrorMessage(context, 'Invalid phone number');
                                  }
                                else
                                  {
                                    Storedata('phone', number);
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Otpscreen()),
                                    );
                                  }


                              },
                              child: Text('Get OTP')
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
