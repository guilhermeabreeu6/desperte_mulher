import 'package:web/web.dart' as web;

void quickExit() {
  // Clear page title so it doesn't appear in browser history previews
  web.document.title = 'Google';
  // Replace current history entry — back button won't return to the app
  web.window.history.replaceState(null, '', '/');
  // Redirect without adding a new history entry
  web.window.location.replace('https://www.google.com.br');
}
