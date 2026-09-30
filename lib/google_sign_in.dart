import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential?> signInWithGoogle() async {
  try {
    // 1. Trigger the Google Authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // User canceled the sign-in
      return null;
    }

    // 2. Obtain auth details (access & id tokens)
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // 3. Create a credential for Firebase Authentication
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // 4. Sign in to Firebase with the credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    print("Google Sign-In Error: $e");
    rethrow;
  }
}
