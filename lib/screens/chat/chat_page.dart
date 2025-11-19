import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {"name": "Alfi", "msg": "Ready kak?", "time": "09:21"},
      {"name": "Ilham", "msg": "Apa yang bisa kami bantu?", "time": "08:10"},
      {"name": "Farhan", "msg": "Promo 50%!", "time": "Kemarin"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Messages", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: CircleAvatar(
              radius: 26,
              backgroundColor: Colors.blueAccent.withOpacity(0.2),
              child: const Icon(Icons.store, color: Colors.blueAccent),
            ),
            title: Text(chats[i]["name"]!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            subtitle: Text(chats[i]["msg"]!,
                style: const TextStyle(color: Colors.grey)),
            trailing: Text(chats[i]["time"]!,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          );
        },
      ),
    );
  }
}
