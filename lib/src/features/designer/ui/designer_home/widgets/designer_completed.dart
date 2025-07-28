import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../res/colors/app_colors.dart';
import '../../../../../res/components/common_toast.dart';
import '../bloc/designer_home_bloc.dart';
import 'meeting_card.dart';

class DesignerCompleted extends StatefulWidget {
  const DesignerCompleted({super.key});

  @override
  State<DesignerCompleted> createState() => _DesignerCompletedState();
}

class _DesignerCompletedState extends State<DesignerCompleted> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final bloc = DesignerHomeBloc();

  @override
  void initState() {
    super.initState();
    bloc.add(FetchAppointments('completed'));
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.85,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Today',
                    style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            BlocConsumer<DesignerHomeBloc, DesignerHomeState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    );
                  } else if (state is AppointmentLoaded) {
                    if (bloc.appointments!.isEmpty) {
                      return const CommonEmpty(title: 'Appointments');
                    } else {
                      return SizedBox(
                        height: screenHeight * 0.75,
                        child: SmartRefresher(
                          controller: _refreshController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          enablePullDown: true,
                          enablePullUp: true,
                          onRefresh: () {
                            bloc.add(FetchAppointments('completed'));
                            _refreshController.refreshCompleted();
                          },
                          onLoading: () {
                            bloc.add(LoadMoreAppointments('completed'));
                            if (bloc.currentPage >= bloc.totalPages) {
                              _refreshController.loadNoData();
                            } else {
                              _refreshController.loadComplete();
                            }
                          },
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: bloc.appointments!.length,
                              padding: const EdgeInsets.only(bottom: 16),
                              itemBuilder: (BuildContext context, int index) {
                                final data = bloc.appointments![index];
                                return  MeetingCard(
                                  id: data.appointmentId,
                                  image: '${data.profileImage??''}',
                                  name: '${data.username??''}',
                                  location: '${data.username??''}',
                                  date: '${data.date??''}',
                                  time: '${data.time??''}',
                                  type: 2,
                                );
                              }),
                        ),
                      );
                    }
                  } else {
                    return const CommonEmpty(title: 'Appointments');
                  }
                },
                listener: (BuildContext context, DesignerHomeState state) {}),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
