import 'package:flutter/material.dart';
import 'package:form_validation_provider/providers/form_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Validation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Consumer<FormProvider>(
            builder: (context, formProvider, child) {
              return Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      errorText: formProvider.nameError.isNotEmpty
                          ? formProvider.nameError
                          : null,
                    ),
                    onChanged: (value) => formProvider.updateName(value),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: formProvider.emailError.isNotEmpty
                          ? formProvider.emailError
                          : null,
                    ),
                    onChanged: (value) => formProvider.updateEmail(value),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: formProvider.passwordError.isNotEmpty
                          ? formProvider.passwordError
                          : null,
                    ),
                    obscureText: true,
                    onChanged: (value) => formProvider.updatePassword(value),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (formProvider.state == FormStateEnum.submitting)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: () {
                        formProvider.validateForm();
                        if (formProvider.state == FormStateEnum.valid) {
                          formProvider.submitForm();
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (formProvider.state == FormStateEnum.submitted)
                    ElevatedButton(
                      onPressed: () => formProvider.resetForm(),
                      child: const Text('Reset Form'),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
