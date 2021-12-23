class ForgotPassword {
    String message;
    Provider provider;

    ForgotPassword({this.message, this.provider});

    ForgotPassword.fromJson(Map<String, dynamic> json) {
        this.message = json["message"];
        this.provider = json["provider"] == null ? null : Provider.fromJson(json["provider"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["message"] = this.message;
        if(this.provider != null)
            data["provider"] = this.provider?.toJson();
        return data;
    }
}

class Provider {
    int id;
    String firstName;
    String lastName;
    dynamic agentId;
    String email;
    String gender;
    dynamic geoFencingId;
    double latitude;
    double longitude;
    dynamic address;
    int otp;
    int commissionPercentage;
    String language;
    dynamic avatar;
    String countryCode;
    String mobile;
    String password;
    String blocked;
    String verified;
    String status;
    dynamic stripeAccId;
    String stripeCustId;
    dynamic paypalEmail;
    String loginBy;
    dynamic socialUniqueId;
    int walletBalance;
    dynamic referralUniqueId;
    dynamic qrcodeUrl;
    dynamic deletedAt;
    String rememberToken;
    String createdAt;
    String updatedAt;
    int rating;

    Provider({this.id, this.firstName, this.lastName, this.agentId, this.email, this.gender, this.geoFencingId, this.latitude, this.longitude, this.address, this.otp, this.commissionPercentage, this.language, this.avatar, this.countryCode, this.mobile, this.password, this.blocked, this.verified, this.status, this.stripeAccId, this.stripeCustId, this.paypalEmail, this.loginBy, this.socialUniqueId, this.walletBalance, this.referralUniqueId, this.qrcodeUrl, this.deletedAt, this.rememberToken, this.createdAt, this.updatedAt, this.rating});

    Provider.fromJson(Map<String, dynamic> json) {
        this.id = json["id"];
        this.firstName = json["first_name"];
        this.lastName = json["last_name"];
        this.agentId = json["agent_id"];
        this.email = json["email"];
        this.gender = json["gender"];
        this.geoFencingId = json["geo_fencing_id"];
        this.latitude = json["latitude"];
        this.longitude = json["longitude"];
        this.address = json["address"];
        this.otp = json["otp"];
        this.commissionPercentage = json["commission_percentage"];
        this.language = json["language"];
        this.avatar = json["avatar"];
        this.countryCode = json["country_code"];
        this.mobile = json["mobile"];
        this.password = json["password"];
        this.blocked = json["blocked"];
        this.verified = json["verified"];
        this.status = json["status"];
        this.stripeAccId = json["stripe_acc_id"];
        this.stripeCustId = json["stripe_cust_id"];
        this.paypalEmail = json["paypal_email"];
        this.loginBy = json["login_by"];
        this.socialUniqueId = json["social_unique_id"];
        this.walletBalance = json["wallet_balance"];
        this.referralUniqueId = json["referral_unique_id"];
        this.qrcodeUrl = json["qrcode_url"];
        this.deletedAt = json["deleted_at"];
        this.rememberToken = json["remember_token"];
        this.createdAt = json["created_at"];
        this.updatedAt = json["updated_at"];
        this.rating = json["rating"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["id"] = this.id;
        data["first_name"] = this.firstName;
        data["last_name"] = this.lastName;
        data["agent_id"] = this.agentId;
        data["email"] = this.email;
        data["gender"] = this.gender;
        data["geo_fencing_id"] = this.geoFencingId;
        data["latitude"] = this.latitude;
        data["longitude"] = this.longitude;
        data["address"] = this.address;
        data["otp"] = this.otp;
        data["commission_percentage"] = this.commissionPercentage;
        data["language"] = this.language;
        data["avatar"] = this.avatar;
        data["country_code"] = this.countryCode;
        data["mobile"] = this.mobile;
        data["password"] = this.password;
        data["blocked"] = this.blocked;
        data["verified"] = this.verified;
        data["status"] = this.status;
        data["stripe_acc_id"] = this.stripeAccId;
        data["stripe_cust_id"] = this.stripeCustId;
        data["paypal_email"] = this.paypalEmail;
        data["login_by"] = this.loginBy;
        data["social_unique_id"] = this.socialUniqueId;
        data["wallet_balance"] = this.walletBalance;
        data["referral_unique_id"] = this.referralUniqueId;
        data["qrcode_url"] = this.qrcodeUrl;
        data["deleted_at"] = this.deletedAt;
        data["remember_token"] = this.rememberToken;
        data["created_at"] = this.createdAt;
        data["updated_at"] = this.updatedAt;
        data["rating"] = this.rating;
        return data;
    }
}