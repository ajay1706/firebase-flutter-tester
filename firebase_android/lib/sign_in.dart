import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String name,email,imageUrl;

Future<String> signInWithGoogle() async{
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  final GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: gSA.idToken, accessToken: gSA.accessToken);

  final FirebaseUser user = (await _auth.signInWithCredential(credential)) as FirebaseUser;
  assert(user.email!=null);
  assert(user.displayName!=null);
  assert(user.photoUrl!=null);
  name=user.displayName;
  email=user.email;
  imageUrl=user.photoUrl;


if(name.contains("")) {
  name = name.substring(0, name.indexOf(""));

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user';
}
}
void signOutGoogle() async{
  await googleSignIn.signOut();

  print(("User signed out"));
}

