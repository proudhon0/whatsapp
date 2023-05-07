import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class WhatsAppAPI {
  String _baseUrl;
  String _token;
  String _instanceId;

  WhatsAppAPI(String baseUrl, String token, String instanceId) {
    this._baseUrl = baseUrl;
    this._token = token;
    this._instanceId = instanceId;
  }

  // Sets the Base URL for the API
  void setBaseUrl(String baseUrl) {
    this._baseUrl = baseUrl;
  }

  // Sets the token for the API
  void setToken(String token) {
    this._token = token;
  }

  // Sets the instance ID for the API
  void setInstanceId(String instanceId) {
    this._instanceId = instanceId;
  }

  // Sends a text message to the given recipient using the WhatsApp Business API
  Future<Map<String, dynamic>> sendMessage(String recipient, String message) async {
    String url = '${this._baseUrl}/v1/messages';
    Map<String, dynamic> requestBody = {
      'phone': recipient,
      'message': {'body': message},
    };

    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${this._token}',
        'X-WABA-Instance-ID': this._instanceId,
      },
      body: jsonEncode(requestBody),
    );

    return jsonDecode(response.body);
  }

  // Gets the message status for the given message ID using the WhatsApp Business API
  Future<Map<String, dynamic>> getMessageStatus(String messageId) async {
    String url = '${this._baseUrl}/v1/messages/${messageId}/status';

    http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${this._token}',
        'X-WABA-Instance-ID': this._instanceId,
      },
    );

    return jsonDecode(response.body);
  }

  // Sends a message template to the given recipient using the WhatsApp Business API
  Future<Map<String, dynamic>> sendTemplateMessage(String recipient, String namespace, String elementName, Map<String, dynamic> templateParameters) async {
    String url = '${this._baseUrl}/v1/messages';
    Map<String, dynamic> requestBody = {
      'phone': recipient,
      'message': {'namespace': namespace, 'element_name': elementName, 'template_parameters': templateParameters},
    };

    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${this._token}',
        'X-WABA-Instance-ID': this._instanceId,
      },
      body: jsonEncode(requestBody),
    );

    return jsonDecode(response.body);
  }

  // Creates a session for the given phone number using the WhatsApp Business API
  Future<Map<String, dynamic>> createSession(String phoneNumber) async {
    String url = '${this._baseUrl}/v1/sessions';
    Map<String, dynamic> requestBody = {
      'phone': phoneNumber,
    };

    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${this._token}',
        'X-WABA-Instance-ID': this._instanceId,
      },
      body: jsonEncode(requestBody),
    );

    return jsonDecode(response.body);
  }
Evet, tabii:

  // Terminates a session for the given session ID using the WhatsApp Business API
  Future<Map<String, dynamic>> terminateSession(String sessionId) async {
    String url = '${this._baseUrl}/v1/sessions/${sessionId}';
    http.Response response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${this._token}',
        'X-WABA-Instance-ID': this._instanceId,
      },
    );

    return jsonDecode(response.body);
  }
}
 
