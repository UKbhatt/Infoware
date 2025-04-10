import 'dart:convert';
import 'package:form/Api+Bloc/ModelClass/characterModel.dart';
import 'package:http/http.dart' as http;

class CharacterRepository {
  final String baseUrl = 'https://rickandmortyapi.com/api/character';

  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      return results.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
