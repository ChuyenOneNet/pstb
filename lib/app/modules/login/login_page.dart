import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/login/widgets/back_login_widget.dart';
import 'package:pstb/app/modules/login/widgets/form_input_widget.dart';
import 'login_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final LoginStore _loginStore = Modular.get<LoginStore>();
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _loginStore.changeBuildContext(context);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await _loginStore.getInformationNumber();
      _phoneController =
          TextEditingController(text: _loginStore.phoneNumberCache);
    });
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    Modular.dispose<LoginStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_loginStore.loadingLogin) return const SizedBox();
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Column(
                children: [
                  SafeArea(
                    child: Image.asset('assets/images/login_bg.jpg'),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        FormInputWidget(
                          passwordController: _passwordController,
                          phoneController: _phoneController,
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                  BackLoginWidget(),
                  const SizedBox(
                    height: 32.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
