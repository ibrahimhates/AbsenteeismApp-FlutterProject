import 'package:absenteeism_v2/models/calendar/CourseCalendar.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'course_calendar_service.g.dart';

@RestApi(baseUrl: "https://absenteeismapp.azurewebsites.net/api/coursecalendars")
abstract class CalendarService{
  factory CalendarService(Dio dio,{String baseUrl}) = _CalendarService;

  @GET('{id}')
  Future<List<CourseCalendar>> getAllCourseCalendar(@Path("id")int id);

  @GET('')
  Future<CourseCalendar> getOneCourseCalendar(
        @Header("Authorization") String token,
        @Query("dId")int dayId,
        @Query("cId")int courseId
      );

  @POST('')
  Future<CourseCalendar> createOneCourseCalendar(
        @Header("Authorization") String token,
        @Query("dId")int dayId,
        @Query("cId")int courseId,
        @Body() CourseCalendar calendar
      );

  @PUT('')
  Future<void> updateOneCourseCalendar(
        @Header("Authorization") String token,
        @Query("dId")int dayId,
        @Query("cId")int courseId,
        @Body() CourseCalendar calendar
      );

  @DELETE('')
  Future<void> deleteOneCalendar(
        @Header("Authorization") String token,
        @Query("dId")int dayId,
        @Query("cId")int courseId
      );

}