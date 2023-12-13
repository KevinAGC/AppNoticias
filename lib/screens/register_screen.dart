import 'package:flutter/material.dart';
import 'package:appnoticias/screens/login_screen.dart';
import 'package:provider/provider.dart';
import '../providers/login_form_provider.dart';
import '../services/services.dart';
import '../ui/ui.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text(
            "Registro",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ChangeNotifierProvider(
            create: (_) => LoginFormProvider(), child: _LoginForm()));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Center(
          child: ListView(
        //shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 100),
        children: [
          Column(
            children: [
              Image.asset(
                "assets/images/user.png",
                height: 100,
              ),
              Title(
                color: Colors.green,
                child: const Text("Bienvenido",
                    style: TextStyle(color: Colors.black54, fontSize: 50)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    hintText: 'correo@gmail.com',
                    labelText: 'Email',
                    //prefixIcon: Icons.alternate_email_rounded,
                  ),
                  onChanged: (value) => loginForm.email = value,
                  validator: (value) {
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp = new RegExp(pattern);

                    return regExp.hasMatch(value ?? '')
                        ? null
                        : 'El valor ingresado no luce como un correo';
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  autocorrect: false,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    errorMaxLines: 2,
                    hintText: '*****',
                    labelText: 'Password',
                  ),
                  onChanged: (value) => loginForm.password = value,
                  validator: (value) {
                    String pattern =
                        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{6,}$';
                    RegExp regExp = new RegExp(pattern);

                    if (value != null && value.length < 6) {
                      return 'La contraseña debe de ser de 6 caracteres';
                    }
                    if (regExp.hasMatch(value!)) {
                      return null;
                    }
                    return 'La contraseña debe contener mayúsculas, minúsculas, números y caracteres especiales';
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: LinearBorder(),
                    ),
                    onPressed: loginForm.isLoading
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            final authService = Provider.of<AuthService>(
                                context,
                                listen: false);

                            if (!loginForm.isValidForm()) return;

                            loginForm.isLoading = true;

                            // TODO: validar si el login es correcto
                            final String? errorMessage =
                                await authService.createUser(
                                    loginForm.email, loginForm.password);
                            print(errorMessage);

                            if (errorMessage == null) {
                              Navigator.pushReplacementNamed(context, 'home');
                            } else {
                              // TODO: mostrar error en pantalla
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: const Text('Error'),
                                        content: Text(errorMessage),
                                      ));
                              loginForm.isLoading = false;
                            }
                          },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                        child: Text(
                          loginForm.isLoading ? 'Espere' : 'Registrar',
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => LoginScreen(),
                          transitionDuration: Duration(seconds: 0)));
                },
                child: Text('Iniciar sesión'),
              )
            ],
          ),
        ],
      )),
    );
  }
}
