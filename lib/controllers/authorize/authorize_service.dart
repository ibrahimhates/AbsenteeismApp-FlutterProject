import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import '../../models/authentication/Login.dart';
import '../../models/authentication/Register.dart';

part 'authorize_service.g.dart';

@RestApi(baseUrl: "https://absenteeismapp.azurewebsites.net/api/authentication")
abstract class AuthorizeService{
  factory AuthorizeService(Dio dio,{String baseUrl}) = _AuthorizeService;

  @POST('/login')
  Future<String> getTokenWithLogin(@Body() Login login);

  @POST('/register')
  Future<String> getTokenWithRegister(@Body() Register login);

}

