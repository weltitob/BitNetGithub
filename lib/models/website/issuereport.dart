// This class defines an issue report that contains user email and issue description
class IssueReport {
  String useremail;
  String issue;

  // Constructor that initializes user email and issue description
  IssueReport({
    required this.useremail,
    required this.issue,
  });

  // Factory method to create an IssueReport instance from a JSON map
  factory IssueReport.fromJson(Map<String, dynamic> json) {
    return IssueReport(
      useremail: json['useremail'].toString(),
      issue: json['issue'].toString(),
    );
  }

  // Method to convert an IssueReport instance to a map
  Map<String, dynamic> toMap() {
    return {
      'useremail': useremail,
      'issue': issue,
    };
  }

  // Method to create a new IssueReport instance from the existing instance with updated values
  IssueReport copyWith({
    String? useremail,
    String? issue,
  }) {
    return IssueReport(
      useremail: useremail ?? this.useremail,
      issue: issue ?? this.issue,
    );
  }
}
