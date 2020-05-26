import 'package:skeletonloader/model/address_model.dart';
import 'package:dio/dio.dart';

class AddressRepository {
  Future<List<AddressModel>> getAddress() {
    var dio = Dio();
    return dio
        .get("https://viacep.com.br/ws/SC/Florianopolis/avenida/json/")
        .then((res) {
      return res.data
          .map<AddressModel>((end) => AddressModel.fromMap(end))
          .toList();
    });
  }
}
