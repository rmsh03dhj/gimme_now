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
import 'package:gimmenow/features/utils/gimme_now_scaffold_no_drawer.dart';
import 'package:gimmenow/features/utils/validators.dart';

class ConfirmCodeEntryPageWrapper extends StatelessWidget {
  final String email;

  const ConfirmCodeEntryPageWrapper(this.email);

  @override
  Widget build(BuildContext context) {
    return GimmeNowScaffoldNoDrawer(
      body: ConfirmCodeEntryPage(email),
    );
  }
}

class ConfirmCodeEntryPage extends StatefulWidget {
  final String email;

  const ConfirmCodeEntryPage(this.email);

  @override
  _ConfirmCodeEntryPageState createState() => _ConfirmCodeEntryPageState();
}

class _ConfirmCodeEntryPageState extends State<ConfirmCodeEntryPage> {
  TextEditingController _confirmationCodeController = TextEditingController();
  FocusNode _confirmationCodeFocusNode = FocusNode();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final _navigateService = sl<NavigationService>();

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
        if (state is SignUpSuccessState) {
          _navigateService.navigateTo(GimmeNowRoutes.dashboard);
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
                                child: FormBuilderTextField(
                                  attribute: "confirm_code",
                                  controller: _confirmationCodeController,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  validators: [
                                    Validators.required(),
//                                    Validators.emailOrPhoneNumberValidatorUpdated()
                                  ],
                                  keyboardType: TextInputType.emailAddress,
                                  focusNode: _confirmationCodeFocusNode,
                                  onChanged: (val) {
                                    setState(() {
                                      _formKey.currentState.fields['confirm_code'].currentState
                                          .validate();
                                    });
                                  },
                                ),
                              ),
                              Container(
                                height: 16,
                              ),
                              BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
                                return FlatButton(
                                  child: Text("Confirm Code"),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      BlocProvider.of<SignUpBloc>(context).add(
                                        ConfirmCodeEntered(
                                          _confirmationCodeController.text,
                                          widget.email,
                                        ),
                                      );
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
                                    onTap: _showSignInPage,
                                    child: Text(
                                      "alreadyHaveAnAccount",
                                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ]);
        }),
      ),
    );
  }

  void dispose() {
    _confirmationCodeController.dispose();
    _confirmationCodeFocusNode.dispose();
    super.dispose();
  }

  void _showSignInPage() {
    Navigator.of(context).pushNamed(GimmeNowRoutes.signUp);
  }
}
