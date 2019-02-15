import 'package:card_example/services/rest_client.dart';

abstract class NetworkService {
  RestClient rest;
  NetworkService(this.rest);
}
