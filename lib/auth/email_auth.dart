import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_util.dart';

Future<User> signInWithEmail(
    BuildContext context, String email, String password) async {
  try {

    final signInFunc = () => FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.trim(), password: password);
    return signInOrCreateAccount(context, signInFunc);

  } on FirebaseAuthException catch (e, s) {
    _handleFirebaseLoginWithCredentialsException(e, s);
  } on Exception catch (e, s) {
    //Outro problema
  }

}

Future<User> createAccountWithEmail(
    BuildContext context, String email, String password) async {
  final createAccountFunc = () => FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email.trim(), password: password);
  return signInOrCreateAccount(context, createAccountFunc);
}

void _handleFirebaseLoginWithCredentialsException(
    FirebaseAuthException e, StackTrace s) {
  if (e.code == 'user-disabled') {
    //'O usuário informado está desabilitado.'
  } else if (e.code == 'user-not-found') {
    //'O usuário informado não está cadastrado.'
  } else if (e.code == 'invalid-email') {
    //'O domínio do e-mail informado é inválido.'
  } else if (e.code == 'wrong-password') {
    //'senha informada está incorreta.'
  } else {
    //Outro problema
  }
}