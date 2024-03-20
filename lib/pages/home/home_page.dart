import 'package:cool_transaction/blocs/auth/login/login_bloc.dart';
import 'package:cool_transaction/blocs/home/home_bloc.dart';
import 'package:cool_transaction/blocs/home/home_event.dart';
import 'package:cool_transaction/blocs/home/home_state.dart';
import 'package:cool_transaction/models/transaction.dart';
import 'package:cool_transaction/pages/auth/login_page.dart';
import 'package:cool_transaction/pages/payment/add_payment_page.dart';
import 'package:cool_transaction/pages/payment/scan_payment_page.dart';
import 'package:cool_transaction/pages/transaction/transaction_history.dart';
import 'package:cool_transaction/widget/transaction_widget/info_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeLoadedEvent()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5465FF),
        toolbarHeight: 0,
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLogoutState) {
            _showLogoutConfirmationDialog(context);
          }

          if (state is HomeLoginExpiredState) {
            _loginExpired(context);
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitialState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeLoadedState) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  SafeArea(
                    child: Container(
                      width: double.infinity,
                      height: 350,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5465FF),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 36,
                                ),
                                onPressed: () {
                                  _showLogoutConfirmationDialog(context);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'WELCOME BACK, \n${state.username}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          const CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              size: 48,
                              color: Color(0xFF5465FF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -40,
                    child: FractionallySizedBox(
                      widthFactor: 0.85,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ScanPaymentPage(),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.payment_rounded,
                                            color: Color(0xFF5465FF),
                                            size: 32,
                                          ),
                                          Text(
                                            'Make\nPayment',
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AddPaymentPage(),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: Color(0xFF5465FF),
                                            size: 36,
                                          ),
                                          Text(
                                            'Add\nPayment',
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const TransactionHistoryPage(),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.history,
                                            color: Color(0xFF5465FF),
                                            size: 32,
                                          ),
                                          Text(
                                            'View\nTransactions',
                                            textAlign: TextAlign.center,
                                            softWrap: false,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -360,
                    child: Container(
                      height: 275, // Adjust height as needed
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      margin: EdgeInsets.symmetric(
                          horizontal: 20), // Add horizontal margin
                      decoration: BoxDecoration(
                        color: const Color(0xFF5465FF), // Background color
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                     child: Center(
                        child: ListView(
                          children: [
                            InfoTile('Current Credit:' ,'100',null),
                            InfoTile('Active Payment:' ,'1',null),
                            InfoTile('Cooling Amount:' ,'100',null),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(LogoutButtonPressed());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loginExpired(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}


//receiver create payment
//payer enter payment id
//payer will make transaction based on payment

