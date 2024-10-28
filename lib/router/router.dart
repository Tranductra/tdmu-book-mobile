import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tdmubook/data/guest/trainning_programs/semesters/semesters_data.dart';
import 'package:tdmubook/pages/admin/views/entry_point_admin.dart';
import 'package:tdmubook/pages/auth/views/login_page.dart';
import 'package:tdmubook/pages/auth/views/update_teacher_info_page.dart';
import 'package:tdmubook/pages/auth/views/update_user_info_page.dart';
import 'package:tdmubook/pages/guest/general_information/general_infomation_page.dart';
import 'package:tdmubook/pages/guest/general_information/views/traditional_song_page.dart';
import 'package:tdmubook/pages/guest/guest_page.dart';
import 'package:tdmubook/pages/guest/trainning_programs/credit_system/credit_system_page.dart';
import 'package:tdmubook/pages/guest/trainning_programs/semesters/semesters_page.dart';
import 'package:tdmubook/pages/guest/trainning_programs/training_portal/training_portal_page.dart';
import 'package:tdmubook/pages/guest/trainning_programs/trainning_programs_page.dart';
import 'package:tdmubook/pages/home/views/add_page.dart';
import 'package:tdmubook/pages/home/views/feed_page.dart';
import 'package:tdmubook/pages/home/views/livestream_rooms_page.dart';
import 'package:tdmubook/pages/side_bar/views/entry_point.dart';
import 'package:tdmubook/pages/side_bar/widgets/side_menu.dart';
import 'package:tdmubook/pages/teacher/views/entry_point_teacher.dart';
import 'package:tdmubook/pages/video_call/views/connec_call_page.dart';

import '../main.dart';
import '../pages/guest/education/views/menu_education_page.dart';
import '../pages/guest/education/views/menu_list_continuing_education.dart';
import '../pages/guest/education/views/menu_list_master_training_page.dart';
import '../pages/guest/education/views/menu_undergraduate_page.dart';
import '../pages/guest/notifications/views/guest_notifications_page.dart';
import '../pages/guest/tuition/views/menu_tuition_page.dart';
import '../pages/home/views/connect_livestream_page.dart';
import '../pages/send_notification/views/notification_page.dart';
import '../pages/send_notification/views/send_notification_page.dart';
import '../pages/student/views/entry_point_student.dart';
import '../pages/teacher/views/list_class_page.dart';
import '../pages/teacher/views/view_member_student_page.dart';
import '../pages/video_call/views/video_call_page.dart';
import '../pages/virtual/views/legions_page.dart';
import '../shared/constants/video_call.dart';

GoRouter router = GoRouter(
    navigatorKey: navigatorKey,  // Đặt navigatorKey ở đây
    routes: [
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage();
        // return LoginPage();
      },
      routes: [
        GoRoute(
            path: 'user',
            builder: (BuildContext context, GoRouterState state) {
              return LoginPage();
            },
            routes: [
              GoRoute(
                  path: 'update-user-info',
                  builder: (BuildContext context, GoRouterState state) {
                    return UpdateUserInfoPage();
                  }),
              GoRoute(
                  path: 'update-teacher-info',
                  builder: (BuildContext context, GoRouterState state) {
                    return UpdateTeacherInfoPage();
                  }),
            ]),
        GoRoute(
            path: 'home-student',
            builder: (BuildContext context, GoRouterState state) {
              return EntryPointStudent();
            },
            routes: [
              GoRoute(
                path: 'notification',
                builder: (BuildContext context, GoRouterState state) {
                  return NotificationsPage();
                },
              ),
              GoRoute(
                path: 'live-stream-room',
                builder: (BuildContext context, GoRouterState state) {
                  return LivestreamRoomsPage();
                },
              ),
            ]),
        GoRoute(
          path: 'home-teacher',
          builder: (BuildContext context, GoRouterState state) {
            return EntryPointTeacher();
          },
          routes: [
            GoRoute(
              path: 'view-member-student',
              builder: (BuildContext context, GoRouterState state) {
                return ViewMemberStudentPage();
              },
            ),
            GoRoute(
              path: 'send-notification',
              builder: (BuildContext context, GoRouterState state) {
                return SendNotificationPage();
              },
            ),
            GoRoute(
              path: 'list-class',
              builder: (BuildContext context, GoRouterState state) {
                return ListClassPage();
              },
            ),

            GoRoute(
              path: 'live-stream-room',
              builder: (BuildContext context, GoRouterState state) {
                return LivestreamRoomsPage();
              },
            ),
          ],
        ),
        GoRoute(
            path: 'home-admin',
            builder: (BuildContext context, GoRouterState state) {
              return EntryPointAdmin();
            }),
        GoRoute(
          path: 'guest',
          builder: (BuildContext context, GoRouterState state) {
            return GuestPage();
          },
          routes: [
            GoRoute(
                path: 'general-information',
                builder: (BuildContext context, GoRouterState state) {
                  return GeneralInformationPage();
                },
                routes: [
                  GoRoute(
                      path: 'traditional-song',
                      builder: (BuildContext context, GoRouterState state) {
                        return TraditionalSongPage();
                      }),
                ]),
            GoRoute(
              path: 'training-programs',
              builder: (BuildContext context, GoRouterState state) {
                return TrainingProgramsPage();
              },
              routes: [
                GoRoute(
                    path: 'credit-system',
                    builder: (BuildContext context, GoRouterState state) {
                      return CreditSystemPage();
                    }),
                GoRoute(
                    path: 'training-portal',
                    builder: (BuildContext context, GoRouterState state) {
                      return TrainingPortalPage();
                    }),
                GoRoute(
                    path: 'semesters',
                    builder: (BuildContext context, GoRouterState state) {
                      return SemestersPage();
                    }),
              ],
            ),
            GoRoute(
                path: 'education',
                builder: (BuildContext context, GoRouterState state) {
                  return MenuEducationPage();
                },
                routes: [
                  GoRoute(
                    path: 'undergraduate',
                    builder: (BuildContext context, GoRouterState state) {
                      return MenuUndergraduatePage();
                    },
                  ),
                  GoRoute(
                    path: 'master-training',
                    builder: (BuildContext context, GoRouterState state) {
                      return MenuListMasterTrainingPage();
                    },
                  ),
                  GoRoute(
                    path: 'continuing-education',
                    builder: (BuildContext context, GoRouterState state) {
                      return MenuListContinuingEducation();
                    },
                  ),
                ]),
            GoRoute(
                path: 'tuition',
                builder: (BuildContext context, GoRouterState state) {
                  return MenuTuitionPage();
                }),
            GoRoute(
                path: 'virtual',
                builder: (BuildContext context, GoRouterState state) {
                  return RegionsPage();
                }),
            GoRoute(
                path: 'notifications',
                builder: (BuildContext context, GoRouterState state) {
                  return GuestNotificationsPage();
                }),

          ],
        ),
      ])
]);
