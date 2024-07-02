import 'package:flutter/material.dart';
import 'package:levaeu_mobile/api/api_client.dart';
import 'package:levaeu_mobile/controllers/auth_controller.dart';
import 'package:levaeu_mobile/controllers/race_controller.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/screens/navigation/home_state.dart';
import 'package:levaeu_mobile/screens/register/registration.dart';
import 'package:levaeu_mobile/utils/elevated_buttons.dart';
import 'package:levaeu_mobile/utils/text_fields_forms.dart';
import 'package:levaeu_mobile/utils/titles_screens.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKeyLogin = GlobalKey<FormState>();
  final AuthController _authController = AuthController(apiClient: ApiClient());
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final raceController = Provider.of<RaceController>(context, listen: false);
    raceController.clearDriverRaces(); // Chame o método que limpa a lista de driverRaces
  }

  Future<void> _login(BuildContext context) async {
    final user = Provider.of<UserData>(context, listen: false);
    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> loginData = {
      "email": emailController.text,
      "pass": passController.text,
    };

    try {
      print('Enviando dados de login para o backend: $loginData');
      final response = await _authController.loginUser(loginData);
      print('User logged in successfully: ${response.data}');
      user.updateFromJson(response.data);  // Atualiza os dados do usuário
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeState()),
      );
    } catch (e) {
      print('Failed to login: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to login')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color.fromRGBO(57, 96, 143, 1.0)),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                constraints: const BoxConstraints(maxWidth: 250),
                child: Image.asset('img/img_login.png'),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                constraints: const BoxConstraints(maxWidth: 350),
                child: TitlesScreens.buildMainTitle("Acesse sua conta"),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 300),
                child: TitlesScreens.buildSecondaryTitle(
                    'Entre com seu email ou telefone e aproveite suas viajens.'),
              ),
              Form(
                key: _formKeyLogin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: TextFieldsForms.buildTextFormField(
                        "Email ou telefone",
                        TextInputType.text,
                        emailController,
                        false,
                        ValidationType.emailOrPhone,
                        TextFieldsForms.saveFormFieldValue,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: TextFieldsForms.buildTextFormField(
                        "Senha",
                        TextInputType.visiblePassword,
                        passController,
                        true,
                        ValidationType.password,
                        TextFieldsForms.saveFormFieldValue,
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButtonsForms.buildElevatedButtonSubmitUserData(
                              const Color.fromRGBO(57, 96, 143, 1.0),
                              const Color.fromRGBO(255, 255, 255, 1),
                              const Color.fromRGBO(57, 96, 143, 1.0),
                              320,
                              50,
                              "Entrar",
                              context,
                              _formKeyLogin,
                              () => _login(context),
                            ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 300, minWidth: 250),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: ElevatedButtonsForms.buildElevatedButton(
                        Colors.white,
                        const Color.fromRGBO(57, 96, 143, 1.0),
                        const Color.fromRGBO(57, 96, 143, 1.0),
                        320,
                        50,
                        "Criar conta",
                        context,
                        const Registration(),
                        null,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
