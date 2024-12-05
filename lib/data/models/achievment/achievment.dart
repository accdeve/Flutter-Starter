class AchievmentResponse {
    final bool success;
    final int code;
    final String message;
    final List<Achievment>? data;

    AchievmentResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory AchievmentResponse.fromJson(Map<String, dynamic> json) => AchievmentResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: json["data"] != null ? List<Achievment>.from(json["data"].map((x) => Achievment.fromJson(x))) : null,
    );

}

class Achievment {
    final int id;
    final String subject;
    final String difficulty;
    final int point;

    Achievment({
        required this.id,
        required this.subject,
        required this.difficulty,
        required this.point,
    });

    factory Achievment.fromJson(Map<String, dynamic> json) => Achievment(
        id: json["id"],
        subject: json["subject"],
        difficulty: json["difficulty"],
        point: json["point"],
    );
}
