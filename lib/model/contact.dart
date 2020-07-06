class Contact {
  int id;
  String name;
  String mobileNo;
  String landlineNo;
  String image;
  int isFav;

  Contact(
      {this.id,
      this.name,
      this.mobileNo,
      this.landlineNo,
      this.image,
      this.isFav = 0});

  //This will be used to convert JSON objects that
  //are coming from querying the database and converting
  //it into a Contact object
  factory Contact.fromDatabaseJson(Map<String, dynamic> data) => Contact(
        id: data['id'],
        name: data['name'],
        mobileNo: data['mobileNo'],
        landlineNo: data['landlineNo'],
        image: data['image'],
        //Since sqlite doesn't have boolean type for true/false
        //we will 0 to denote that it is false
        //and 1 for true
        isFav: data['isFav'],
      );
  Map<String, dynamic> toDatabaseJson() => {
        //This will be used to convert # Contact objects that
        //are to be stored into the database in a form of JSON
        "id": this.id,
        "name": this.name,
        "mobileNo": this.mobileNo,
        "landlineNo": this.landlineNo,
        "image": this.image,
        "isFav": this.isFav
      };
}
