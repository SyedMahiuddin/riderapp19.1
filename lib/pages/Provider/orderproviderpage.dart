import 'dart:convert';
import '../Models/tempmodel.dart';
import 'package:http/http.dart' as http;


/*class TechNews{
  List <TempModel> techNews=[];
  List <TempModel> newOrder=[];
  Future<void> getnews() async{
    http.Response response;
    String apilink="https://mocki.io/v1/d2810ee5-2d8b-4660-97e7-f4f9a7cc9741";
    response=await http.get(Uri.parse(apilink));
    var jsondata= jsonDecode(response.body);
    if(jsondata['status']=='ok')
    {
      jsondata['articles'].forEach((element){
          TempModel articleModel = TempModel(
            storeAddress: element['shopadress'],
            userAddress: element['useradress'],
            pickUpTime: element['pickuptime'],
            deliveryTime: element['deliverytime'],
            distance: element['distance'],
            accept: element['bool'],
          );
          techNews.add(articleModel);
      });
    }
  }
}*/


class Repository {
  String uri = "https://mocki.io/v1/6937e104-f1cd-4a06-9b7b-b05513d736f4";

  Future getData() async {
    try{
      final response = await http.get(Uri.parse(uri));

      if(response.statusCode == 200){
        Iterable it = jsonDecode(response.body);
        List<Order> orderList = it.map((e) => Order.fromJson(e)).toList();
        return orderList;
      } else {
        throw Exception('Failed to load data');
      }
    }catch (e){
      return e.toString();
    }
  }

/*Future updatePage(String id, String Bool) async {

    try{
      final response = await http.put(Uri.parse('$uri/$id'), body: {
        'bool' : Bool
      });
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    } catch(e){
      return e.toString();
    }
  }*/
}

