import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  XFile? imageFile;

  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 300, maxWidth: 300);
      if (image == null) return;
      final imageTemp = XFile(image.path);
      setState(() => imageFile = imageTemp);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = XFile(image.path);
      setState(() => imageFile = imageTemp);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Profile
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _profileImage(context),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Siphamandla Mdletshe',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              //border line
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              //menu body
              _menuButton(Icons.person_outline, 'Profile'),
              _menuButton(Icons.tag_faces, 'Promotions'),
              _menuButton(Icons.history, 'History'),
              _menuButton(Icons.settings_outlined, 'Settings & Support'),
              _menuButton(Icons.help_outline_rounded, 'Help'),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey),
                  ),
                ),
              ),

              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text('Log out'),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.red)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileImage(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 70,
          backgroundImage: imageFile != null
              ? XFileImage(imageFile!)
              : const AssetImage('images/istockphoto-1300845620-612x612.jpg')
          as ImageProvider,
        ),
        Positioned(
          bottom: -5.0,
          right: -5.0,
          child: IconButton(
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.blue,
            ),
            onPressed: () {
              showMaterialModalBottomSheet(
                  animationCurve: Curves.easeInSine,
                  context: context,
                  builder: (BuildContext context) {
                    return _bottomSheet(context);
                  });
            },
          ),
        )
      ],
    );
  }

  Widget _bottomSheet(BuildContext context) {
    return SizedBox(
      height: 125.0,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close_outlined,
              color: Colors.red,
            ),
          ),
          const Text('Update your profile Picture'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                  onPressed: () {
                    pickImageFromCamera()
                        .then((value) => Navigator.pop(context));
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera')),
              TextButton.icon(
                  onPressed: () {
                    pickImageFromGallery()
                        .then((value) => Navigator.pop(context));
                  },
                  icon: const Icon(Icons.photo),
                  label: const Text('Gallery')),
            ],
          )
        ],
      ),
    );
  }

  Widget _menuButton(IconData iconData, String label) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30.0,
            color: Colors.blue,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}