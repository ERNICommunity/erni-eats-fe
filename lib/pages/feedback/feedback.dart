import 'package:erni_eats_fe/data/environment-variables.dart';
import 'package:erni_eats_fe/utils/launch-url.dart';
import 'package:flutter/material.dart';

class FeedbackRoute extends StatelessWidget {
  final String _title = 'Spätná väzba';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FeedbackForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({Key? key}) : super(key: key);

  @override
  FeedbackFormState createState() {
    return FeedbackFormState();
  }
}

class FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final email = TextEditingController();
  final feedback = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          NameFormField(name: name),
          EmailFormField(email: email),
          FeedbackFormField(feedback: feedback),
          Container(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _createEmail();
                }
              },
              child: const Text('Odoslať'),
            ),
            padding: EdgeInsets.symmetric(vertical: 8.0),
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
    );
  }

  _createEmail() {
    final String emailSubject = 'Eat11 Feedback';
    String nameText = name.text == '' ? '' : 'Name: ${name.text}%0D';
    String emailText = email.text == '' ? '' : 'Email: ${email.text}%0D';
    String optionalLine = (name.text == '' && email.text == '') ? '' : '%0D';
    String feedbackText = 'Feedback:%0D${feedback.text}';

    var formattedBody = '$nameText'
        '$emailText'
        '$optionalLine'
        '$feedbackText';

    _clearTheFormFields();
    launchURL('mailto:${EnvironmentVariables.FeedbackEmail}?'
        'subject=$emailSubject&'
        'body=$formattedBody');
  }

  _clearTheFormFields() {
    name.clear();
    email.clear();
    feedback.clear();
  }
}

class FeedbackFormField extends StatelessWidget {
  const FeedbackFormField({
    Key? key,
    required this.feedback,
  }) : super(key: key);

  final TextEditingController feedback;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: feedback,
      decoration: const InputDecoration(
        hintText: 'Spätná väzba *',
      ),
      keyboardType: TextInputType.text,
      minLines: 5,
      maxLines: 100,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Povinná položka formuláru';
        }
        return null;
      },
    );
  }
}

class EmailFormField extends StatelessWidget {
  const EmailFormField({
    Key? key,
    required this.email,
  }) : super(key: key);

  final TextEditingController email;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: email,
      decoration: const InputDecoration(
        hintText: 'Email',
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp emailRegExp = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
        if (value == null || value == '' || emailRegExp.hasMatch(value)) {
          return null;
        }
        return 'Nesprávny formát email adresy';
      },
    );
  }
}

class NameFormField extends StatelessWidget {
  const NameFormField({
    Key? key,
    required this.name,
  }) : super(key: key);

  final TextEditingController name;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: name,
      decoration: const InputDecoration(
        hintText: 'Meno',
      ),
      keyboardType: TextInputType.name,
    );
  }
}
