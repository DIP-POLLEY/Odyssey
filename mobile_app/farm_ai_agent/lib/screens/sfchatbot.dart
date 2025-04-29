import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SalesforceChatWidget extends StatefulWidget {
  static const String id = 'sfchatbot';
  const SalesforceChatWidget({super.key});

  @override
  State<SalesforceChatWidget> createState() => _SalesforceChatWidgetState();
}

class _SalesforceChatWidgetState extends State<SalesforceChatWidget> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(_buildHtml());
  }

  String _buildHtml() {
    return '''
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <title>Salesforce Chat</title>
    </head>
    <body>
      <script type="text/javascript">
        function initEmbeddedMessaging() {
          try {
            embeddedservice_bootstrap.settings.language = 'en_US';

            embeddedservice_bootstrap.init(
              '00DNS00000IdCmv',
              'Farm_AI_Agent',
              'https://orgfarm-069efd2b82.my.site.com/ESWFarmAIAgent1745928444473',
              {
                scrt2URL: 'https://orgfarm-069efd2b82.my.salesforce-scrt.com'
              }
            );
          } catch (err) {
            console.error('Error loading Embedded Messaging: ', err);
          }
        };
      </script>
      <script type="text/javascript"
              src="https://orgfarm-069efd2b82.my.site.com/ESWFarmAIAgent1745928444473/assets/js/bootstrap.min.js"
              onload="initEmbeddedMessaging()">
      </script>
    </body>
    </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Support')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
