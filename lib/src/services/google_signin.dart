// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:Photoconnect/views/news_feed/controller/news_feed_controller.dart';
// import 'package:Photoconnect/views/notification/controller/notification_controller.dart';
// import 'package:Photoconnect/views/user_registration/login_module/controller/auth_controller.dart';
//
// import '../common_widgets/common_snack_bar.dart';
//
// final FirebaseAuth auth = FirebaseAuth.instance;
//
// // Future<void> googleSignup(BuildContext context) async {
// //   NotificationController.to.googleLoading(true);
// //   final GoogleSignIn googleSignIn = GoogleSignIn();
// //   try {
// //     final GoogleSignInAccount? googleSignInAccount =
// //         await googleSignIn.signIn();
// //
// //     if (googleSignInAccount != null) {
// //       print('googleaccount $googleSignInAccount');
// //       final GoogleSignInAuthentication googleSignInAuthentication =
// //           await googleSignInAccount.authentication;
// //       print(
// //           'googleSignInAuthentication.idToken ${googleSignInAuthentication.idToken}');
// //       print(
// //           'googleSignInAuthentication.idToken ${googleSignInAuthentication.accessToken}');
// //       final AuthCredential authCredential = GoogleAuthProvider.credential(
// //           idToken: googleSignInAuthentication.idToken,
// //           accessToken: googleSignInAuthentication.accessToken);
// //       print('idtoken $authCredential');
// //       // Getting users credential
// //       UserCredential result = await auth.signInWithCredential(authCredential);
// //       User? user = result.user;
// //       if (result != null) {
// //         NotificationController.to.googleSignin(
// //           id: user!.uid,
// //           username: user!.displayName ?? '',
// //           email: user!.email,
// //         );
// //         //
// //         // Navigator.pushReplacement(
// //         //     context, MaterialPageRoute(builder: (context) => HomePage()));
// //       } else {
// //         NotificationController.to.googleLoading(false);
// //       } // if result not null we simply call the MaterialpageRoute,
// //       // for go to the HomePage screen
// //     } else {
// //       NotificationController.to.googleLoading(false);
// //     }
// //   } catch (e) {
// //     NotificationController.to.googleLoading(false);
// //     CommonToast.show(msg: "Unable to login");
// //     await googleSignIn.signOut();
// //     print("sign in error $e");
// //     return null;
// //   }
// // }
// Future<dynamic> googleSignup(context) async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   print('check datas$googleUser');
//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth =
//   await googleUser?.authentication;
//
//   // Create a new credential
//   try {
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//
//     print('check datas$googleUser');
//
//     // Once signed in, return the UserCredential
//     final data = await FirebaseAuth.instance.signInWithCredential(credential);
//
//     await GoogleSignIn().signOut();
//
//     if (data.user != null) {
//       final user = data.user;
//       NotificationController.to.googleSignin(
//         id: user!.uid,
//         username: user!.displayName ?? '',
//         email: user!.email,
//       );
//       // return RegisterModel(
//       //     mail: user!.email ?? '',
//       //     mobile: user.phoneNumber ?? '',
//       //     name: user.displayName ?? '',
//       //     type: '2',
//       //     password: user.email!.substring(0, user.email!.length - 10));
//     } else {
//       return null;
//     }
//   } catch (e) {
//     //UiUtils.ShowToastPrimary(e.toString());
//     return null;
//   }
// }
//
//
// Future<dynamic> signInWithGoogle(context) async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   // Obtain the auth details from the request
//   try {
//     final GoogleSignInAuthentication? googleAuth =
//         await googleUser?.authentication;
//     // Create a new credential
//     try {
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//       // Once signed in, return the UserCredential
//       final data = await FirebaseAuth.instance.signInWithCredential(credential);
//              print('firebase user ${data.user}');
//       await GoogleSignIn().signOut();
//
//       if (data.user != null) {
//         final user = data.user;
//         print('firebase  $user');
//          NotificationController.to.googleSignin(
//            id: user!.uid,
//            username: user!.displayName ?? '',
//            email: user!.email,
//          );
//       } else {
//         return null;
//       }
//     } catch (e) {
//       CommonToast.show(msg: "Unable to login");
//       print('sign in error $e');
//       //UiUtils.ShowToastPrimary(e.toString());
//       return null;
//     }
//   } catch (e) {
//     await GoogleSignIn().signOut();
//     CommonToast.show(msg: "Unable to login");
//     print('sign in error $e');
//     //UiUtils.ShowToastPrimary(e.toString());
//     return null;
//   }
// }
