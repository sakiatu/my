import 'package:flutter/material.dart';
import 'package:my/my.dart';

import 'example_util.dart';

void main() {
  runApp(const MyExampleApp());
}

class MyExampleApp extends StatelessWidget {
  const MyExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Package Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('My Package Example')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyText(
                'MyText Example',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const GapY(16),
              MyContainer(
                padding: const EdgeInsets.all(12),
                color: Colors.blue.shade50,
                child: MyText('This is inside MyContainer'),
              ),
              const GapY(16),
              MyButton.text(
                label: 'MyButton',
                icon: Icons.thumb_up,
                onPressed: () {},
              ).pb(),
              MyButton.filled(
                label: 'MyButton',
                icon: Icons.thumb_up,
                onPressed: () {},
              ).pb(),
              MyButton.elevated(
                label: 'MyButton',
                icon: Icons.thumb_up,
                onPressed: () {},
              ).pb(),
              MyButton.tonal(
                label: 'MyButton',
                icon: Icons.thumb_up,
                onPressed: () {},
              ).pb(),
              MyButton.outlined(
                label: 'MyButton',
                icon: Icons.thumb_up,
                onPressed: () {},
              ).pb(),
              MyButton.textDanger(
                label: 'MyButton',
                icon: Icons.thumb_up,
                onPressed: () {},
              ).pb(),
              MyButton.tonalDanger(
                label: 'MyButton',
                icon: Icons.thumb_up,
                onPressed: () {},
              ).pb(),
              MyButton.outlinedDanger(
                label: 'MyButton',
                icon: Icons.thumb_up,
                onPressed: () {},
              ).pb(),
              const GapY(16),
              MyTextField(label: 'MyTextField', hint: 'Enter something'),
              const GapY(16),
              MyTextFormField(
                label: 'MyTextFormField',
                hint: 'Enter text',
                validator:
                    const MyFormFieldValidator().required().getValidator(),
              ),
              const GapY(16),
              Row(
                children: const [
                  Text('GapX before'),
                  GapX(32),
                  Text('GapX after'),
                ],
              ),
              const GapY(16),
              Row(children: [MyLoader()]),
              const GapY(16),
              MyLoadingEffect(
                child: Column(
                  children: [
                    MySkeleton(width: context.screenWidth, height: 60),
                    GapY(),
                    MySkeleton(width: context.screenWidth / 2, height: 60),
                  ],
                ),
              ),
              const GapY(16),
              MySkeleton(height: 32, width: 120),
              const GapY(16),
              const ExampleUtilWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
