import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        height: MediaQuery.of(context).size.longestSide,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _nameCtrl,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _usernameCtrl,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _passwordCtrl,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
