import 'package:flutter/material.dart';
import 'package:mentor_app/screens/web_view/web_view_bloc.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final _bloc = WebViewBloc();

  @override
  void didChangeDependencies() {
    _bloc.extractArguments(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: _bloc.pageTitle),
      body: ValueListenableBuilder<LoadingStatus>(
          valueListenable: _bloc.loadingStatus,
          builder: (context, loadingsnapshot, child) {
            if (loadingsnapshot == LoadingStatus.finish) {
              return WebView(
                initialUrl: _bloc.webViewUrl,
                javascriptMode: JavascriptMode.unrestricted,
                debuggingEnabled: true,
                gestureNavigationEnabled: true,
                navigationDelegate: (NavigationRequest request) {
                  return NavigationDecision.navigate;
                },
                onWebViewCreated: (WebViewController webViewController) {
                  _bloc.webViewController = webViewController;
                  _bloc.webViewController!.loadUrl(_bloc.webViewUrl);
                },
              );
            } else {
              return const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              );
            }
          }),
    );
  }
}
