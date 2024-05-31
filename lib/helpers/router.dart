import 'package:go_router/go_router.dart';
import 'package:kelpet/pages/account/forget.dart';
import 'package:kelpet/pages/account/login.dart';
import 'package:kelpet/pages/account/register.dart';
import 'package:kelpet/pages/account_settings.dart';
import 'package:kelpet/pages/add_pet.dart';
import 'package:kelpet/pages/dashboard.dart';
import 'package:kelpet/pages/health_tips.dart';
import 'package:kelpet/pages/map.dart';
import 'package:kelpet/pages/notification.dart';
import 'package:kelpet/pages/pet_location.dart';
import 'package:kelpet/pages/pet_update.dart';

final GoRouter router = GoRouter(initialLocation: "/", routes: [
GoRoute(path: '/', builder: (context, state) => const Login()),
GoRoute(path: '/register', builder: (context, state) => const Register()),
GoRoute(path: '/dashboard', builder: (context, state) => const Dashboard()),
GoRoute(path: '/add_pet', builder: (context, state) => const AddNewPet()),
GoRoute(path: '/health_tips', builder: (context, state) => HealthTips()),
GoRoute(path: '/notification', builder: (context, state) => const AllNotifications()),
GoRoute(path: '/pet_location', builder: (context, state) => const PetLocation()),
GoRoute(path: '/pet_update', builder: (context, state) => const ManagePets()),
GoRoute(path: '/account_settings', builder: (context, state) => const AccountSettings()),
GoRoute(path: '/map', builder: (context, state) => const MapOfVeterinarian()),
GoRoute(path: '/forget_password', builder: (context, state) => const ForgetPassword()),

]);