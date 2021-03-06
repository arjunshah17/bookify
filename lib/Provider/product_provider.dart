import 'dart:collection';

import 'package:bookify/Provider/user_provider.dart';
import 'package:bookify/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:place_picker/uuid.dart';
import 'package:provider/provider.dart';
enum Status{intilize, editing,sending,sended}
class ProductProvider with ChangeNotifier{
Product product;
Status state;
BuildContext _context;
Firestore _firestore = Firestore.instance;
FirebaseStorage _firebaseStorage=FirebaseStorage.instance;
ProductProvider.init(BuildContext context)
{
  state=Status.intilize;
  _context=context;
  notifyListeners();
  product=Product.empty();

}

  Future<void> uploadData() async {
   state=Status.sending;
   notifyListeners();
   for(int i=0;i<product.imageTemp.length;i++)
     {

       product.image.add("${Uuid().generateV4()}");

     }
   product.coverImage=product.image[0];
   try {

     await _firestore.collection("products").document(product.id).setData(
         product.toMap());


      _uploadProductImage();


   }
   catch(e)
    {
print(e.toString());
state=Status.sended;
notifyListeners();
Navigator.of(_context).pop();
    }

  
  }

  Future<void> _uploadProductImage() async {
   String coverUrl;
  for(int i=0;i<product.image.length;i++)
    {
      Map urlMap = HashMap<String,Object>();

      ByteData data= await product.imageTemp[i].getByteData(quality: 10);
      final StorageReference storageReference = FirebaseStorage().ref().child(product.image[i]);
      final StorageUploadTask uploadTask = storageReference.putData(data.buffer.asUint8List());

      var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
      urlMap["url"]=dowurl.toString();
      if(i==0)
        {
          coverUrl=dowurl.toString();
          Map map = HashMap<String,Object>();
          map["coverImage"]=coverUrl;

        await  _firestore.collection("products").document(product.id).updateData(map);
        }

     await  _firestore.collection("products").document(product.id).collection(
          "images").document(product.image[i]).setData(urlMap);



    }
   state=Status.sended;
   notifyListeners();
   Navigator.of(_context).pop();




  }


}