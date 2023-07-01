import 'package:absenteeism_v2/models/course/CourseCreate.dart';
import 'package:absenteeism_v2/models/course/TodayCourses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../../models/course/Course.dart';

part 'course_service.g.dart';

@RestApi(baseUrl: "https://absenteeismapp.azurewebsites.net/api/courses")
abstract class CourseService{
  factory CourseService(Dio dio,{String baseUrl}) = _CourseService;

  @POST('/create')
  Future<CourseCreate> getCreateOneCourse(
        @Header("Authorization") String token,
        @Body() CourseCreate courseCreate
      );

  @GET('/one/{id}')
  Future<Course> getOneCourse(
        @Header("Authorization") String token,
        @Path("id")int id
      );

  @DELETE('{id}')
  Future<void> deleteOneCourse(
        @Header("Authorization") String token,
        @Path("id")int id
      );

  @GET('/byuser')
  Future<List<Course>> getAllCourseByUser(@Header("Authorization") String token);

  @GET('/today/{id}')
  Future<List<TodayCourses>> getTodayCourses(
        @Header("Authorization") String token,
        @Path("id")int id
      );

  @PUT('')
  Future<void> updateOneCourse(
        @Header("Authorization") String token,
        @Body() Course course
      );

}