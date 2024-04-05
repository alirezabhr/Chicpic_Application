import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/variant.dart';

import 'package:chicpic/ui/base_widgets/variant_preview_widget.dart';
import 'package:chicpic/ui/explore/widgets/user_additional_reminder_dialog.dart';
import 'package:chicpic/ui/base_widgets/filter_button.dart';

class ProductsExplore extends StatelessWidget {
  const ProductsExplore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.small),
          child: Row(
            children: [
              const Icon(FontAwesomeIcons.shirt,
                  color: Colors.black45, size: 22),
              const SizedBox(width: Insets.medium),
              Text(
                'Explore Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const Spacer(),
              const FilterButton(),
            ],
          ),
        ),
        const SizedBox(height: Insets.small),
        BlocConsumer<ProductsExploreBloc, ProductsExploreState>(
          listener: (context, state) {
            if (state is ProductsExploreFetchRemindUserAdditional) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const UserAdditionalReminderDialog();
                },
              );
            }
          },
          builder: (context, state) {
            if (state is ProductsExploreFetchLoading && state.firstPage == true) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              List<VariantPreview> variants =
                  BlocProvider.of<ProductsExploreBloc>(context).variants;

              return Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: variants.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return VariantPreviewWidget(variant: variants[index]);
                    },
                  ),
                  state is ProductsExploreFetchLoading
                      ? const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: Insets.medium),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Container()
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
