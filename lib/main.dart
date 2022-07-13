import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // const HomePage({Key? key}) : super(key: key);
  TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
  TextStyle linkStyle = TextStyle(color: Colors.blue);

  bool value = true;
  bool _checkboxListTile = false;
  String istapped = '';
  late String _name;
  late String _email;
  late String _password;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void _submitCommand() {
    //get state of our Form
    final form = formKey.currentState;

    //`validate()` validates every FormField that is a descendant of this Form,
    // and returns true if there are no errors.
    if (form!.validate()) {
      //`save()` Saves every FormField that is a descendant of this Form.
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _loginCommand();
    }
  }

  void _loginCommand() {
    // Show login details in snackbar
    final snackbar = SnackBar(
      content: Text('Name: $_name, Email: $_email, password: $_password'),
    );
    scaffoldKey.currentState?.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(14, 22, 30, 1.0),
        leading: Center(
          child: Text(
            "Back",
            style: TextStyle(
                fontSize: 14, color: Color.fromRGBO(0, 168, 255, 1.0)),
          ),
        ),
        title: Center(
          child: Image.asset('assets/images/amazon_logo.png', width: 100.0,
            height: 40.0,),
        ),
        // title: Image.asset('assets/images/amazon_logo.png', width: 100.0,
        //   height: 40.0,),
        actions: [
          IconButton(
            icon: const Icon(Icons.rotate_right_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          color: Color.fromRGBO(14, 22, 30, 1.0),
          child: Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Create Account",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            width: 20,
                          ),

                          TextFormField(
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),

                                  filled: true,
                                  fillColor: Color.fromRGBO(255, 255, 255, 1.0),
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(66, 81, 101, 1.0))),
                              validator: (val) => val!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z]+$').hasMatch(val)
                                  ? 'Enter Correct Name.'
                                  : null,
                              onSaved: (val) => _name = val!,
                            ),

                          SizedBox(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),

                                filled: true,
                                fillColor: Color.fromRGBO(255, 255, 255, 1.0),
                                hintText: "Your Email Address",
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(66, 81, 101, 1.0))),
                            validator: (val) => val!.isEmpty ||
                                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(val)
                                ? 'Enter Correct Email Address.'
                                : null,
                            onSaved: (val) => _email = val!,
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            obscureText: _checkboxListTile,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),

                              filled: true,
                              fillColor: Color.fromRGBO(255, 255, 255, 1.0),
                              hintText: "Create a password",
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(66, 81, 101, 1.0)),
                            ),
                            validator: (val) => val!.isEmpty ||
                                    !RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                        .hasMatch(val)
                                ? 'Password required: Alphabet, Number & 6 chars.'
                                : null,
                            onSaved: (val) => _password = val!,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.warning_amber,color: Colors.red),
                        SizedBox(width: 15),
                        Text(
                          "Passwords must be at least 6 characters",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                        checkColor: Colors.white,
                        title: Text(
                          'Show Password',
                          style: TextStyle(color: Colors.white),
                        ),
                        value: _checkboxListTile,
                        onChanged: (value) {
                          setState(() {
                            _togglePasswordView();
                          });
                        },
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(12, 121, 175, 1.0),
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 65, vertical: 15),
                      ),
                      onPressed: _submitCommand,
                      child: Text('Create your Amazon account'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'By creating an account, you agree to '),
                          TextSpan(
                              text: 'Prime Video Terms of Use',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Prime Video Terms of Use');
                                }),
                          TextSpan(
                              text:
                                  ' and license agreement with can be found on the Amazon website.'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Already have an Account?",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(255, 255, 255, 1.0)),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(66, 81, 101, 1.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 120, vertical: 15),
                      ),
                      onPressed: () {},
                      child: Text('Sign-In Now'),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      "@ 1996-2021, Amazon.com, Inc. or its affiliates",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(129, 151, 163, 1.0)),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _checkboxListTile = !_checkboxListTile;
    });
  }
}
