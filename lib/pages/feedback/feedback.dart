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
              RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
              if (value != null && !emailRegExp.hasMatch(value)) {
                return 'Nesprávny formát email adresy';
              }
              return null;
            },
          ),
          TextFormField(
            controller: feedback,
            decoration: const InputDecoration(
              hintText: 'Spätná väzba *',
            ),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 100,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Povinná položka formuláru';
              }
              return null;
            },
          ),
          // todo attach file
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print(name.text);
                    print(email.text);
                    print(feedback.text);
                    name.text = '';
                    email.text = '';
                    feedback.text = '';
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Spätná väzba odoslaná!')),
                    );
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
}
