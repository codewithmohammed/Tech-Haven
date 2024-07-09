import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/data/model/help_request_model.dart';
import 'package:tech_haven/core/common/widgets/custom_app_bar.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/user/features/help%20center/presentation/bloc/help_center_bloc.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  void deactivate() {
    emailController;
    nameController;
    subjectController;
    bodyController;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    context.read<HelpCenterBloc>().add(GetAllUserRequestEvent());
    context.read<HelpCenterBloc>().add(GetUserDataEvent());
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Help Center',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BlocConsumer<HelpCenterBloc, HelpCenterState>(
                listener: (context, state) {
                  if (state is GetUserDataSuccess) {
                    emailController.text = state.user.email!;
                    nameController.text = state.user.username!;
                  }
                  if (state is RequestSendHelpCenterSuccess) {
                    emailController.clear();
                    nameController.clear();
                    subjectController.clear();
                    bodyController.clear();
                    Fluttertoast.showToast(msg: 'Request sent successfully');
                    context.read<HelpCenterBloc>().add(GetUserDataEvent());
                    context
                        .read<HelpCenterBloc>()
                        .add(GetAllUserRequestEvent());
                  } else if (state is RequestSendHelpCenterError) {
                    Fluttertoast.showToast(msg: state.message);
                    GoRouter.of(context).pop();
                  }
                },
                buildWhen: (previous, current) => current is SendRequestState,
                builder: (context, state) {
                  return Column(
                    children: [
                      TextField(
                        enabled: false,
                        controller: emailController,
                        decoration: const InputDecoration(labelText: 'From'),
                      ),
                      TextField(
                        enabled: false,
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),
                      TextField(
                        controller: subjectController,
                        decoration: const InputDecoration(labelText: 'Subject'),
                      ),
                      TextField(
                        controller: bodyController,
                        decoration: const InputDecoration(labelText: 'Body'),
                        maxLines: 5,
                      ),
                      const SizedBox(height: 16.0),
                      if (state is HelpCenterLoading)
                        const CircularProgressIndicator()
                      else
                        PrimaryAppButton(
                          onPressed: () {
                            final helpRequest = HelpRequestModel(
                              userID: '',
                              email: emailController.text,
                              dateTime: DateTime.now(),
                              name: nameController.text,
                              subject: subjectController.text,
                              body: bodyController.text,
                              answer: null,
                              requestID: '',
                            );

                            context.read<HelpCenterBloc>().add(
                                  SendHelpRequestEvent(
                                    userName: nameController.text,
                                    helpRequest: helpRequest,
                                  ),
                                );
                          },
                          buttonText: 'Send Request',
                        ),
                    ],
                  );
                },
              ),
              BlocBuilder<HelpCenterBloc, HelpCenterState>(
                buildWhen: (previous, current) =>
                    current is GetAllUserRequestState,
                builder: (context, state) {
                  if (state is GetAllUserRequestSuccessState) {
                    if (state.listOfHelpRequest.isNotEmpty) {
                      return Accordion(
                        disableScrolling: true,
                        maxOpenSections: 1,
                        headerBackgroundColorOpened: Colors.blue,
                        openAndCloseAnimation: true,
                        headerPadding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 15),
                        // sectionOpeningHapticFeedback: SectionHapticFeedback.light,
                        children: state.listOfHelpRequest.map((helpRequest) {
                          return AccordionSection(
                            isOpen: false,
                            header: Text(helpRequest.subject),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('Request ID: ${helpRequest.requestID}'),
                                Text('Email: ${helpRequest.email}'),
                                Text('Name: ${helpRequest.name}'),
                                Text(
                                    'Date: ${formatDateTime(helpRequest.dateTime)}'),
                                Text('Subject: ${helpRequest.subject}'),
                                Text('Body: ${helpRequest.body}'),
                                (helpRequest.answer != null)
                                    ? Text('Answer: ${helpRequest.answer}')
                                    : const Text(
                                        'Answer: Still Pending To answer by the Admin'),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return const Center(
                        child: Text("You don't have any request so far"),
                      );
                    }
                  } else if (state is GetAllUserRequestFailedState) {
                    return Text(state.message);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
