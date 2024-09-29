import 'package:emergency_allergy_app/themes/choice_prompt_theme.dart';
import 'package:emergency_allergy_app/utils/create_scrollable_wrapped.dart';
import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class MultiChoicePrompt<T> extends StatefulWidget {
  final List<T> choices;
  final List<String> choiceTitles;
  final String title;
  final List<T>? initialValues;
  final Function(List<ChoiceData<dynamic>>) onSelected;

  const MultiChoicePrompt(
      {required this.title,
      required this.choices,
      required this.choiceTitles,
      required this.onSelected,
      this.initialValues,
      super.key});

  @override
  State<MultiChoicePrompt> createState() => _MultiChoicePromptState();
}

class _MultiChoicePromptState<T> extends State<MultiChoicePrompt<T>> {
  List<ChoiceData<T>> choiceData = [];

  List<ChoiceData<T>> selected = [];

  void setSelected(List<ChoiceData<T>> value) {
    setState(() => selected = value);
    widget.onSelected(value);
  }

  void setInitialChoices() {
    List<ChoiceData<T>> initialChoices = choiceData.where((e) {
      return widget.initialValues!.contains(e.value);
    }).toList();

    setSelected(initialChoices);
  }

  @override
  void initState() {
    choiceData = widget.choices.asChoiceData<T>(
        value: (i, e) => widget.choices[i],
        title: (i, e) => widget.choiceTitles[i]);

    if (widget.initialValues != null) {
      setInitialChoices();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiChoicePromptTheme(
      child: PromptedChoice<ChoiceData<T>>.multiple(
        title: widget.title,
        clearable: true,
        confirmation: true,
        searchable: true,
        value: selected,
        onChanged: (e) {
          setSelected(e);
        },
        itemCount: choiceData.length,
        itemSkip: (state, i) =>
            !ChoiceSearch.match(choiceData[i].title, state.search?.value),
        itemBuilder: (state, i) {
          return ChoiceChip(
            selected: state.selected(choiceData[i]),
            onSelected: state.onSelected(choiceData[i]),
            label: ChoiceText(
              choiceData[i].title,
              highlight: state.search?.value,
            ),
          );
        },
        listBuilder: createScrollableWrapped(
          padding: const EdgeInsets.all(20),
          spacing: 10,
          runSpacing: 10,
        ),
        modalHeaderBuilder: ChoiceModal.createHeader(
          automaticallyImplyLeading: false,
          actionsBuilder: [
            ChoiceModal.createConfirmButton(),
            ChoiceModal.createSpacer(width: 10),
          ],
        ),
        promptDelegate: ChoicePrompt.delegatePopupDialog(
          constraints: const BoxConstraints(maxWidth: 400),
          maxHeightFactor: .5,
        ),
        anchorBuilder: ChoiceAnchor.create(valueTruncate: 1),
      ),
    );
  }
  // child: PromptedChoice<ChoiceData<T>>.multiple(
  //   title: widget.title,
  //   confirmation: true,
  //   value: selected,
  //   onChanged: setSingleSelected,
  //   itemCount: choiceData.length,
  //   itemBuilder: (state, i) {
  //     return RadioListTile(
  //       value: choiceData[i],
  //       groupValue: state.single,
  //       onChanged: (value) {
  //         state.select(value!); // might be an issue
  //       },
  //       title: ChoiceText(
  //         choiceData[i].title,
  //         highlight: state.search?.value,
  //       ),
  //     );
  //   },
  //   modalFooterBuilder: ChoiceModalFooter.create(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     padding: const EdgeInsets.symmetric(
  //       horizontal: 12.0,
  //       vertical: 7.0,
  //     ),
  //     children: [
  //       (state) {
  //         return TextButton(
  //           onPressed: () => state.closeModal(confirmed: false),
  //           child: const Text('Cancel'),
  //         );
  //       },
  //       (state) {
  //         return TextButton(
  //           onPressed: () => state.closeModal(confirmed: true),
  //           child: const Text('Submit'),
  //         );
  //       },
  //     ],
  //   ),
  //   promptDelegate: ChoicePrompt.delegatePopupDialog(
  //     maxHeightFactor: .3,
  //     // use with footer
  //     // maxHeightFactor: .11 + .08 * choiceData.length,
  //     // use without footer
  //     // maxHeightFactor: .05 + .075 * choiceData.length,
  //     constraints: const BoxConstraints(maxWidth: 300),
  //   ),
  //   anchorBuilder: ChoiceAnchor.create(inline: true),
  // ),
//     );
//   }
// }
}
