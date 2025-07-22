import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_app/core/responsive/responsive_extention.dart';
import 'package:to_do_app/core/themes/app_colores.dart';
import 'package:to_do_app/core/utiles/widgets/custom_field.dart';
import 'package:to_do_app/core/utiles/widgets/custom_text.dart';
import 'package:to_do_app/core/utiles/widgets/tap_effect.dart';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/home/controllers/get_to_do_list/cubit/get_to_do_list_cubit.dart';
import 'package:to_do_app/features/to_do_details/controllers/delete_to_do/cubit/delete_to_do_cubit.dart';
import 'package:to_do_app/features/to_do_details/controllers/update_to_do/cubit/update_to_do_cubit.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';

class DetailsScreen extends StatelessWidget {
  final ToDoModel todo;
  
  const DetailsScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(icon: Icon(Icons.access_time), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.mode_edit_rounded),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                isScrollControlled: true,
                builder: (context) => BlocProvider(
                  create: (context) => UpdateToDoCubit(),
                  child: EditToDoWidet(todo: todo),
                ),
              );
            },
          ),
          
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) {
                  return BlocProvider(
                    create: (context) => DeleteToDoCubit(),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(top: 100),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: DeleteToDoWidget(todo: todo),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    todo.title,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            
           
            
            SizedBox(height: 2.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                   Text(
                    todo.description,
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Created at ${DateFormat('dd MMM yyyy').format(todo.date)}',
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}

class EditToDoWidet extends StatefulWidget {
  final ToDoModel todo;
  
  const EditToDoWidet({super.key, required this.todo});

  @override
  State<EditToDoWidet> createState() => _EditToDoWidetState();
}

class _EditToDoWidetState extends State<EditToDoWidet> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo.title);
    descriptionController = TextEditingController(text: widget.todo.description);
    selectedDate = widget.todo.date;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      decoration: BoxDecoration(
        color: AppColors.lightbink,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SvgPicture.asset('assets/Icons/Rectangle 18.svg')],
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: CustomTextFormField(
              colorx: AppColors.white,
              controller: titleController,
              hint: 'Title',
              maxlienx: 1,
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomTextFormField(
              maxlienx: 14,
              colorx: AppColors.white,
              controller: descriptionController,
              hint: 'Description',
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: EditDateWidget(
              initialDate: selectedDate,
              onDateChanged: (date) {
                selectedDate = date;
              },
            ),
          ),
          SizedBox(height: 2.h),
         
          BlocConsumer<UpdateToDoCubit, UpdateToDoState>(
            listener: (context, state) {
              if (state is UpdateToDoSuccess) {
                Navigator.pop(context);
                Navigator.pop(context);
                context.read<GetToDoListCubit>().getTodoList();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Todo updated successfully!')),
                );
              } else if (state is UpdateToDoFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.error}')),
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                data: state is UpdateToDoLoading ? 'UPDATING...' : 'UPDATE TODO',
                onClick: state is UpdateToDoLoading ? () {} : () {
                  if (titleController.text.isNotEmpty && 
                      descriptionController.text.isNotEmpty) {
                    context.read<UpdateToDoCubit>().updateToDo(
                      widget.todo.id,
                      titleController.text,
                      descriptionController.text,
                      selectedDate ?? DateTime.now(),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

}

class EditDateWidget extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime) onDateChanged;
  
  const EditDateWidget({
    super.key, 
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  State<EditDateWidget> createState() => _EditDateWidgetState();
}

class _EditDateWidgetState extends State<EditDateWidget> {
  late String dateTitle;

  @override
  void initState() {
    super.initState();
    dateTitle = widget.initialDate != null 
        ? DateFormat('dd MMMM yyyy').format(widget.initialDate!)
        : 'Select Date';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(data: dateTitle, color: AppColors.white),
            IconButton(
              onPressed: () async {
                final DateTime? date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  initialDate: widget.initialDate ?? DateTime.now(),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Colors.pink,
                          surface: AppColors.bink,
                          onPrimary: Colors.white,
                          onSurface: Colors.white,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (date != null) {
                  setState(() {
                    dateTitle = DateFormat('dd MMMM yyyy').format(date);
                  });
                  widget.onDateChanged(date);
                }
              },
              icon: Icon(Icons.calendar_today_outlined, color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.data, required this.onClick});

  final String data;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onClick: onClick,
      child: Container(
        width: MediaQuery.of(context).size.width - 5.w,
        height: 6.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: CustomText(
            color: AppColors.bink,
            data: data,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class DeleteToDoWidget extends StatelessWidget {
  final ToDoModel todo;
  
  const DeleteToDoWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Are you sure you want to delete this todo?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  data: 'Cancel',
                  onClick: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: BlocConsumer<DeleteToDoCubit, DeleteToDoState>(
                  listener: (context, state) {
                    if (state is DeleteToDoSuccess) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      context.read<GetToDoListCubit>().getTodoList();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Todo deleted successfully!')),
                      );
                    } else if (state is DeleteToDoFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${state.error}')),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TapEffect(
                        onClick: state is DeleteToDoLoading ? () {} : () {
                          context.read<DeleteToDoCubit>().deleteToDo(todo.id);
                        },
                        child: Center(
                          child: Text(
                            state is DeleteToDoLoading ? 'DELETING...' : 'DELETE',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
