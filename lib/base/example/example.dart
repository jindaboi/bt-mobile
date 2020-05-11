/// This is an example page.
///
/// Creating this widget is as simple as this:
/// @override
/// Widget build(BuildContext context) {
///   return Example(ExamplePresenter());
/// }
///
/// BUT WAIT, notice how there's two classes here: Example and _ExampleState.
/// Example is a StatefulWidget, as opposed to a StatelessWidget, which means it
/// can change States. States are a complex topic that we don't need to get into
/// right now. Just know that we can architect our UI with the build method.
///
/// Notice how _ExampleState extends the View class. Also notice how there is
/// barely anything in that class other than the build method. That's how things
/// should be. Do a final notice of the build method:
/// - When showing exampleNumber, we get the dynamic data from the Model.
/// - When the button is tapped, we pass a reference to the method that is
///   implemented in the Presenter.
///
/// After this makes some sense, check out example_model.dart.

import 'package:bt_mobile/base/example/example_model.dart';
import 'package:bt_mobile/base/example/example_presenter.dart';
import 'package:bt_mobile/base/view.dart';
import 'package:flutter/material.dart';

class Example extends StatefulWidget {
  const Example(this.presenter, {Key key}) : super(key: key);

  final ExamplePresenter presenter;

  @override
  State<StatefulWidget> createState() => _ExampleState();
}

class _ExampleState extends View<Example, ExampleModel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('This is the example number: ${model.exampleNumber}'),
        MaterialButton(
          /// We can call the onPressed method either as an anonymous/arrow
          /// function, or pass a direct reference to the desired method. Using
          /// an arrow function makes the most sense when we need to pass a
          /// parameter to the method.
          ///
          /// onPressed: () => widget.presenter.onButtonPressed()
          ///               or
          onPressed: widget.presenter.onButtonPressed,
        )
      ],
    );
  }
}
