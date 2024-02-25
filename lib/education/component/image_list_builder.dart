import 'package:flutter/material.dart';

class ImageListBuilder extends StatelessWidget {
  final List<String> images;

  const ImageListBuilder({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => InkWell(
          onTap: () => showDialog(
            context: context,
            builder: (context) => Center(
              child: Image.network(
                images[index],
                fit: BoxFit.contain,
              ),
            ),
          ),
          child: SizedBox(
            height: 80,
            child: Image.network(
              images[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
