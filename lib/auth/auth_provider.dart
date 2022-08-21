

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_provider_base.dart';

class _AndroidAuthProvider implements AuthProviderBase{
  @override
  Future<FirebaseApp> initialize() async{
      return await Firebase.initializeApp(
          name: 'chat app',
        options: const FirebaseOptions(
            apiKey: "AIzaSyDMJ2Av9FPf42VrT8Hrneh6TuxG-hY5TdU",
            authDomain: "chat-app-cf685.firebaseapp.com",
            projectId: "chat-app-cf685",
            storageBucket: "chat-app-cf685.appspot.com",
            messagingSenderId: "108367094195",
            appId: "1:108367094195:android:a7d01dbe63f8f9155e2bc6"
        )

      );


  }

  @override
  Future<UserCredential> siginInWithGoogle() async{
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

  }

class AuthProvider extends _AndroidAuthProvider{}