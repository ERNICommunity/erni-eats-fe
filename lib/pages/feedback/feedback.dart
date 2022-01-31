import 'package:erni_eats_fe/data/data.dart';
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
          TextFormField(
            controller: name,
            decoration: const InputDecoration(
              hintText: 'Meno',
            ),
            keyboardType: TextInputType.name,
          ),
          TextFormField(
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
          ),
          TextFormField(
            controller: feedback,
            decoration: const InputDecoration(
              hintText: 'Spätná väzba *',
            ),
            keyboardType: TextInputType.text,
            minLines: 5,
            maxLines: 100,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Povinná položka formuláru';
              }
              return null;
            },
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    createEmail();
                  }
                },
                child: const Text('Odoslať'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  createEmail() {
    final String emailSubject = 'Eat11 Feedback';
    String nameText = name.text == '' ? '' : 'Name: ${name.text}%0D';
    String emailText = email.text == '' ? '' : 'Email: ${email.text}%0D';
    String optionalLine = (name.text == '' && email.text == '') ? '' : '%0D';
    String feedbackText = 'Feedback:%0D${feedback.text}';

    var formattedBody = '$nameText'
        '$emailText'
        '$optionalLine'
        '$feedbackText';

    clearTheForm();

    launchURL('mailto:$FeedbackEmail?'
        'subject=$emailSubject&'
        'body=$formattedBody');
  }

  clearTheForm() {
    name.text = '';
    email.text = '';
    feedback.text = '';
  }
}
