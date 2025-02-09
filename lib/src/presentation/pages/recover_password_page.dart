import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestionuh/src/presentation/blocs.dart';
import 'package:gestionuh/src/presentation/widgets.dart';
import 'package:gestionuh/src/utils/validators.dart';

class RecoverPasswordPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Recuperar Contraseña'),
          centerTitle: true,
        ),
        bottomSheet: const GestionUHBottomSheet(),
        body: BlocConsumer<RecoverPasswordBloc, RecoverPasswordState>(
          listener: (context, state) {
            if (state is RecoverPasswordError) {
              _showCenterFlash(
                context: context,
                message: state.error,
                borderColor: Colors.red,
              );
            }
          },
          builder: (context, state) {
            if (state is RecoverPasswordInitial) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: state is RecoverPasswordCILoading ? 1 : 0,
                      child: const LinearProgressIndicator(),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 30,
                        bottom: 9,
                        left: 18,
                        right: 18,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                            ),
                            child: GestionUhDefaultTextField(
                              labelText: '\t\tNúmero de Carnet de Identidad*',
                              controller: state.ci,
                              validator: identityNumberCIValidator,
                              autovalidateMode: AutovalidateMode.disabled,
                              keyboardType: TextInputType.text,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          GestionUhDefaultButton(
                            text: 'Continuar',
                            onPressed: () {
                              if (state is RecoverPasswordCILoading ||
                                  !_formKey.currentState!.validate()) {
                                return;
                              }
                              context
                                  .read<RecoverPasswordBloc>()
                                  .add(RecoverPasswordCISubmit(state: state));
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            if (state is RecoverPasswordQuestions) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Opacity(
                        opacity:
                            state is RecoverPasswordQuestionsLoading ? 1 : 0,
                        child: const LinearProgressIndicator(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 30,
                          bottom: 9,
                          left: 18,
                          right: 18,
                        ),
                        child: Column(
                          children: [
                            for (var i = 0; i < state.questions.length; ++i)
                              Column(
                                children: [
                                  Text(state.questions[i]),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: GestionUhDefaultTextField(
                                      controller: state.answers[i],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'La respuesta es necesaria.';
                                        }
                                        return null;
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.disabled,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: GestionUhDefaultTextField(
                                labelText: '\t\tContraseña*',
                                controller: state.password,
                                validator: safetyPasswordValidator,
                                autovalidateMode: AutovalidateMode.disabled,
                                keyboardType: TextInputType.visiblePassword,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: GestionUhDefaultTextField(
                                labelText: '\t\tRepetir Contraseña*',
                                validator: (value) {
                                  if (value != state.password.text) {
                                    return 'Las contraseñas deben coincidir';
                                  }
                                  return null;
                                },
                                autovalidateMode: AutovalidateMode.disabled,
                                keyboardType: TextInputType.visiblePassword,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            GestionUhDefaultButton(
                              text: 'Continuar',
                              onPressed: () {
                                if (state is RecoverPasswordCILoading ||
                                    !_formKey.currentState!.validate()) {
                                  return;
                                }
                                context.read<RecoverPasswordBloc>().add(
                                    RecoverPasswordFinalSubmit(state: state));
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            if (state is RecoverPasswordSuccess) {
              return Container(
                margin: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Se ha cambiado correctamente la contraseña '
                      'de la cuenta "${state.userId}".',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: 30),
                    GestionUhDefaultButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ));
  }

  void _showCenterFlash({
    required BuildContext context,
    required String message,
    FlashPosition position = FlashPosition.top,
    FlashStyle style = FlashStyle.floating,
    Alignment? alignment,
    Color? borderColor,
  }) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 5),
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: Colors.black87,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: borderColor ?? Colors.black,
          position: position,
          style: style,
          alignment: alignment,
          enableDrag: false,
          onTap: () => controller.dismiss(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white),
              child: Text(
                message,
              ),
            ),
          ),
        );
      },
    );
  }
}
