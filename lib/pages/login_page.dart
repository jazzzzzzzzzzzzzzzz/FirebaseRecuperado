import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSigIn = GoogleSignIn(scopes: ["email"]);
  MyServiceFirestore userService = MyServiceFirestore(collection: "users");

  //Login normal
  _login() async {
    try {
      if (formKey.currentState!.validate()) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);

        if (userCredential.user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        }
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        showSnackBarError(context, "El correo electrónico es inválido");
      } else if (error.code == "user-not-found") {
        showSnackBarError(context, "El usuario no está registrado");
      } else if (error.code == "wrong-password") {
        showSnackBarError(context, "Contraseña incorrecta");
      }
    }
  }

  //Login con google
  _loginWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSigIn.signIn();

    if (googleSignInAccount == null) {
      return;
    }

    GoogleSignInAuthentication _googleSignInAuth =
        await googleSignInAccount.authentication;

    OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleSignInAuth.idToken,
      accessToken: _googleSignInAuth.accessToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user != null) {
      UserModel userModel = UserModel(
        fullName: userCredential.user!.displayName!,
        email: userCredential.user!.email!,
      );
      userService.cherckUser(userCredential.user!.email!).then((value) {
        if (!value) {
          userService.addUser(userModel).then((value) {
            if (value.isNotEmpty) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            }
          });
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        }
      });
    }
  }

  //login con facebook
  _loginWithFacebook() async {
    LoginResult _loginResult = await FacebookAuth.instance.login();
    if (_loginResult == LoginStatus.success) {
      Map<String, dynamic> userData = await FacebookAuth.instance.getUserData();

      AccessToken accessToken = _loginResult.accessToken!;

      OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        UserModel userModel = UserModel(
          fullName: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
        );

        userService.cherckUser(userCredential.user!.email!).then((value) {
          if (!value) {
            userService.addUser(userModel).then((value) {
              if (value.isNotEmpty) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false);
              }
            });
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  divider30(),
                  SvgPicture.asset(
                    "assets/images/login.svg",
                    height: 180.0,
                  ),
                  divider20(),
                  Text(
                    "Iniciar Sesión",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: kBrandPrymaryColor),
                  ),
                  TextFieldNormalWidget(
                      hintText: "Correo",
                      icon: Icons.email,
                      controller: _emailController),
                  divider20(),
                  TextFieldPasswordWidget(controller: _passwordController),
                  divider10(),
                  ButtonCustomWidget(
                    text: "Iniciar Sesión",
                    color: kBrandPrymaryColor,
                    icon: "check",
                    onPressed: () {
                      _login();
                    },
                  ),
                  divider6(),
                  Text("O ingresa con tus redes sociales"),
                  divider6(),
                  ButtonCustomWidget(
                    text: "Iniciar sesión con Google",
                    color: Color(0xfff84b2a),
                    icon: "google",
                    onPressed: () {
                      _loginWithGoogle();
                    },
                  ),
                  divider6(),
                  ButtonCustomWidget(
                    text: "Iniciar sesión con Facebook",
                    color: Color(0xfff507CC0),
                    icon: "facebook",
                    onPressed: () {
                      _loginWithFacebook();
                    },
                  ),
                  divider10(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("¿No tienes cuenta?"),
                      divider10w(),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text(
                            "Registrate",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: kBrandPrymaryColor),
                          )),
                    ],
                  )
                ],
              ),
            ),
            padding: EdgeInsets.all(16.0)),
      ),
    );
  }
}
