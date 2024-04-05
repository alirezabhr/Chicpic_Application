import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/repositories/settings/settings_repository.dart';

import 'package:chicpic/bloc/settings/settings_bloc.dart';

import 'package:chicpic/services/snack_bar.dart';

import 'package:chicpic/ui/explore/widgets/user_additional_reminder_dialog.dart';


class FilterDialog extends StatefulWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late SettingsRepository settingsRepo;
  late bool _showPersonalized;

  @override
  void initState() {
    super.initState();
    settingsRepo = RepositoryProvider.of<SettingsRepository>(context);
    _showPersonalized = settingsRepo.showPersonalizedProducts;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsLoaded) {
          setState(() {
            _showPersonalized = settingsRepo.showPersonalizedProducts;
          });
        }
        if (state is SettingsError) {
          if (state is SettingsErrorUserAdditionalRequired) {
            // Open user additional dialog
            showDialog(context: context, builder: (context) {
              return const UserAdditionalReminderDialog();
            });
          } else {
            showSnackBar(context, state.message, SnackBarStatus.normal);
          }
        }
      },
      child: SimpleDialog(
        children: [
          SwitchListTile(
            title: const Text('Recommend Products?'),
            subtitle: const Text(
                'Enable it if you want to get recommendations based on your body size.'),
            value: _showPersonalized,
            onChanged: (val) {
              BlocProvider.of<SettingsBloc>(context).add(
                UpdateShowPersonalizedProducts(val),
              );
            },
            activeColor: Colors.purple.shade800,
          ),
        ],
      ),
    );
  }
}
