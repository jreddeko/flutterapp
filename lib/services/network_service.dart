import 'package:nghe_phap/services/rest_client.dart';

abstract class NetworkService {
  RestClient rest;
  NetworkService(this.rest);
}
