class DocumentFetchMapperClass
{
  List<String> images;
  String address;
  String price;
   String createdAt;
   String id;
   String description;
   String title;
   String category;
   String phone;

   DocumentFetchMapperClass({
    required this.images,
     required this.address,
     required this.price,
     required this.createdAt,
     required this.id,
     required this.description,
     required this.title,
     required this.category,
     required this.phone,
});


   factory DocumentFetchMapperClass.fromJson(Map<String,dynamic> json)
   {

     var item = json['uplodimg'] as List;
     var images = item.map((i)=>i.toString()).toList();


     return DocumentFetchMapperClass(images: images,
         address: json['address'],
         id: json['id'],
         price: json['price'],
         description: json['discription'],
         title: json['title'],
         category: json['type'],
         createdAt: json['created_at'],
     phone: json['phone'] ?? "000");
   }

}