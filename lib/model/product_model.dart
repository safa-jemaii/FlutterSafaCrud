List<ProductModel> productsFromJson(dynamic str) =>
    List<ProductModel>.from((str).map((x) => ProductModel.fromJson(x)));

class ProductModel {
  late String? id;
  late String? title;
  late String? description;
  late String? image;
  late int? prix;
  late DateTime? date_ajout;
  late int? id_Annonceur;
  late int? id_categorie;

  ProductModel({
    this.id,
    this.title,
    this.description,
    this.prix,
    this.date_ajout,
     this.id_Annonceur,
     this.id_categorie,
    this.image,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    prix = json['prix'];
    date_ajout = json['date_ajout'];
    id_Annonceur = json['id_Annonceur'];
    id_categorie = json['id_categorie'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['prix'] = prix;
    _data['date_ajout'] = date_ajout;
    _data['id_Annonceur'] = id_Annonceur;
    _data['id_categorie'] = id_categorie;
    _data['image'] = image;
    return _data;
  }
}
