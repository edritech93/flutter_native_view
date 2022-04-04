import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class NativeViewExample extends StatefulWidget {
  const NativeViewExample({Key? key}) : super(key: key);

  @override
  State<NativeViewExample> createState() => _NativeViewExampleState();
}

class _NativeViewExampleState extends State<NativeViewExample> {
  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return PlatformViewLink(
          viewType: viewType,
          surfaceFactory:
              (BuildContext context, PlatformViewController controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <
                  Factory<OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (PlatformViewCreationParams params) {
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: () {
                params.onFocusChanged(true);
              },
            )
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..create();
          },
        );

      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );

      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }

  // Widget build(BuildContext context) {
  //   // This is used in the platform side to register the view.
  //   const String viewType = '<platform-view-type>';
  //   // Pass parameters to the platform side.
  //   final Map<String, dynamic> creationParams = <String, dynamic>{};

  //   return UiKitView(
  //     viewType: viewType,
  //     layoutDirection: TextDirection.ltr,
  //     creationParams: creationParams,
  //     creationParamsCodec: const StandardMessageCodec(),
  //   );
  // }

  // Widget build(BuildContext context) {
  //   // This is used in the platform side to register the view.
  //   const String viewType = '<platform-view-type>';
  //   // Pass parameters to the platform side.
  //   const Map<String, dynamic> creationParams = <String, dynamic>{};

  //   return PlatformViewLink(
  //     viewType: viewType,
  //     surfaceFactory:
  //         (BuildContext context, PlatformViewController controller) {
  //       return AndroidViewSurface(
  //         controller: controller as AndroidViewController,
  //         gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
  //         hitTestBehavior: PlatformViewHitTestBehavior.opaque,
  //       );
  //     },
  //     onCreatePlatformView: (PlatformViewCreationParams params) {
  //       return PlatformViewsService.initSurfaceAndroidView(
  //         id: params.id,
  //         viewType: viewType,
  //         layoutDirection: TextDirection.ltr,
  //         creationParams: creationParams,
  //         creationParamsCodec: const StandardMessageCodec(),
  //         onFocus: () {
  //           params.onFocusChanged(true);
  //         },
  //       )
  //         ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
  //         ..create();
  //     },
  //   );
  // }
}
