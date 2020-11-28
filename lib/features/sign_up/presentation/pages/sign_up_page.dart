import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gimmenow/core/config/gimme_now_routes.dart';
import 'package:gimmenow/core/navigation_service.dart';
import 'package:gimmenow/core/service_locator.dart';
import 'package:gimmenow/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:gimmenow/features/sign_up/presentation/bloc/sign_up_event.dart';
import 'package:gimmenow/features/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:gimmenow/features/utils/constants/strings.dart';
import 'package:gimmenow/features/utils/gimme_now_button.dart';
import 'package:gimmenow/features/utils/gimme_now_scaffold_no_drawer.dart';
import 'package:gimmenow/features/utils/gimme_now_text_form_field.dart';
import 'package:gimmenow/features/utils/validators.dart';

class SignUpPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GimmeNowScaffoldNoDrawer(
      body: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  SignUpPage();

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
  final _navigateService = sl<NavigationService>();
  bool _signIn = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailedState) {
          Scaffold.of(context)
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5),
              ),
            );
        }
        if (state is ConfirmSignUpStepState) {
          _navigateService.navigateToAndReplace(GimmeNowRoutes.code, arguments: state.email);
        }
      },
      child: SingleChildScrollView(
        child: BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: FormBuilder(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GimmeNowFormBuilderTextField(
                                attribute: email,
                                controller: _emailController,
                                enableSuggestions: false,
                                autoCorrect: false,
                                validators: [
                                  Validators.required(),
                                  Validators.emailOrPhoneNumberValidatorUpdated()
                                ],
                                label: email,
                                prefixIcon: Icon(Icons.person),
                                keyboardType: TextInputType.emailAddress,
                                focusNode: _emailFocusNode,
                                onChanged: (val) {
                                  setState(() {
                                    _formKey.currentState.fields[email].currentState.validate();
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GimmeNowFormBuilderTextField(
                                attribute: password,
                                decoration: InputDecoration(
                                  labelText: password,
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      borderSide: BorderSide(color: Colors.blue)),
                                  focusedErrorBorder:
                                      OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                  errorStyle: TextStyle(
                                    color: Colors.red,
                                  ),
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible ? Icons.visibility_off : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                controller: _passwordController,
                                obscureText: _passwordVisible,
                                validators: [Validators.required(), Validators.length()],
                                keyboardType: TextInputType.text,
                                focusNode: _passwordFocusNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).unfocus();
                                },
                                onChanged: (val) {
                                  setState(() {
                                    _formKey.currentState.fields[password].currentState.validate();
                                  });
                                },
                              ),
                            ),
                            !_signIn
                                ? Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: GimmeNowFormBuilderTextField(
                                      attribute: confirmPassword,
                                      decoration: InputDecoration(
                                        labelText: confirmPassword,
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.grey)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                            borderSide: BorderSide(color: Colors.blue)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red)),
                                        errorStyle: TextStyle(
                                          color: Colors.red,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _confirmPasswordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _confirmPasswordVisible = !_confirmPasswordVisible;
                                            });
                                          },
                                        ),
                                        prefixIcon: Icon(Icons.lock),
                                      ),
                                      controller: _confirmPasswordController,
                                      obscureText: _confirmPasswordVisible,
                                      validators: [Validators.required(), Validators.length()],
                                      keyboardType: TextInputType.text,
                                      focusNode: _confirmPasswordFocusNode,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                          _formKey.currentState.fields[confirmPassword].currentState
                                              .validate();
                                        });
                                      },
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 16,
              ),
              BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
                return GimmeNowButton(
                  text: _signIn?signIn: signUp,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      BlocProvider.of<SignUpBloc>(context)
                          .add(SignUpPressed(_emailController.text, _passwordController.text));
                    }
                  },
                );
              }),
              Container(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _signIn = !_signIn;
                      });
                    },
                    child: Text(
                      _signIn?signUp:signIn,
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              )
            ],
          );
        }),
      ),
    );
  }

  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _showSignInPage() {
    Navigator.of(context).pushNamed(GimmeNowRoutes.signUp);
  }
}
