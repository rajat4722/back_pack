// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

import 'package:back_pack/constants/font_weight.dart';
import 'package:back_pack/presentation/screens/navigation_screen/navigation_screen.dart';
import 'package:back_pack/presentation/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController signinController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool value = false;

  bool passwordVisible = false;

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

//   String hashPassword(String password) {
//   var bytes = utf8.encode(password); // Convert the password to bytes
//   var digest = sha256.convert(bytes); // Generate the SHA256 hash
//   return digest.toString();
// }

  Future<void> loginUser(String email, String password) async {
    final String apiUrl = "https://apiv2stg.promilo.com/user/oauth/token";

    // Convert password to SHA256
    String hashedPassword = sha256
        .convert(utf8.encode(password))
        .toString(); // Implement SHA256 conversion here;

    // Prepare the payload
    var data = {
      "username": email,
      "password": hashedPassword,
      "grant_type": "password",
    };

    // Prepare headers
    var headers = {
      "Authorization": "Basic UHJvbWlsbzpxNCE1NkBaeSN4MiRHQg==",
    };

    // Send POST request
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: data,
    );

    if (response.statusCode == 200) {
      // Successful login, handle the response accordingly
      print("Login Successful");
      print(response.body);
      setState(() {
        isLoggedIn = true;
      });
    } else {
      // Error handling for unsuccessful login
      print("Invalid ID or Password");
      print(response.body);
      setState(() {
        isLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'promilo',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Column(
                    children: [
                      commonText("Hi, Welcome Back!", const Color(0xff002a53),
                          16, bold),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText("Please Sign in to continue",
                        const Color(0xff002a53), 16, normal),
                  ],
                ),
                const SizedBox(height: 5),
                CustomFormField(
                  // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  inputType: TextInputType.text,

                  hintText: 'Enter Email or Mob No.',
                  controller: signinController,
                  // decoration: const InputDecoration(),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    commonText("Sign In With OTP", Colors.blue, 16, bold),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    commonText("Password", const Color(0xff002a53), 16, normal),
                  ],
                ),
                const SizedBox(height: 5),
                CustomFormField(
                  // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  inputType: TextInputType.text,
                  obscureText: passwordVisible,
                  hintText: 'Enter Password',
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: 'Enter Password',
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                      alignLabelWithHint: false,
                      filled: true,
                      fillColor: Colors.white),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                Row(
                  children: <Widget>[
                    /** Checkbox Widget **/
                    Checkbox(
                      value: value,
                      onChanged: (value) {
                        setState(() {
                          this.value = value!;
                        });
                      },
                    ), //Checkbox
                    const Text(
                      'Remember Me',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 102, 96, 96)),
                    ),
                    const Spacer(),
                    commonText("Forget Password", Colors.blue, 16, bold), //Text
                  ],

                  //<Widget>[]
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff002a53),
                    ),
                    onPressed: () async {
                      if (signinController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        // Call the loginUser function with entered email and password
                        await loginUser(
                            signinController.text, passwordController.text);

                        // Check if the login was successful before navigating to the next screen
                        if (isLoggedIn) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NavigationScreen(),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login successful!'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          // Show an error message to the user for unsuccessful login
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid ID or Password'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else {
                        // Show a message indicating that both email and password are required
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter email and password'),
                            duration: Duration(seconds: 2),
                            backgroundColor:
                                Colors.red, // Adjust color as needed
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(children: <Widget>[
                  Expanded(child: Divider()),
                  SizedBox(width: 5),
                  Text(
                    "or",
                    style: TextStyle(fontWeight: bold, fontSize: 15),
                  ),
                  SizedBox(width: 5),
                  Expanded(child: Divider()),
                ]),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svgs/google.svg",

                      // "$svgAssetsBasePath/google.svg",
                      height: 35,
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      "assets/svgs/linkedin_icon.svg",

                      // "$svgAssetsBasePath/google.svg",
                      height: 35,
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      "assets/svgs/facebook.svg",

                      // "$svgAssetsBasePath/google.svg",
                      height: 35,
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      "assets/svgs/instagram.svg",

                      // "$svgAssetsBasePath/google.svg",
                      height: 35,
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      "assets/svgs/whatsapp.svg",

                      // "$svgAssetsBasePath/google.svg",
                      height: 35,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    commonText("Business User?",
                        const Color.fromARGB(255, 85, 84, 84), 16, normal),
                    const Spacer(),
                    commonText("Don't have an account",
                        const Color.fromARGB(255, 85, 84, 84), 16, normal),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    commonText("Login Here", Colors.blue, 16, bold),
                    const Spacer(),
                    commonText("Sign Up", Colors.blue, 16, bold),
                  ],
                ),
                const SizedBox(height: 50),
                Center(
                  child: Column(
                    children: [
                      commonText("By continuing, you agree to", Colors.black,
                          16, normal),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    commonText("Promilo's ", Colors.black, 16, normal),
                    commonText("Terms of Use & Privacy Policy.", Colors.black,
                        16, bold),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text commonText(
    text,
    color,
    double size,
    weight,
  ) =>
      Text(
        text,
        style: GoogleFonts.poppins(
            textStyle:
                TextStyle(color: color, fontSize: size, fontWeight: weight)),
      );
}
