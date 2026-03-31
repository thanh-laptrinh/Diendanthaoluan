import 'package:flutter/material.dart';

void main() {
  runApp(const ForumApp());
}

class ForumApp extends StatelessWidget {
  const ForumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('FORUM', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          const CircleAvatar(backgroundColor: Colors.blue, child: Text('T', style: TextStyle(color: Colors.white))),
          const SizedBox(width: 16),
        ],
      ),
      drawer: const Drawer(
  child: SidebarLeft(),
),
      body: Row(
        children: [
          // Sidebar bên trái (Chỉ hiện trên màn hình lớn)
          if (MediaQuery.of(context).size.width > 800)
            const SizedBox(width: 250, child: SidebarLeft()),
          
          // Nội dung chính (Danh sách bài viết)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const QuickPostBox(),
                const SizedBox(height: 16),
                const ForumPostCard(
                  title: 'Thảo luận về AI trong tương lai',
                  category: 'Công nghệ',
                  time: '2 giờ trước',
                  author: 'Tuan Anh',
                  comments: 12,
                  likes: 45,
                ),
                const ForumPostCard(
                  title: 'Lộ trình học Flutter cho người mới',
                  category: 'Lập trình',
                  time: '5 giờ trước',
                  author: 'Minh Dev',
                  comments: 8,
                  likes: 20,
                ),
              ],
            ),
          ),

          // Sidebar bên phải (Chỉ hiện trên màn hình rất lớn)
          if (MediaQuery.of(context).size.width > 1100)
            const SizedBox(width: 250, child: SidebarRight()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreatePostPage()),
    );
  },
  backgroundColor: Colors.teal,
  label: const Text('TẠO BÀI MỚI', style: TextStyle(color: Colors.white)),
  icon: const Icon(Icons.add, color: Colors.white),
),
    );
  }
}

// Widget Thẻ bài viết (Card) theo thiết kế đường kẻ của bạn
class ForumPostCard extends StatelessWidget {
  final String title, category, time, author;
  final int comments, likes;

  const ForumPostCard({super.key, 
    required this.title, required this.category, required this.time, 
    required this.author, required this.comments, required this.likes
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell( // Thêm InkWell để có hiệu ứng bấm
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PostDetailPage(title: title)),
      );
    },
      
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.image, color: Colors.grey),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('$category - $time bởi $author', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.comment_outlined, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text('$comments', style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 16),
                      Icon(Icons.favorite_border, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text('$likes', style: const TextStyle(fontSize: 12)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      )
    );
  }
}

// Các Widget phụ khác (QuickPostBox, Sidebar...)
class QuickPostBox extends StatelessWidget {
  const QuickPostBox({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Bạn muốn chia sẻ điều gì?',
            border: InputBorder.none,
            prefixIcon: CircleAvatar(radius: 15, backgroundColor: Colors.grey[200]),
          ),
        ),
      ),
    );
  }
}

class SidebarLeft extends StatelessWidget {
  const SidebarLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('CHUYÊN MỤC', 
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 10),
          
          // Mục Công nghệ
          ListTile(
            leading: const Icon(Icons.bolt, color: Colors.blue), 
            title: const Text('Công nghệ'), 
            onTap: () {},
          ),
          
          // Mục Lập trình
          ListTile(
            leading: const Icon(Icons.code), 
            title: const Text('Lập trình'), 
            onTap: () {},
          ),
          
          // Mục Game
          ListTile(
            leading: const Icon(Icons.videogame_asset), 
            title: const Text('Game'), 
            onTap: () {},
          ),

          // --- ĐÂY LÀ MỤC DU LỊCH BẠN CẦN THÊM ---
          ListTile(
            leading: const Icon(Icons.explore_outlined, color: Colors.green), 
            title: const Text('Du lịch'), 
            onTap: () {
              // Sau này bạn sẽ viết lệnh chuyển trang ở đây
            },
          ),
          // ---------------------------------------

          const SizedBox(height: 20),
          const Text('DANH MỤC', 
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12)),
          
          // Thêm các mục danh mục nhỏ (DM1, DM2) như thiết kế của bạn
          ListTile(
            leading: const Icon(Icons.label_outline, size: 20),
            title: const Text('Thảo luận chung', style: TextStyle(fontSize: 14)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class SidebarRight extends StatelessWidget {
  const SidebarRight({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Sidebar Phải (Nổi bật)'));
  }
}
// 1. TRANG CHI TIẾT BÀI VIẾT
class PostDetailPage extends StatelessWidget {
  final String title;
  const PostDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết bài viết')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Divider(),
            const Text('Nội dung chi tiết của bài viết sẽ hiển thị ở đây...'),
          ],
        ),
      ),
    );
  }
}

// 2. TRANG TẠO BÀI VIẾT MỚI
class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tạo bài viết mới')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Tiêu đề')),
            const TextField(decoration: InputDecoration(labelText: 'Nội dung'), maxLines: 5),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('ĐĂNG BÀI'),
            )
          ],
        ),
      ),
    );
  }
}