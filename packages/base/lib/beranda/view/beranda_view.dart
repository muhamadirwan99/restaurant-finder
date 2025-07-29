import 'package:base/beranda/controller/beranda_controller.dart';
import 'package:flutter/material.dart';

class BerandaView extends StatefulWidget {
  const BerandaView({super.key});

  Widget build(BuildContext context, BerandaController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Beranda",
        ),
        // actions: const [
        //   SwitchThemeWidget(),
        //   SizedBox(width: 16.0),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(
              builder: (context) {
                return SizedBox(
                  height: 150.0,
                  child: ListView.builder(
                    itemCount: controller.items.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    itemBuilder: (context, index) {
                      var item = controller.items[index];
                      return Container(
                        height: 150.0,
                        width: MediaQuery.of(context).size.width * 0.7,
                        margin: const EdgeInsets.only(right: 16.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              16.0,
                            ),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              16.0,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Image.network(
                                item["photo"],
                                height: 150.0,
                                width: MediaQuery.of(context).size.width * 0.7,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Container(
                                    height: 150.0,
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 150.0,
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.grey,
                                        size: 40,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Positioned(
                                bottom: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    item["title"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<BerandaView> createState() => BerandaController();
}
