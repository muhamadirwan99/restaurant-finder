// ignore_for_file: use_build_context_synchronously

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../view/login_view.dart';

class LoginController extends State<LoginView> {
  static late LoginController instance;
  late LoginView view;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final nameC = TextEditingController();
  final emailLoginC = TextEditingController();
  final passwordLoginC = TextEditingController();
  final emailSignupC = TextEditingController();
  final passwordSignupC = TextEditingController();

  bool obscure = true;
  bool isContentLogin = true;

  void clearTextFields() {
    nameC.clear();
    emailLoginC.clear();
    passwordLoginC.clear();
    emailSignupC.clear();
    passwordSignupC.clear();
  }

  void login() async {
    if (emailLoginC.text.isEmpty || passwordLoginC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showCircleDialogLoading();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailLoginC.text,
        password: passwordLoginC.text,
      );

      newRouter.go(RouterUtils.beranda);
    } on FirebaseAuthException catch (e) {
      Get.back();

      if (e.code == 'invalid-credential') {
        showCustomSnackBar(
          context: context,
          message: "Login error: email or password is incorrect",
          backgroundColor: Theme.of(context).colorScheme.error,
        );
        return;
      }

      showCustomSnackBar(
        context: context,
        message: "Login error: ${e.message}",
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (e) {
      Get.back();

      showCustomSnackBar(
        context: context,
        message: "Unexpected error: $e",
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    }
  }

  void addUser() async {
    if (nameC.text.isEmpty || emailSignupC.text.isEmpty || passwordSignupC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showCircleDialogLoading();

    CollectionReference users = _firestore.collection('users');

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailSignupC.text,
        password: passwordSignupC.text,
      );

      final uid = userCredential.user!.uid;

      await users.doc(uid).set({
        'name': nameC.text,
        'email': emailSignupC.text,
      });

      showCustomSnackBar(
        context: context,
        message: "User successfully added!",
      );

      Get.back();

      clearTextFields();
      isContentLogin = true;
      update();
    } on FirebaseAuthException catch (e) {
      Get.back();

      showCustomSnackBar(
        context: context,
        message: "Auth error: ${e.message}",
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (e) {
      Get.back();

      showCustomSnackBar(
        context: context,
        message: "Unexpected error: $e",
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    }
  }

  void loginWithGoogle() async {
    try {
      showCircleDialogLoading();

      // Sign out from Google first to force account picker
      await _googleSignIn.signOut();

      // Trigger the authentication flow with account picker
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        Get.back();
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Check if user already exists in Firestore
        CollectionReference users = _firestore.collection('users');
        DocumentSnapshot userDoc = await users.doc(user.uid).get();

        if (!userDoc.exists) {
          // Add user data to Firestore if it doesn't exist
          await users.doc(user.uid).set({
            'name': user.displayName ?? 'Google User',
            'email': user.email ?? '',
            'photoURL': user.photoURL ?? '',
            'provider': 'google',
            'createdAt': FieldValue.serverTimestamp(),
          });
        }

        Get.back(); // Close loading dialog

        showCustomSnackBar(
          context: context,
          message: "Welcome ${user.displayName ?? 'User'}!",
        );

        // Navigate to home page
        newRouter.go(RouterUtils.beranda);
      }
    } catch (e) {
      Get.back(); // Close loading dialog

      showCustomSnackBar(
        context: context,
        message: "Google Sign-In error: $e",
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    }
  }

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
