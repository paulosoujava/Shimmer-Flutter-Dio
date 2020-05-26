import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonloader/component/skeleton.dart';
import 'package:skeletonloader/model/address_model.dart';
import 'package:skeletonloader/repositories/address_repository.dart';

class HomePage extends StatefulWidget {
  String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var streamConsultAddress = StreamController<List<AddressModel>>();
  AddressRepository _addressRepository;

  @override
  dispose() {
    streamConsultAddress.close();
    super.dispose();
  }

  @override
  initState() {
    _addressRepository = AddressRepository();
    super.initState();
  }

  loadAddress() {
    streamConsultAddress.sink.add(null);
    _addressRepository.getAddress().then((on) {
      streamConsultAddress.sink.add(on);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: loadAddress,
          )
        ],
      ),
      body: StreamBuilder(
        initialData: List<AddressModel>(),
        stream: streamConsultAddress.stream,
        builder: (BuildContext context,
            AsyncSnapshot<List<AddressModel>> snapshot) {
          if (!snapshot.hasData) {
            return Skeleton(10);
          } else {
            var address = snapshot.data;
            return Visibility(
              visible: address.isNotEmpty,
              replacement: Center(child: Text('Clique na lupa')),
              child: ListView.builder(
                itemCount: address.length,
                itemBuilder: (_, index) {
                  var mAddress = address[index];
                    return ListTile(
                      leading: Icon(
                        Icons.location_city,
                        size: 50,
                      ),
                      title: Text(mAddress.logradouro),
                      subtitle: Text(mAddress.bairro),
                    );

                },
              ),
            );
          }
        },
      ),
    );
  }
}
