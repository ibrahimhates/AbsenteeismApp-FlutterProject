import 'package:absenteeism_v2/models/syllabus/Syllabus.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';


part 'syllabus_service.g.dart';

@RestApi(baseUrl: "https://absenteeismapp.azurewebsites.net/api/Syllabus")
abstract class SyllabusService{
  factory SyllabusService(Dio dio,{String baseUrl}) = _SyllabusService;
  
  @GET('')
  Future<List<Syllabus>> getSyllabus(@Header("Authorization") String token);
}