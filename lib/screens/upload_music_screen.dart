import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadMusicScreen extends StatefulWidget {
  @override
  _UploadMusicScreenState createState() => _UploadMusicScreenState();
}

class _UploadMusicScreenState extends State<UploadMusicScreen> {
  String selectedVisibility = 'Public';
  bool showVisibilityOptions = false;
  String selectedDownloadOption = 'Not Free';
  bool showDownloadOptions = false;
  List<String> collaborators = [];

  @override
  void initState() {
    super.initState();
    // ตั้งค่า Status Bar ให้โปร่งใสและไอคอนเป็นสีขาว (ถ้าต้องการ)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,       // โปร่งใส
      statusBarIconBrightness: Brightness.light, // ไอคอนเป็นสีขาว
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// ทำให้ตัว AppBar อยู่เหนือเนื้อหา (body) เพื่อให้เห็น Gradient ด้านหลัง
      extendBodyBehindAppBar: true,
      
      /// AppBar โปร่งใส ไม่มีเงา
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      /// ไล่สีพื้นหลังตั้งแต่ด้านบน (สีเขียว) ลงไปด้านล่าง (สีดำ)
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 41, 157, 37), // สีเขียว
              const Color.fromARGB(255, 27, 26, 26),
              const Color.fromARGB(255, 12, 12, 12),
            ],
          ),
        ),
        child: SafeArea(
          /// SafeArea เพื่อเลี่ยงเนื้อหาโดนบังโดย Status Bar หรือ Notch
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // =========================
                //  ส่วนแสดงรูปเพลง + ปุ่มแก้ไข + ปุ่มอัปโหลดไฟล์ + ชื่อศิลปิน
                // =========================
                _buildCircleAvatarSection(),

                SizedBox(height: 20),

                // =========================
                //  TextField: Music Name
                // =========================
                _buildLabel('Music Name :'),
                SizedBox(height: 5),
                _buildTextField(),

                SizedBox(height: 15),

                // =========================
                //  TextField: Description
                // =========================
                _buildLabel('Description :'),
                SizedBox(height: 5),
                _buildTextField(),

                SizedBox(height: 25),

                // =========================
                //  ส่วน Options
                // =========================
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Options :',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // 1) Visibility (Public/Private)
                _buildOptionItem(
                  icon: Icons.public,
                  title: 'Visibility',
                  currentValue: selectedVisibility,
                  isDropdownOpen: showVisibilityOptions,
                  onTap: () {
                    setState(() {
                      showVisibilityOptions = !showVisibilityOptions;
                    });
                  },
                  options: const ['Public', 'Private'],
                ),

                SizedBox(height: 10),

                // 2) Collaboration
                _buildCollaborationItem(),

                SizedBox(height: 10),

                // 3) Free Download (Free/Not Free)
                _buildOptionItem(
                  icon: Icons.download,
                  title: 'Free Download',
                  currentValue: selectedDownloadOption,
                  isDropdownOpen: showDownloadOptions,
                  onTap: () {
                    setState(() {
                      showDownloadOptions = !showDownloadOptions;
                    });
                  },
                  options: const ['Free', 'Not Free'],
                ),

                SizedBox(height: 30),

                // =========================
                //  ปุ่ม UPLOAD
                // =========================
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: เชื่อมต่อ Backend หรืออัปโหลดข้อมูล
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 23, 23, 23),
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white, width: 1),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Text('UPLOAD'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================================
  //                           BUILD WIDGET METHODS
  // =========================================================================

  /// ส่วนของรูปเพลง + วงกลม + ปุ่มแก้ไข + ปุ่มอัปโหลดไฟล์ + ชื่อศิลปิน
  Widget _buildCircleAvatarSection() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // ปรับขนาด Container ให้ใหญ่ขึ้น (260x260)
            Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 5),
              ),
            ),
            // CircleAvatar ด้านใน
            CircleAvatar(
              radius: 124,
              backgroundColor: const Color.fromARGB(255, 41, 41, 41),
              child: Icon(Icons.music_note, size: 160, color: Colors.white),
            ),
            // ปุ่มสำหรับแก้ไขรูป (อยู่มุมขวาล่าง)
            Positioned(
              right: 0,
              bottom: 0,
              child: InkWell(
                onTap: () {
                  // TODO: อัปโหลด/เปลี่ยนรูปเพลง
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.edit, color: Colors.white, size: 20),
                ),
              ),
            ),
            // ปุ่มสำหรับอัปโหลดไฟล์เพลง (อยู่มุมซ้ายล่าง)
            Positioned(
              left: 0,
              bottom: 0,
              child: InkWell(
                onTap: () {
                  // TODO: เลือกไฟล์เพลงจากเครื่อง (File picker)
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.file_upload, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Artist Name',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  /// Label ของ TextField
  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// สร้าง TextField (ดีไซน์สีเข้ม)
  Widget _buildTextField() {
    return TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade900,
        hintStyle: TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// สร้าง Option แต่ละรายการ (เช่น Visibility / Free Download)
  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required String currentValue,
    required bool isDropdownOpen,
    required VoidCallback onTap,
    required List<String> options,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // แถวหลักสำหรับโชว์ icon + title + currentValue + arrow
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    currentValue,
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          // ถ้า isDropdownOpen = true จะแสดงตัวเลือกต่าง ๆ
          if (isDropdownOpen)
            Column(
              children: options.map((option) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      // แยกการอัปเดต state ตามรายการตัวเลือก
                      if (options.contains('Public')) {
                        // หมายถึงเป็นตัวเลือก Public/Private
                        selectedVisibility = option;
                        showVisibilityOptions = false;
                      } else {
                        // หมายถึงเป็นตัวเลือก Free/Not Free
                        selectedDownloadOption = option;
                        showDownloadOptions = false;
                      }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.white24),
                      ),
                    ),
                    child: Text(
                      option,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  /// สร้าง Option สำหรับ Collaboration (แสดงรายชื่อ + ปุ่มเพิ่ม + ปุ่มลบ)
  Widget _buildCollaborationItem() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // หัวข้อ Collaboration
            Row(
              children: [
                Icon(Icons.people, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Collaboration',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // แสดงรายชื่อ collaborators ด้วย Chip ที่มีปุ่มลบ
            if (collaborators.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: collaborators.map((artist) {
                  return Chip(
                    label: Text(artist),
                    backgroundColor: Colors.green,
                    labelStyle: TextStyle(color: Colors.white),
                    // ไอคอนลบเล็ก ๆ บน Chip
                    deleteIcon: Icon(Icons.close, color: Colors.white),
                    onDeleted: () {
                      setState(() {
                        collaborators.remove(artist);
                      });
                    },
                  );
                }).toList(),
              ),

            // ปุ่มเพิ่ม Collaborator
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // เพิ่ม collaborator ตัวอย่าง (New Artist)
                setState(() {
                  collaborators.add('New Artist');
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 23, 23, 23),
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white, width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(width: 5),
                  Text('Add Artist'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
