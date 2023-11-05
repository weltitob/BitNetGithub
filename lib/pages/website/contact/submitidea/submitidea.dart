import 'package:bitnet/components/dialogsandsheets/bottom_sheets/add_content_bottom_sheet/add_content.dart';
import 'package:bitnet/models/user/ideasubmitters.dart';
import 'package:bitnet/pages/chat_list/chat/chat.dart';
import 'package:bitnet/pages/website/contact/submitidea/submitidea_view.dart';
import 'package:flutter/material.dart';

class SubmitIdea extends StatefulWidget {
  const SubmitIdea({super.key});

  @override
  State<SubmitIdea> createState() => SubmitIdeaController();
}

class SubmitIdeaController extends State<SubmitIdea> {

  onAddPopupMenuButtonSelected(String value) {
    switch (value) {
      case '1':
        print("1");
        break;
      case '2':
        print("2");
        break;
      case '3':
        print("3");
        break;
      case '4':
        print("4");
        break;
      case '5':
        print("5");
        break;
    }
  }

  onAddButtonTap(){
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (builder) => AddContentWidget(controller: this));
    print("Add Button tapped");
  }

  changeSelected(int value) {
    setState(() {
      currentSelected = value;
    });
  }

  final List<IdeaSubmitterTop3Model> submitters = [
    IdeaSubmitterTop3Model(
        placement: 1,
        name: "Tobias Welti",
        idea:
            "I'm literally the only person who has submitted an idea so far.",
        id: ''),
    IdeaSubmitterTop3Model(
        placement: 2,
        name: "Welti 2",
        idea:
            "I'm literally the only psubmitted an idea so far.",
        id: ''),
    IdeaSubmitterTop3Model(
        placement: 3,
        name: "Welti 3",
        idea:
            "y the only person who has submitted an idea so far.",
        id: ''),
  ];

  int currentSelected = 0;

  @override
  Widget build(BuildContext context) {
    return SubmitIdeaView(controller: this);
  }
}
