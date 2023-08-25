import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/marsella_themedata.dart';
import '../../../core/widgets/marsella_widgets.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../bloc/notconnection_bloc.dart';
import '../bloc/notconnection_event.dart';
import '../bloc/notconnection_state.dart';

class NotConnectionPage extends StatelessWidget {
  const NotConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotConnectionBloc, NotConnectionState>(listener: (context, state) {
      if (state is NotConnectionError && state.message != "") {
        snackBarNotify(context, state.message, Icons.cancel_outlined);
      }
    }, child: BlocBuilder<NotConnectionBloc, NotConnectionState>(
      builder: (context, state) {
        return _bodyNotConnections(context, state);
      },
    ));
  }

  Widget _bodyNotConnections(BuildContext context, NotConnectionState state) {
    final shThemeData = MarsellaTheme.of(context);
    return Container(
      child: Column(
        children: [
          //const MarsellaPageTitle(text: 'No hay conexión'),
          const SizedBox(height: 20),
          BlocBuilder<NotConnectionBloc, NotConnectionState>(builder: (context, state) {
            if (state is NotConnectionStart) {
              context.read<NotConnectionBloc>().add(const OnNotConnectionInternet());
            }
            if (state is NotConnectionLoading) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                  child: MarsellaCircularIndicator(
                    size: MarsellaCircularSize.normal,
                  ),
                ),
              );
            }
            /*if (state is NotConnectionError) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                  child: MarsellaCircularIndicator(
                    size: MarsellaCircularSize.normal,
                  ),
                ),
              );
            }*/
            if (state is NotConnectionInternet) {
              return Column(
                children: [
                  const SizedBox(height: 50,),
                  const Icon(Icons.do_disturb, size: 100,),
                  Text('No se pudo cargar el contenido. Porfavor revisa tu conexión a internet', ),
                ],
              );
            }
            return const SizedBox();
          }),
        ],
      ),
    );
  }
}