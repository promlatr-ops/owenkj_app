import 'dart:convert';
import 'package:http/http.dart' as http;

class AqiResponse {
  final String station;
  final int? aqi;
  final double? pm25;
  final DateTime? time;

  AqiResponse({required this.station, this.aqi, this.pm25, this.time});
}

class AqicnService {
  final String token;
  AqicnService(this.token);

  /// Get observation by geographic coordinates using the AQICN "map/bounds" or "feed/geo:" endpoints.
  /// We'll use the `feed/geo:lat;lon` endpoint which returns current aqi and iaqi values for a nearby station.
  Future<AqiResponse> fetchByGeo(double lat, double lon) async {
    final url = Uri.parse('https://api.waqi.info/feed/geo:$lat;$lon/?token=$token');
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    Map<String, dynamic> body;
    try {
      body = json.decode(res.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to parse JSON response: ${e.toString()}\nRaw body: ${res.body}');
    }

    if (body['status'] != 'ok') {
      // Some API error responses put the message in data or directly in the body
      String message = '';
      try {
        if (body['data'] is Map && body['data']['message'] != null) {
          message = body['data']['message'].toString();
        } else if (body['data'] != null) {
          message = body['data'].toString();
        } else if (body['status'] != null) {
          message = body['status'].toString();
        } else {
          message = 'Unknown API error';
        }
      } catch (_) {
        message = body.toString();
      }
      throw Exception('API error: $message\nFull response: ${res.body}');
    }
    final data = body['data'] as Map<String, dynamic>;
    final city = (data['city'] is Map && data['city']['name'] != null) ? data['city']['name'] as String : 'Unknown';
    final aqi = data['aqi'] is int ? data['aqi'] as int : (data['aqi'] is String ? int.tryParse(data['aqi']) : null);
    double? pm25;
    if (data['iaqi'] is Map && data['iaqi']['pm25'] != null) {
      final v = data['iaqi']['pm25']['v'];
      pm25 = (v is int) ? v.toDouble() : (v is double ? v : double.tryParse('$v'));
    }
    DateTime? time;
    if (data['time'] is Map && data['time']['iso'] != null) {
      time = DateTime.tryParse(data['time']['iso']);
    }
    return AqiResponse(station: city, aqi: aqi, pm25: pm25, time: time);
  }
}
