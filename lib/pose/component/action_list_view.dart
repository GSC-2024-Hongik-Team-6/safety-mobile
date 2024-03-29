import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/common/component/custom_list_view.dart';
import 'package:safetyedu/common/component/category_card.dart';
import 'package:safetyedu/pose/model/action_model.dart';
import 'package:safetyedu/pose/provider/pose_provider.dart';
import 'package:safetyedu/pose/view/action_detail_screen.dart';

class ActionListView extends ConsumerWidget {
  const ActionListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      CustomListView<ActionModel>(
        provider: poseProvider,
        itemBuilder: (_, index, model) => GestureDetector(
          onTap: () => context.pushNamed(
            ActionDetailScreen.routeName,
            pathParameters: {
              'id': model.id.toString(),
            },
          ),
          child: CategoryCard.fromActionModel(model),
        ),
      );
}
