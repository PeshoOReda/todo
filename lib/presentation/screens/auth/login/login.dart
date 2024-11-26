import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constant_manager.dart';
import '../../../../core/utils/dialog/dialogs.dart';
import '../../../../core/utils/email_validation.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../database_manager/model/user_dm.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/custom_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  AssetsManager.route,
                  width: 237.w,
                  height: 71.h,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  AppLocalizations.of(context)!.emailAddress,
                  style: LightAppStyle.title,
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomTextField(
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.plzEmail;
                    }
                    if (!isValidEmail(input)) {
                      // email is not Valid
                      return AppLocalizations.of(context)!.badFormat;
                    }
                    return null;
                  },
                  controller: emailController,
                  hintText: ConstantManager.getEmail(context) ?? '',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  AppLocalizations.of(context)!.password,
                  style: LightAppStyle.title,
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomTextField(
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.plzPassword;
                    }
                    return null;
                  },
                  controller: passwordController,
                  hintText: ConstantManager.getPassword(context) ?? '',
                  keyboardType: TextInputType.visiblePassword,
                  isSecureText: true,
                ), // password

                SizedBox(
                  height: 12.h,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r)),
                      padding: REdgeInsets.symmetric(vertical: 11)),
                  onPressed: () {
                    login();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.signIn,
                    style: LightAppStyle.buttonText,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dontHaveAnAccount,
                      style: const TextStyle(fontSize: 20),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesManager.register);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.register,
                          style: const TextStyle(fontSize: 20),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == false) return;

    try {
      // show Loading
      MyDialog.showLoading(context,
          loadingMessage: AppLocalizations.of(context)!.processing,
          isDismissible: false);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      UserDM.currentUser = await readUserFromFireStore(credential.user!.uid);

      //hide loading
      if (mounted) {
        MyDialog.hide(context);
      }
      // show success message
      if (mounted) {
        MyDialog.showMessage(context,
            body: AppLocalizations.of(context)!.userLoggedInSuccessfully,
            posActionTitle: AppLocalizations.of(context)!.ok, posAction: () {
          Navigator.pushReplacementNamed(
            context,
            RoutesManager.home,
          );
        });
      }
    } on FirebaseAuthException catch (authError) {
      if (mounted) {
        MyDialog.hide(context);
      }
      late String message;
      if (authError.code == "invalid_credential") {
        if (mounted) {
          message = ConstantManager.wrongEmailOrPasswordMessage(context) ?? '';
        }
      }
      if (mounted) {
        MyDialog.showMessage(
          context,
          title: AppLocalizations.of(context)!.error,
          body: message,
          posActionTitle: AppLocalizations.of(context)!.ok,
        );
      }
    } catch (error) {
      if (mounted) {
        MyDialog.hide(context);
        MyDialog.showMessage(context,
            title: AppLocalizations.of(context)!.error,
            body: error.toString(),
            posActionTitle: AppLocalizations.of(context)!.tryAgain);
      }
    }
  }

  Future<UserDM> readUserFromFireStore(String uid) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference userDocument = usersCollection.doc(uid);
    DocumentSnapshot userDocumentSnapshot = await userDocument.get();
    Map<String, dynamic> json =
        userDocumentSnapshot.data() as Map<String, dynamic>;
    UserDM userDM = UserDM.fromFireStore(json);
    return userDM;
  }
}
