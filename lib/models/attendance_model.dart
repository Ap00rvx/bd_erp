class Attendance {
  final int attendanceID;
  final int attendeeUserID;
  final String absentDate;
  final String? subjectName;
  final int subjectId;
  final bool isAbsent;
  final int markedBy;

  Attendance({
    required this.attendanceID,
    required this.attendeeUserID,
    required this.absentDate,
    this.subjectName,
    required this.subjectId,
    required this.isAbsent,
    required this.markedBy,
  });

  // Factory constructor to create an instance from a JSON map
  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      attendanceID: json['attendanceID'] ?? 0,
      attendeeUserID: json['attendeeUserID'] ?? 0,
      absentDate: json['absentDate'] ?? '',
      subjectName: json['subjectName'],
      subjectId: json['subjectId'] ?? 0,
      isAbsent: json['isAbsent'] ?? false,
      markedBy: json['markedBy'] ?? 0,
    );
  }

  // Method to convert an instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'attendanceID': attendanceID,
      'attendeeUserID': attendeeUserID,
      'absentDate': absentDate,
      'subjectName': subjectName,
      'subjectId': subjectId,
      'isAbsent': isAbsent,
      'markedBy': markedBy,
    };
  }

  @override
  String toString() {
    return 'Attendance(attendanceID: $attendanceID, attendeeUserID: $attendeeUserID, absentDate: $absentDate, subjectName: $subjectName, subjectId: $subjectId, isAbsent: $isAbsent, markedBy: $markedBy)';
  }
}
