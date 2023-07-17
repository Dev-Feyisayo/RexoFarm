import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexofarm/widgets/input_field.dart';
import 'package:rexofarm/validators.dart';
import 'package:rexofarm/widgets/main_page_button.dart';
import '../inputs/phoneinput.dart';
import '../view_models/auth_view_model.dart';

class CreateAccountFirstPage extends StatefulWidget {
  final Function() onNextPressed;

  const CreateAccountFirstPage({
    Key? key,
    required this.onNextPressed,
  }) : super(key: key);

  @override
  State<CreateAccountFirstPage> createState() => _CreateAccountFirstPageState();
}

class _CreateAccountFirstPageState extends State<CreateAccountFirstPage> {
  final TextEditingController _phoneNumberController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(
          labelText: 'First Name',
          validator: Validators.validateFirstName,
          onSaved: (text) {
            Provider.of<AuthViewModel>(
              context,
              listen: false,
            ).firstName = text ?? "";
          },
          hintText: 'John',
        ),
        const SizedBox(height: 29),
        InputField(
          labelText: 'Last Name',
          validator: Validators.validateLastName,
          onSaved: (text) {
            Provider.of<AuthViewModel>(
              context,
              listen: false,
            ).lastName = text ?? "";
          },
          hintText: 'Doe',
        ),
        const SizedBox(height: 29),
        PhoneInput(
          controller: _phoneNumberController,
          onPhoneNumberChanged: (text) {
            Provider.of<AuthViewModel>(
              context,
              listen: false,
            ).phoneNumber = text ?? "";
          },
        ),
        const SizedBox(height: 64),
        MainPageButton(
          label: "Next",
          onPressed: widget.onNextPressed,
        )
      ],
    );
  }
}
