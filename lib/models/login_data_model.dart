// To parse this JSON data, do
//
//     final loginDataModel = loginDataModelFromJson(jsonString);

import 'dart:convert';

LoginDataModel loginDataModelFromJson(String str) => LoginDataModel.fromJson(json.decode(str));

String loginDataModelToJson(LoginDataModel data) => json.encode(data.toJson());

class LoginDataModel {
    String accessToken;
    String tokenType;
    int expiresIn;
    String xContextId;
    String xUserId;
    String xLogoId;
    String xRx;
    String pChangeSetting;
    String pChangeStatus;
    String sessionId;
    String xToken;
    String issued;
    String expires;

    LoginDataModel({
        required this.accessToken,
        required this.tokenType,
        required this.expiresIn,
        required this.xContextId,
        required this.xUserId,
        required this.xLogoId,
        required this.xRx,
        required this.pChangeSetting,
        required this.pChangeStatus,
        required this.sessionId,
        required this.xToken,
        required this.issued,
        required this.expires,
    });

    factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        xContextId: json["X-ContextId"],
        xUserId: json["X-UserId"],
        xLogoId: json["X-LogoId"],
        xRx: json["X-RX"],
        pChangeSetting: json["PChangeSetting"],
        pChangeStatus: json["PChangeStatus"],
        sessionId: json["SessionId"],
        xToken: json["X_Token"],
        issued: json[".issued"],
        expires: json[".expires"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "X-ContextId": xContextId,
        "X-UserId": xUserId,
        "X-LogoId": xLogoId,
        "X-RX": xRx,
        "PChangeSetting": pChangeSetting,
        "PChangeStatus": pChangeStatus,
        "SessionId": sessionId,
        "X_Token": xToken,
        ".issued": issued,
        ".expires": expires,
    };
}
