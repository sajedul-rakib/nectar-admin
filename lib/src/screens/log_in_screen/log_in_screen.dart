import 'package:admin_panel/src/bloc/log_in_bloc/login_bloc_bloc.dart';
import 'package:admin_panel/src/routes/route.dart';
import 'package:admin_panel/src/utils/app_colors/colors.dart';
import 'package:admin_panel/src/utils/assets/assets_manager.dart';
import 'package:admin_panel/src/widgets/app_form_field.dart';
import 'package:admin_panel/src/widgets/circular_progress_indicator.dart';
import 'package:admin_panel/src/widgets/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailETController = TextEditingController();

  final TextEditingController _passwordETController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  IconData suffixIcon = CupertinoIcons.eye_slash;
  bool isSecure = true;

  void changeIcon() {
    setState(() {
      isSecure = !isSecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 300,
          height: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryBackgroundColor.withOpacity(.3)),
          child: BlocConsumer<LoginBlocBloc, LoginBlocState>(
            builder: (context, state) {
              if (state is LogInProcess) {
                return const CustomProgressIndicator();
              }
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Image.asset(
                        AssetsManager.logoImage,
                        color: AppColors.primaryBackgroundColor,
                        width: 150,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppFormField(
                      labelText: "Email",
                      hintText: "Enter your email",
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: CupertinoIcons.mail,
                      textEditingController: _emailETController,
                      validator: (String? value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return "Enter your email";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppFormField(
                      labelText: "Password",
                      hintText: "Enter your password",
                      prefixIcon: CupertinoIcons.textformat_abc_dottedunderline,
                      suffixIcon: InkWell(
                        onTap: changeIcon,
                        child: Icon(isSecure
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye),
                      ),
                      isSecure: isSecure,
                      textEditingController: _passwordETController,
                      validator: (String? value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return "Enter your password";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: 200,
                        height: 40,
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.primaryBackgroundColor)),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? true) {
                                context.read<LoginBlocBloc>().add(LogInRequired(
                                    email: _emailETController.text.trim(),
                                    password: _passwordETController.text));
                              }
                            },
                            child: const Text("Log In")))
                  ],
                ),
              );
            },
            listener: (context, state) {
              if (state is LogInSuccess) {
                const CustomSnackBar(
                    contentType: ContentType.success,
                    label: "Log in Success",
                    message: "You are log in suceessfully");
                context.goNamed(RouteName.HOMESCREEN);
              } else if (state is LogInFailure) {
                CustomSnackBar(
                  contentType: ContentType.failure,
                  label: "Log in Failed",
                  message: "${state.message}",
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
