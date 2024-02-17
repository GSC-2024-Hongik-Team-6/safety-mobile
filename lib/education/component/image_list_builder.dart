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
        itemBuilder: (context, index) => SizedBox(
          height: 50,
          child: Image.network(
            images[index],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
