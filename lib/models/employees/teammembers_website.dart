class TeamMember {
  final String avatarUrl;
  final String name;
  final String position;
  final String quote;
  final bool isYou;

  TeamMember({this.avatarUrl = "", required this.name, required this.position, required this.quote, this.isYou = false});
}
