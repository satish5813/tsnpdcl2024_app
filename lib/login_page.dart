import 'package:flutter/material.dart';
import 'package:TGNPDCL/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io'; // To handle network-related exceptions

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Check if google-services.json is available
    bool googleServicesJsonExists = await _checkGoogleServicesJson();
    if (!googleServicesJsonExists) {
      print("Error: google-services.json file is missing.");
      return;
    }

    // Initialize Firebase
    await Firebase.initializeApp();
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  runApp(MyApp());
}

Future<bool> _checkGoogleServicesJson() async {
  try {
    // Assuming the file is in the standard location
    final file = File('android/app/google-services.json');
    return file.existsSync();
  } catch (e) {
    print("Error checking google-services.json file: $e");
    return false;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TSNPDCL Login',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void printLongString(String text) {
    final pattern = RegExp('.{0,25000}'); // Limits each chunk to 800 characters
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
  Future<User?> _signInWithGoogle() async {
    try {
      // Ensure Firebase is initialized
      if (Firebase.apps.isEmpty) {
        print('Firebase is not initialized, initializing now...');
        await Firebase.initializeApp();
        print('Firebase initialized during sign-in process');
      } else {
        print('Firebase is already initialized');
      }

      // Check for internet connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty || result[0].rawAddress.isEmpty) {
        print('No internet connection.');
        return null;
      } else {
        print('Internet connection is available.');
      }

      // Directly attempt to sign in with Google, prompting the user
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        print('Google Sign-In was cancelled by the user.');
        return null;
      }

      print('Google Sign-In successful: $googleUser');

      // Obtain the auth details from the request
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        print('Sign-In successful:');
        print('User Display Name: ${user.displayName}');
        print('User Email: ${user.email}');
        print('User Metadata: ${user.metadata}');
        print('User Photo URL: ${user.photoURL}');
        print('Token ID: ${user.getIdTokenResult()}');
        user.getIdToken(true).then((token){

          // printLongString('user token: ${token}');
           // print('user token length: ${token?.length}<--->');
           print('user token -1: ${token?.substring(0,500)}<--->');
           print('user token -2: ${token?.substring(500,(token.length)??1-1)}<--->');

         });

        // Pass the user object and tokenId to the Home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(user: user),
          ),
        );
      } else {
        print('Sign-In failed: User is null');
      }
      return user;
    } on FirebaseAuthException catch (e) {
      // Specific FirebaseAuth related errors
      print('FirebaseAuthException occurred: ${e.message}');
      if (e.code == 'network-request-failed') {
        // Handle network errors specifically
        print('Network error occurred during Google Sign-In.');
      }
      return null;
    } on SocketException catch (_) {
      // Handle network-related exceptions
      print('Network error: Unable to connect. Please check your internet connection.');
      return null;
    } on HttpException catch (_) {
      // Handle general HTTP errors
      print('HTTP error occurred during Google Sign-In.');
      return null;
    } on FormatException catch (_) {
      // Handle format exceptions
      print('Data format error occurred during Google Sign-In.');
      return null;
    } catch (e) {
      // Catch any other generic errors
      print('Unexpected error during Google Sign-In: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assests/bg.png'), // Corrected path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 2),
            Image.asset(
              'assests/tsnpdcl_icon.png', // Corrected path
              width: 120,
              height: 120,
            ),
            SizedBox(height: 10),
            Text(
              'NORTHERN POWER DISTRIBUTION COMPANY OF TG LTD',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(flex: 3),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  print("Sign-In process started");
                  User? user = await _signInWithGoogle();
                  print("User data after sign-in: $user");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF57223),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text('Sign in with Gmail'),
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Version 1.0.0', // Example version
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
