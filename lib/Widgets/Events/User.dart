class User {
  String user;
  String webinarLink;
  String image;
  String EventId;
  String title;
  String date;
  String location;
  String description;
  String verify;
  String budget;
  String donors;
  String funded;


  User({
    this.user,
    this.webinarLink,
    this.image,
    this.EventId,
    this.title,
    this.date,
    this.location,
    this.description,
    this.verify,
    this.budget,
    this.donors,
    this.funded,

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user: json["enrollmentNo"],
      webinarLink: json["webinarLink"],
      image: json["image"] ,
      EventId: json["EventId"] as String,
      title: json["title"] ,
      date: json["date"] ,
      location: json["location"] ,
      description: json["description"] ,
      verify: json["verify"] ,
      budget: json["budget"] ,
      donors: json["donors"] ,
      funded: json["funded"] ,
    );
  }
}