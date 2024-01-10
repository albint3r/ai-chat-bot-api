import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class AvatarPicture extends StatelessWidget {
  const AvatarPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: Assets.images.avatar.provider(),
    );
  }
}
