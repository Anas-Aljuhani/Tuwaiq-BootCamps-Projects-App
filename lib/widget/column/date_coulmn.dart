import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tuwaiq_project/helper/extinsion/size_config.dart';
import 'package:tuwaiq_project/screens/projectView/edit/bloc/edit_bloc.dart';

class DateCoulmn extends StatelessWidget {
  const DateCoulmn({
    super.key,
    required this.bloc,
  });

  final EditBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => showDatePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      initialDate: DateTime.now())
                  .then((date) {
                DateFormat formatter = DateFormat('dd/MM/yyyy');
                String formattedDate = formatter.format(date!);
                bloc.startDate = formattedDate;
              }),
              child: Container(
                constraints: const BoxConstraints(minHeight: 50),
                padding: EdgeInsets.symmetric(
                    horizontal: context.getWidth(multiply: 0.01)),
                decoration: BoxDecoration(
                    color: const Color(0xffededed),
                    boxShadow: kElevationToShadow[4],
                    borderRadius: BorderRadius.circular(12)),
                child: const Row(
                  children: [
                    Icon(Icons.date_range_outlined),
                    Text('Start Date'),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => showDatePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      initialDate: DateTime.now())
                  .then((date) {
                DateFormat formatter = DateFormat('dd/MM/yyyy');
                String formattedDate = formatter.format(date!);
                bloc.endDate = formattedDate;
              }),
              child: Container(
                constraints: const BoxConstraints(minHeight: 50),
                padding: EdgeInsets.symmetric(
                    horizontal: context.getWidth(multiply: 0.01)),
                decoration: BoxDecoration(
                    color: const Color(0xffededed),
                    boxShadow: kElevationToShadow[4],
                    borderRadius: BorderRadius.circular(12)),
                child: const Row(
                  children: [
                    Icon(Icons.date_range_outlined),
                    Text('End Date'),
                  ],
                ),
              ),
            ),
          ],
        ),
        context.addSpacer(multiply: 0.02),
        InkWell(
          onTap: () => showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                  initialDate: DateTime.now())
              .then((date) {
            DateFormat formatter = DateFormat('dd/MM/yyyy');
            String formattedDate = formatter.format(date!);
            bloc.presentationDate = formattedDate;
          }),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.getWidth(multiply: 0.04)),
            constraints: BoxConstraints(
                maxWidth: context.getWidth(multiply: 0.45),
                minHeight: 50),
            decoration: BoxDecoration(
                color: const Color(0xffededed),
                boxShadow: kElevationToShadow[4],
                borderRadius: BorderRadius.circular(12)),
            child: const Row(
              children: [
                Icon(Icons.date_range_outlined),
                Text('Presentation Date'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
