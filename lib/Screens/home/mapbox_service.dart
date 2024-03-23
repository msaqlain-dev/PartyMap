import 'dart:convert';
import 'package:http/http.dart' as http;

class MapboxService {
  final String _baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
  final String _apiKey =
      'pk.eyJ1IjoicGFydHltYXAiLCJhIjoiY2x0Nm5wNWVoMDRmNDJxcHBqYTFuczdpNCJ9.k6rBlzpj-frFkNv8dOOtlA';

  Future<List<String>> getSuggestions(String query) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/$query.json?access_token=$_apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<String> suggestions = data['features']
          .map<String>((feature) => feature['place_name'] as String)
          .toList();
      return suggestions;
    } else {
      throw Exception('Failed to load suggestions');
    }
  }
}
