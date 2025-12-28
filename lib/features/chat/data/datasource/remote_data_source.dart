import 'package:mini_chat_ai_app/core/network/network_client.dart';

class ChatRemoteDataSource {
  final NetworkClientBasicHttp clientBasicHttp;

  ChatRemoteDataSource(this.clientBasicHttp);

  Future<String> getMessage() async {
    final json = await clientBasicHttp.get('/comments/1');
    return json['body'] as String;
  }
}
