import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

void main() {
  runApp(
    MaterialApp(home: MJPEGStreamViewer(), debugShowCheckedModeBanner: false),
  );
}

class MJPEGStreamViewer extends StatefulWidget {
  @override
  _MJPEGStreamViewerState createState() => _MJPEGStreamViewerState();
}

class _MJPEGStreamViewerState extends State<MJPEGStreamViewer> {
  final String _viewID = 'mjpeg-stream-view';
  late html.ImageElement _imgElement;
  String _streamUrl = ''; // Stream URL'inizi buraya girin

  // Boyut ayarları için değişkenler
  double _width = 640;
  double _height = 480;
  bool _maintainAspectRatio = true;
  String _objectFit = 'contain'; // 'contain', 'cover', 'fill', 'none'

  @override
  void initState() {
    super.initState();
    _initStreamViewer();
  }

  void _initStreamViewer() {
    // MJPEG stream için img elementi
    _imgElement =
        html.ImageElement()
          ..style.width = '${_width}px'
          ..style.height = '${_height}px'
          ..style.objectFit = _objectFit
          ..src = _streamUrl;

    // Flutter UI'da HTML elementini göster
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(_viewID, (int viewId) {
      return _imgElement;
    });
  }

  void updateStreamUrl(String url) {
    setState(() {
      _streamUrl = url;
      _imgElement.src = url;
    });
  }

  void _updateDimensions() {
    _imgElement.style.width = '${_width}px';
    _imgElement.style.height = '${_height}px';
    _imgElement.style.objectFit = _objectFit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MJPEG Stream Görüntüleyici')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: HtmlElementView(viewType: _viewID)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Stream URL',
                    hintText: 'MJPEG stream adresini girin',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        // TextField'daki değeri alıp stream'i güncelle
                        final controller = TextEditingController.fromValue(
                          TextEditingValue(text: _streamUrl),
                        );
                        updateStreamUrl(controller.text);
                      },
                    ),
                  ),
                  onSubmitted: updateStreamUrl,
                  controller: TextEditingController(text: _streamUrl),
                ),
                SizedBox(height: 16),

                // Boyut ayarları
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Genişlik: ${_width.toInt()}px'),
                          Slider(
                            value: _width,
                            min: 160,
                            max: 1920,
                            onChanged: (value) {
                              setState(() {
                                _width = value;
                                if (_maintainAspectRatio) {
                                  _height = _width * 3 / 4; // 4:3 oranı
                                }
                                _updateDimensions();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Yükseklik: ${_height.toInt()}px'),
                          Slider(
                            value: _height,
                            min: 120,
                            max: 1080,
                            onChanged: (value) {
                              setState(() {
                                _height = value;
                                if (_maintainAspectRatio) {
                                  _width = _height * 4 / 3; // 4:3 oranı
                                }
                                _updateDimensions();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Checkbox(
                      value: _maintainAspectRatio,
                      onChanged: (value) {
                        setState(() {
                          _maintainAspectRatio = value!;
                        });
                      },
                    ),
                    Text('Oranı Koru (4:3)'),
                    SizedBox(width: 32),

                    Text('Görüntü Yerleşimi:'),
                    SizedBox(width: 8),
                    DropdownButton<String>(
                      value: _objectFit,
                      items: [
                        DropdownMenuItem(
                          value: 'contain',
                          child: Text('Sığdır'),
                        ),
                        DropdownMenuItem(value: 'cover', child: Text('Kapla')),
                        DropdownMenuItem(value: 'fill', child: Text('Doldur')),
                        DropdownMenuItem(value: 'none', child: Text('Orjinal')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _objectFit = value!;
                          _updateDimensions();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
