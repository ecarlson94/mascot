// @JS()
// library static_interop;

// import 'dart:typed_data';

// import 'package:injectable/injectable.dart';
// import 'package:js/js.dart';
// import 'package:js/js_util.dart';
// import 'package:universal_html/html.dart' as html;

// @JS('HTMLVideoElement')
// @staticInterop
// class JSVideoElement {
//   external factory JSVideoElement();
// }

// extension JSVideoElementExtension on JSVideoElement {
//   external dynamic play();
//   external html.MediaStream? get srcObject;
//   external set srcObject(html.MediaStream? stream);
//   external int get videoWidth;
//   external int get videoHeight;
// }

// @JS('HTMLCanvasElement')
// @staticInterop
// class JSCanvasElement {
//   external factory JSCanvasElement();
// }

// extension JSCanvasElementExtension on JSCanvasElement {
//   external html.CanvasRenderingContext2D get context;
// }

// @JS()
// @staticInterop
// class MediaStreamConstraints {
//   external factory MediaStreamConstraints({
//     bool audio = false,
//     dynamic video,
//   });
// }

// @JS('navigator.mediaDevices.getUserMedia')
// external dynamic getUserMedia(
//   // Change the return type to dynamic
//   MediaStreamConstraints constraints,
// );

// @lazySingleton
// class VideoContext {
//   final JSVideoElement _jsVideoElement;
//   final JSCanvasElement _jsCanvasElement;
//   final html.CanvasRenderingContext2D _context;

//   VideoContext()
//       : _jsVideoElement = JSVideoElement(),
//         _jsCanvasElement = JSCanvasElement(),
//         _context = JSCanvasElement().context {
//     promiseToFuture(
//       getUserMedia(MediaStreamConstraints(video: true)),
//     ).then((stream) {
//       _jsVideoElement.srcObject = stream;
//       promiseToFuture(_jsVideoElement.play());
//     });
//   }

//   Uint8List getFrame() {
//     final width = _jsVideoElement.videoWidth;
//     final height = _jsVideoElement.videoHeight;

//     _context.drawImageScaled(_jsVideoElement, 0, 0, width, height);

//     final imageData = _context.getImageData(0, 0, width, height);
//     return Uint8List.fromList(imageData.data);
//   }

//   @disposeMethod
//   void dispose() {
//     _jsVideoElement.srcObject?.getTracks()?.forEach((track) {
//       track.stop();
//     });
//   }
// }
