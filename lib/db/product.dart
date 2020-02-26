import 'package:bookify/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  Firestore _firestore = Firestore.instance;

  String collection = 'products';
  Future<List<Product>> getAllProducts()
  {

    String collection;
    _firestore.collection(collection).getDocuments().then((snap){
      List<Product> featuredProducts = [];
      snap.documents.map((snapshot) => featuredProducts.add(Product.fromSnapshot(snapshot)));
      return featuredProducts;
    });
  }
  Future<List<Product>> getAllProductbyCategory(String category)
  {

    String collection;
    _firestore.collection(collection).where("category",isEqualTo: category).getDocuments().then((snap){
      List<Product> featuredProducts = [];
      snap.documents.map((snapshot) => featuredProducts.add(Product.fromSnapshot(snapshot)));
      return featuredProducts;
    });
  }
}