import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:form_validation/main.dart';
import 'package:form_validation/repositories/user_repository.dart';
import 'package:form_validation/screens/registration_screen.dart';
import 'package:form_validation/widgets/input_field_widget.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: widget,
          ),
        ));
  }

  testWidgets('textfield', (WidgetTester tester) async {
    TextFormFieldWidget customTextField = const TextFormFieldWidget(
      hintText: "hintText",
    );

    await tester.pumpWidget(buildTestableWidget(customTextField));
    Finder finder = find.byType(TextFormField);
    expect(finder, findsOneWidget);
  });
}
