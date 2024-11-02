import 'package:doktor_randevu/core/constant/assets.dart';
import 'package:doktor_randevu/core/network/error_response.dart';
import 'package:doktor_randevu/core/util/global_functions.dart';
import 'package:doktor_randevu/core/widgets/connectivity_aware_display.dart';
import 'package:doktor_randevu/core/widgets/custom_app_bar.dart';
import 'package:doktor_randevu/core/widgets/custom_elevated_button.dart';
import 'package:doktor_randevu/core/widgets/custom_text_field.dart';
import 'package:doktor_randevu/core/widgets/loading_widget.dart';
import 'package:doktor_randevu/core/widgets/no_connectivity_indicator.dart';
import 'package:doktor_randevu/core/widgets/page_status.dart';
import 'package:doktor_randevu/feature/login/data/models/login_form.dart';
import 'package:doktor_randevu/feature/login/presentation/bloc/bloc.dart';
import 'package:doktor_randevu/index_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/util/style.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Style _style = sl<Style>();
  final loginBloc = sl<LoginBloc>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldNavigateBack = false;
        return shouldNavigateBack;
      },
      child: ConnectivityAwareDisplay(
        whenNotConnected: NoConnectivityIndicator(),
        whenConnected: Scaffold(
          extendBody: true,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          appBar: CustomAppBar(
            title: Text(
              AppLocalizations.of(context)!.login,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'PublicSans',
                fontWeight: FontWeight.bold,
                color: _style.color(
                  color: 'secondary_grey_color',
                ),
              ),
            ),
            showBackButton: false,
          ),
          body: BlocProvider(
            create: (context) => loginBloc,
            child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              return BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state.pageStatus is DataSubmitted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const IndexScreen()),
                      (Route<dynamic> route) => false,
                    );
                  } else if (state.pageStatus is DataSubmitFailed) {
                    if (state.apiResponse!.data is ErrorResponse) {
                      if (state.apiResponse!.data.code == 400) {
                        GlobalFunctions.instance.showSnackBar(
                          context: context,
                          message: AppLocalizations.of(context)!.invalidLoginAndPassword,
                        );
                      } else if (state.apiResponse!.data.code == 403) {
                        GlobalFunctions.instance.showSnackBar(
                          context: context,
                          message: AppLocalizations.of(context)!.tooManyAttempts,
                        );
                      }
                    }
                  } else if (state.pageStatus is DataLoading) {
                    const Center(
                      child: LoadingWidget(),
                    );
                  }
                },
                child: SafeArea(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.email.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'PublicSans',
                              color: _style.color(color: 'secondary_text_color'),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: AppLocalizations.of(context)!.emailHint,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (String value) {},
                            validator: (value) {
                              final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.emailRequired;
                              } else if (!emailRegExp.hasMatch(value)) {
                                return AppLocalizations.of(context)!.emailValidation;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            AppLocalizations.of(context)!.password.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'PublicSans',
                              color: _style.color(color: 'secondary_text_color'),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            obscureText: state.isPasswordVisible,
                            hintText: AppLocalizations.of(context)!.passwordHint,
                            onFieldSubmitted: (String value) {},
                            suffixIcon: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                loginBloc.add(
                                  ChangePasswordVisibilityEvent(
                                    passwordVisibility: !state.isPasswordVisible,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: state.isPasswordVisible ? SvgPicture.asset(Assets.passwordInvisible) : SvgPicture.asset(Assets.passwordVisible),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.passwordRequired;
                              } else if (value.length < 6) {
                                return AppLocalizations.of(context)!.passwordCharacterLong;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomElevatedButton(
                            buttonText: AppLocalizations.of(context)!.login,
                            backgroundColor: _style.color(color: loginBloc.state.pageStatus is DataLoading?'deActive_indicator': 'main_color'),
                            loadingIcon: loginBloc.state.pageStatus is DataLoading?const LoadingWidget(size: 24,):null,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                loginBloc.add(
                                  GetTokenEvent(
                                    loginForm: LoginForm(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  ),
                                );
                              }
                            },
                            borderRadius: 8,
                            showDivider: false,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
