import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/employees/teammembers_website.dart';
import 'package:bitnet/pages/website/product/ourteam/ourteam_view.dart';
import 'package:flutter/material.dart';

class OurTeam extends StatefulWidget {
  const OurTeam({super.key});

  @override
  State<OurTeam> createState() => OurTeamController();
}

class OurTeamController extends State<OurTeam> {

  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (teamMembers.length > 1) {
        double cardWidth = 900; // Assume a fixed card width for simplicity
        double spacing = AppTheme.cardPadding * 4;
        double offset = cardWidth + spacing;
        scrollController.animateTo(offset, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  List<TeamMember> teamMembers = [
    TeamMember(name: "You", position: "Most important person", quote: '"This is my app!"', isYou: true),
    TeamMember(
        avatarUrl: "https://media.licdn.com/dms/image/D4E03AQFpSk_bJIDRlA/profile-displayphoto-shrink_200_200/0/1683049178655?e=1704326400&v=beta&t=0rO0ePfW8WJKMvKF9ls-NgrPjGnYSPQFCj19Y0xr5zg",
        name: "Tobias Welti",
        position: "CEO & BitNet Founder",
        quote: '"If you dont believe me or dont get it, I’ll take the time to convince you."',
    ),
    TeamMember(name: "Steph Curry", position: "Consultant", quote: '"I’m balling big time"'),
    TeamMember(name: "Steph Curry", position: "Consultant", quote: '"I’m balling big time"'),
    TeamMember(name: "Steph Curry", position: "Consultant", quote: '"I’m balling big time"'),
    TeamMember(name: "Steph Curry", position: "Consultant", quote: '"I’m balling big time"'),
    TeamMember(name: "Steph Curry", position: "Consultant", quote: '"I’m balling big time"'),

  ];



  @override
  Widget build(BuildContext context) {
 
    return OurTeamView(controller: this,);
  }
}
