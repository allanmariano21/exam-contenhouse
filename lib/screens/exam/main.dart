import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as base;
import 'package:mobile_exam/core/app/view.dart' as view;
import 'package:mobile_exam/core/services/server.dart';
import 'package:mobile_exam/models/data_model.dart';
import 'package:mobile_exam/screens/exam/data_bloc.dart';
import 'package:mobile_exam/screens/exam/data_events.dart';
import 'package:mobile_exam/screens/exam/data_repository.dart';
import 'package:mobile_exam/screens/exam/data_state.dart';

import 'bloc.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  Bloc? _bloc;

  @override
  void dispose() {
    _bloc?.close().then((b) => b.dispose());
    _bloc = null; // remove reference
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _bloc ?? (_bloc = Bloc(context)),
      builder: (context, _) {
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     context.server.addToCount(1);
            //   },
            //   tooltip: 'Increment',
            //   child: Icon(Icons.add),
            // ),
            appBar: AppBar(
              title: Text(context.strings!.homeExamButtonLabel),
            ),
            body: SingleChildScrollView(
              child: base.RepositoryProvider(
                create: (context) => DataRepository(),
                child: base.BlocProvider(
                  create: (context) => DataBloc(
                      base.RepositoryProvider.of<DataRepository>(context),
                      context)
                    ..add(LoadDataEvent()),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: base.BlocBuilder<DataBloc, DataState>(
                          builder: (context, state) {
                        if (state is DataLoadingState) {
                          return Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height,
                            child: const CircularProgressIndicator(),
                          );
                        }

                        if (state is DataLoadedState) {
                          DataModel dataResult = state.data;
                          if (dataResult.statusCode == 200) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      color: const Color(0xFFf0f4fa),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Data Message',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF616161),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              dataResult.message,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF616161),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    color: const Color(0xFFf0f4fa),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 300,
                                        width: 300,
                                        child: Image.network(
                                          dataResult.image,
                                          fit: BoxFit.fill,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return Text(
                                              '${exception.toString()} ${stackTrace.toString()}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF616161),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CircleAvatar(
                                    backgroundColor: const Color(0xFFf0f4fa),
                                    child: Text(
                                      dataResult.count.toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF616161),
                                          fontWeight: FontWeight.bold),
                                    )),
                                const SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xFFf0f4fa)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await context.server.addToCount(1);
                                    if (mounted) {
                                      context
                                          .read<DataBloc>()
                                          .add(LoadDataEvent());
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Add Count',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Color(0xFF616161),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            );
                          } else {
                            context.server.addToCount(-1);

                            return Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height,
                              child: Column(children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  color: const Color(0xFFf0f4fa),
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      dataResult.errorMessage,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xFFf0f4fa)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await context.server.addToCount(1);
                                    if (mounted) {
                                      context
                                          .read<DataBloc>()
                                          .add(LoadDataEvent());
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Add Count',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Color(0xFF616161),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            );
                          }
                        }
                        if (state is DataErrorState) {
                          context.server.addToCount(-1);
                          return Center(child: Text(state.error));
                        }

                        return Container();
                      })),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
