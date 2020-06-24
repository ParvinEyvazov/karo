import 'dart:convert';

Faculty facultyFromJson(String str) => Faculty.fromJson(json.decode(str));

String facultyToJson(Faculty data) => json.encode(data.toJson());

class Faculty {
    Faculty({
        this.faculties,
        this.departments,
    });

    List<String> faculties;
    Map<String, List<String>> departments;

    factory Faculty.fromJson(Map<String, dynamic> json) => Faculty(
        faculties: json["faculties"] == null ? null : List<String>.from(json["faculties"].map((x) => x)),
        departments: json["departments"] == null ? null : Map.from(json["departments"]).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
    );

    Map<String, dynamic> toJson() => {
        "faculties": faculties == null ? null : List<dynamic>.from(faculties.map((x) => x)),
        "departments": departments == null ? null : Map.from(departments).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
    };
}