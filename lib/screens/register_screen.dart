import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:nanny/screens/orders_screen.dart';
import 'package:nanny/viewmodel/register_view_model.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'register';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();

    var vm = context.read<IRegisterViewModel>();
    vm.addListener(
      () {
        if (vm.state == LoginState.success) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: 'Ви успішно авторизувалися!',
            onConfirmBtnTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, OrdersScreen.id, (route) => false);
            },
          );
        }
        if (vm.state == LoginState.error) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: vm.errorMessage,
            onConfirmBtnTap: () {
              // Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(
                  context, OrdersScreen.id, (route) => false);
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<IRegisterViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.isSignInFlow ? 'Вхід' : 'Реєстрація'),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (viewModel.isLoading) const CircularProgressIndicator(),
            viewModel.isSignInFlow
                ? SignInWidget(viewModel: viewModel)
                : RegisterWidget(viewModel: viewModel),
          ],
        ),
      ),
    );
  }
}

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final IRegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/images/nanny.png',
            height: 200,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Реєстрація нового користувача',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Введіть свій e-mail і придумайте надійний пароль, що складатеметься із шести або більше символів:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          LoginContainer(
            actionButtonTitle: 'Зареєструватися',
            viewModel: viewModel,
            action: (email, pass) {
              viewModel.signUp(email: email, password: pass);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                'Уже зареєстровані?',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextButton(
              onPressed: () {
                viewModel.signInSelected();
              },
              child: const Text('Увійти'),
            ),
          ),
        ],
      ),
    );
  }
}

class SignInWidget extends StatelessWidget {
  const SignInWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final IRegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/images/nanny.png',
            height: 200,
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Якщо ви вже зареєстровані, введіть свій e-mail і пароль:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          LoginContainer(
            actionButtonTitle: 'Увійти',
            viewModel: viewModel,
            action: (email, pass) {
              viewModel.signIn(email: email, password: pass);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                'Якщо у вас ще немає профілю, ви можете зареєструватися. Це займе не більше кількох секунд.',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextButton(
              onPressed: () {
                viewModel.registerSelected();
              },
              child: const Text('Реєстрація'),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginContainer extends StatefulWidget {
  final String actionButtonTitle;
  final IRegisterViewModel viewModel;
  final Function(String, String) action;

  const LoginContainer({
    Key? key,
    required this.viewModel,
    required this.action,
    required this.actionButtonTitle,
  }) : super(key: key);

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  final FocusNode _fnEmail = FocusNode();
  final FocusNode _fnPass = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Ваш E-mail',
            ),
            textInputAction: TextInputAction.next,
            focusNode: _fnEmail,
            onSubmitted: (_) {
              _fnEmail.unfocus();
              FocusScope.of(context).requestFocus(_fnPass);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Пароль',
            ),
            textInputAction: TextInputAction.done,
            focusNode: _fnPass,
            obscureText: true,
            onSubmitted: (_) {
              _fnPass.unfocus();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
            ),
            onPressed: () async {
              widget.action(
                _emailController.text,
                _passwordController.text,
              );
            },
            child: Text(
              widget.actionButtonTitle,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
