// To parse this JSON data, do
//
//     final studentAttenceAndDetails = studentAttenceAndDetailsFromJson(jsonString);

import 'dart:convert';


StudentAttenceAndDetails studentAttenceAndDetailsFromJson(String str) => StudentAttenceAndDetails.fromJson(json.decode(str));

String studentAttenceAndDetailsToJson(StudentAttenceAndDetails data) => json.encode(data.toJson());

class StudentAttenceAndDetails {
    StdSubAtdDetails stdSubAtdDetails;

    StudentAttenceAndDetails({
        required this.stdSubAtdDetails,
    });

    factory StudentAttenceAndDetails.fromJson(Map<String, dynamic> json) => StudentAttenceAndDetails(
        stdSubAtdDetails: StdSubAtdDetails.fromJson(json["stdSubAtdDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "stdSubAtdDetails": stdSubAtdDetails.toJson(),
    };
}

class StdSubAtdDetails {
    List<Subject> subjects;
    double overallPercentage;
    double overallPresent;
    double overallLecture;
    double overallRemidialClass;

    StdSubAtdDetails({
        required this.subjects,
        required this.overallPercentage,
        required this.overallPresent,
        required this.overallLecture,
        required this.overallRemidialClass,
    });

    factory StdSubAtdDetails.fromJson(Map<String, dynamic> json) => StdSubAtdDetails(
        subjects: List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x))),
        overallPercentage: json["overallPercentage"]?.toDouble(),
        overallPresent: json["overallPresent"],
        overallLecture: json["overallLecture"],
        overallRemidialClass: json["overallRemidialClass"],
    );

    Map<String, dynamic> toJson() => {
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
        "overallPercentage": overallPercentage,
        "overallPresent": overallPresent,
        "overallLecture": overallLecture,
        "overallRemidialClass": overallRemidialClass,
    };
}

class Subject {
    int groupId;
    String code;
    int batchId;
    dynamic groupName;
    dynamic subject;
    int subjectGroupType;
    int id;
    int subjectGroupId;
    int subSubjectId;
    String name;
    bool isAdditionalSubject;
    bool isTimeTableSubject;
    int totalExtraLeactureForSubject;
    int presentInExtraLeactureForSubject;
    int absentInExtraLeactureForSubject;
    int totalLeactures;
    int presentLeactures;
    int otherAttendance;
    int absentLeactures;
    int averagePresent;
    int averageTotal;
    double percentageAttendance;
    dynamic subjectMasterId;
    int actualSubjectId;
    int? subjectType;
    dynamic conversionMark;
    bool isSubjectSeleted;
    int sequence;
    int subjectMappingId;
    dynamic courseContent;
    bool isAttendaceFilled;
    bool isExamDateSheetCreated;
    bool isSubjectTeacher;
    dynamic coList;
    dynamic poList;
    dynamic copoList;

    Subject({
        required this.groupId,
        required this.code,
        required this.batchId,
        required this.groupName,
        required this.subject,
        required this.subjectGroupType,
        required this.id,
        required this.subjectGroupId,
        required this.subSubjectId,
        required this.name,
        required this.isAdditionalSubject,
        required this.isTimeTableSubject,
        required this.totalExtraLeactureForSubject,
        required this.presentInExtraLeactureForSubject,
        required this.absentInExtraLeactureForSubject,
        required this.totalLeactures,
        required this.presentLeactures,
        required this.otherAttendance,
        required this.absentLeactures,
        required this.averagePresent,
        required this.averageTotal,
        required this.percentageAttendance,
        required this.subjectMasterId,
        required this.actualSubjectId,
        required this.subjectType,
        required this.conversionMark,
        required this.isSubjectSeleted,
        required this.sequence,
        required this.subjectMappingId,
        required this.courseContent,
        required this.isAttendaceFilled,
        required this.isExamDateSheetCreated,
        required this.isSubjectTeacher,
        required this.coList,
        required this.poList,
        required this.copoList,
    });

    factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        groupId: json["groupId"],
        code: json["code"],
        batchId: json["batchId"],
        groupName: json["groupName"],
        subject: json["subject"],
        subjectGroupType: json["subjectGroupType"],
        id: json["id"],
        subjectGroupId: json["subjectGroupId"],
        subSubjectId: json["subSubjectId"],
        name: json["name"],
        isAdditionalSubject: json["isAdditionalSubject"],
        isTimeTableSubject: json["isTimeTableSubject"],
        totalExtraLeactureForSubject: json["totalExtraLeactureForSubject"],
        presentInExtraLeactureForSubject: json["presentInExtraLeactureForSubject"],
        absentInExtraLeactureForSubject: json["absentInExtraLeactureForSubject"],
        totalLeactures: json["totalLeactures"],
        presentLeactures: json["presentLeactures"],
        otherAttendance: json["otherAttendance"],
        absentLeactures: json["absentLeactures"],
        averagePresent: json["averagePresent"],
        averageTotal: json["averageTotal"],
        percentageAttendance: json["percentageAttendance"]?.toDouble(),
        subjectMasterId: json["subjectMasterId"],
        actualSubjectId: json["actualSubjectId"],
        subjectType: json["subjectType"],
        conversionMark: json["conversionMark"],
        isSubjectSeleted: json["isSubjectSeleted"],
        sequence: json["sequence"],
        subjectMappingId: json["subjectMappingId"],
        courseContent: json["courseContent"],
        isAttendaceFilled: json["isAttendaceFilled"],
        isExamDateSheetCreated: json["isExamDateSheetCreated"],
        isSubjectTeacher: json["isSubjectTeacher"],
        coList: json["coList"],
        poList: json["poList"],
        copoList: json["copoList"],
    );

    Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "code": code,
        "batchId": batchId,
        "groupName": groupName,
        "subject": subject,
        "subjectGroupType": subjectGroupType,
        "id": id,
        "subjectGroupId": subjectGroupId,
        "subSubjectId": subSubjectId,
        "name": name,
        "isAdditionalSubject": isAdditionalSubject,
        "isTimeTableSubject": isTimeTableSubject,
        "totalExtraLeactureForSubject": totalExtraLeactureForSubject,
        "presentInExtraLeactureForSubject": presentInExtraLeactureForSubject,
        "absentInExtraLeactureForSubject": absentInExtraLeactureForSubject,
        "totalLeactures": totalLeactures,
        "presentLeactures": presentLeactures,
        "otherAttendance": otherAttendance,
        "absentLeactures": absentLeactures,
        "averagePresent": averagePresent,
        "averageTotal": averageTotal,
        "percentageAttendance": percentageAttendance,
        "subjectMasterId": subjectMasterId,
        "actualSubjectId": actualSubjectId,
        "subjectType": subjectType,
        "conversionMark": conversionMark,
        "isSubjectSeleted": isSubjectSeleted,
        "sequence": sequence,
        "subjectMappingId": subjectMappingId,
        "courseContent": courseContent,
        "isAttendaceFilled": isAttendaceFilled,
        "isExamDateSheetCreated": isExamDateSheetCreated,
        "isSubjectTeacher": isSubjectTeacher,
        "coList": coList,
        "poList": poList,
        "copoList": copoList,
    };
}
