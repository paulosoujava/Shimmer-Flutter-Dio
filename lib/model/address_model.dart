class AddressModel {
  String cep;
  String logradouro;
  String bairro;

  AddressModel({this.cep, this.logradouro, this.bairro});

  static AddressModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return AddressModel(
      cep: map['cep'],
      logradouro: map['logradouro'],
      bairro: map['bairro'],
    );
  }
}
