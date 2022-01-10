import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_state.dart';
import 'package:my_gstore/common/theme/theme_color.dart';

import '../../../injector_container.dart';

class LoadingContainer extends StatelessWidget {
  final Widget? child;

  const LoadingContainer({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          child ?? const SizedBox(),
          BlocBuilder<LoadingBloc, LoadingState>(
            bloc: injector<LoadingBloc>(),
            builder: (context, state) {
              return Visibility(
                visible: state.loading ?? true,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.2),
                  child: const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                      color: AppColors.greenText,
                      strokeWidth: 3,
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
