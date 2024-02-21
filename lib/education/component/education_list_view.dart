import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/common/component/custom_list_view.dart';
import 'package:safetyedu/education/component/education_card.dart';
import 'package:safetyedu/education/model/education_model.dart';
import 'package:safetyedu/education/provider/education_provider.dart';
import 'package:safetyedu/education/view/education_detail_screen.dart';

/// [CategoryCard]의 리스트를 보여주는 ListView 위젯
class EducationListView extends ConsumerWidget {
  const EducationListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      CustomListView<EducationModel>(
        provider: educationProvider,
        itemBuilder: (_, index, model) => GestureDetector(
          onTap: () => context.goNamed(
            EducationDetailScreen.routeName,
            pathParameters: {
              'eid': model.id.toString(),
            },
          ),
          child: CategoryCard.fromEducationModel(model),
        ),
      );
}
