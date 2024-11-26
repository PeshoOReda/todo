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

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController fullNameController;

  late TextEditingController userNameController;

  late TextEditingController emailController;

  late TextEditingController passwordController;

  late TextEditingController rePasswordController;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
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
                Text(
                  AppLocalizations.of(context)!.fullName,
                  style: LightAppStyle.title,
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomTextField(
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.plzFullName;
                    }
                    return null;
                  },
                  controller: fullNameController,
                  hintText: ConstantManager.getFullName(context) ?? '',
                  keyboardType: TextInputType.name,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  AppLocalizations.of(context)!.userName,
                  style: LightAppStyle.title,
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomTextField(
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.plzUserName;
                    }
                    return null;
                  },
                  controller: userNameController,
                  hintText: ConstantManager.getUserName(context) ?? '',
                  keyboardType: TextInputType.name,
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
                Text(
                  AppLocalizations.of(context)!.rePassword,
                  style: LightAppStyle.title,
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomTextField(
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.plzRePassword;
                    }
                    if (input != passwordController.text) {
                      return AppLocalizations.of(context)!.dontMatch;
                    }
                    return null;
                  },
                  controller: rePasswordController,
                  hintText: ConstantManager.getPasswordConfirmation(context) ?? '',
                  keyboardType: TextInputType.visiblePassword,
                  isSecureText: true,
                ),
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
                      register();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signup,
                      style: LightAppStyle.buttonText,
                    )),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.haveAccount,
                      style: const TextStyle(fontSize: 20),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesManager.login);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
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

  void register() async {
    if (formKey.currentState?.validate() == false) return;

    try {
      // show Loading
      MyDialog.showLoading(context,
          loadingMessage: AppLocalizations.of(context)!.processing, isDismissible: false);
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      addUserToFireStore(credential.user!.uid);
      //hide loading
      if (mounted) {
        MyDialog.hide(context);
      }
      // show success message
      if (mounted) {
        MyDialog.showMessage(context,
            body: AppLocalizations.of(context)!.userRegisteredSuccessfully,
            posActionTitle: AppLocalizations.of(context)!.ok, posAction: () {
          Navigator.pushReplacementNamed(context, RoutesManager.login);
        });
      }
    } on FirebaseAuthException catch (authError) {
      if (mounted) {
        MyDialog.hide(context);
      }
      late String message;
      if (authError.code == 'weak-password') {
        if (mounted) {
          message = ConstantManager.weakPasswordMessage(context) ?? '';
        }
      } else if (authError.code == "email_in_use") {
        if (mounted) {
          message = ConstantManager.emailInUseMessage(context) ?? '';
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

  void addUserToFireStore(String uid) async {
    UserDM userDM = UserDM(
      id: uid,
      fullName: fullNameController.text,
      userName: userNameController.text,
      email: emailController.text,
    );
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference userDocument = usersCollection.doc(uid);
    await userDocument.set(userDM.toFireStore());
  }
}
