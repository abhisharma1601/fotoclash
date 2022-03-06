class userModel{
  String? uid;
  String? email;
  String? name;


  userModel({
    this.email,this.name,this.uid,
  });

  factory userModel.fromMap(map){
     return userModel(
       uid: map['uid'],
       email: map['email'],
       name: map['name'],
     );
  }
}