import 'package:emergency_allergy_app/themes/choice_prompt_theme.dart';
import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class SingleChoicePrompt<T> extends StatefulWidget {
  final List<T> choices;
  final String title;
  final Function(dynamic) onSelected;

  const SingleChoicePrompt({
    required this.title,
    required this.choices,
    required this.onSelected,
    super.key,
  });

  @override
  State<SingleChoicePrompt> createState() => _SingleChoicePromptState();
}

class _SingleChoicePromptState<T> extends State<SingleChoicePrompt<T>> {
  late List<ChoiceData<T>> choiceData;

  ChoiceData<T>? selected;

  void setSingleSelected(ChoiceData<T>? value) {
    setState(() => selected = value);
    widget.onSelected(value!.value);
  }

  @override
  void initState() {
    choiceData = widget.choices.asChoiceData(
        value: (i, e) => widget.choices[i],
        title: (i, e) =>
            (e as Enum).name[0].toUpperCase() + (e as Enum).name.substring(1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChoicePromptTheme(
      child: PromptedChoice<ChoiceData<T>>.single(
        title: widget.title,
        confirmation: false,
        value: selected,
        onChanged: setSingleSelected,
        itemCount: choiceData.length,
        itemBuilder: (state, i) {
          return RadioListTile(
            value: choiceData[i],
            groupValue: state.single,
            onChanged: (value) {
              state.select(value!); // might be an issue
            },
            title: ChoiceText(
              choiceData[i].title,
              highlight: state.search?.value,
            ),
          );
        },
        // modalFooterBuilder: ChoiceModalFooter.create(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   padding: const EdgeInsets.symmetric(
        //     horizontal: 12.0,
        //     vertical: 7.0,
        //   ),
        //   children: [
        //     (state) {
        //       return TextButton(
        //         onPressed: () => state.closeModal(confirmed: false),
        //         child: const Text('Cancel'),
        //       );
        //     },
        //     (state) {
        //       return TextButton(
        //         onPressed: () => state.closeModal(confirmed: true),
        //         child: const Text('Submit'),
        //       );
        //     },
        //   ],
        // ),
        promptDelegate: ChoicePrompt.delegatePopupDialog(
          // maxHeightFactor: .3,
          // use with footer
          // maxHeightFactor: .11 + .08 * choiceData.length,
          // use without footer
          maxHeightFactor: .05 + .075 * choiceData.length,
          constraints: const BoxConstraints(maxWidth: 300),
        ),
        anchorBuilder: ChoiceAnchor.create(inline: true),
      ),
    );
  }
}
