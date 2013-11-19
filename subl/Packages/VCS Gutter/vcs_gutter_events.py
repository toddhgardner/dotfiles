import sublime
import sublime_plugin

try:
    from .view_collection import ViewCollection
except ValueError:
    from view_collection import ViewCollection


def plugin_loaded():
    global _live_mode, _non_blocking
    settings = sublime.load_settings('VcsGutter.sublime-settings')
    _live_mode = settings.get('live_mode')
    _non_blocking = settings.get('non_blocking')

_live_mode = True
_non_blocking = False


class VcsGutterEvents(sublime_plugin.EventListener):
    def __init__(self):
        self.load_settings()

    # Settings

    def load_settings(self):
        # This works in ST 2 as the API is active when the plugin is loading.
        # For ST 3, the API is active only when the module function plugin_loaded is
        # called. We can tell the difference by testing the returned setting value
        # for None.
        settings = sublime.load_settings('VcsGutter.sublime-settings')
        result = settings.get('live_mode')
        global _live_mode, _non_blocking
        if result is not None:
            # We're running under ST 2. For ST 3, settings are read in plugin_loaded() above.
            _live_mode = result
            _non_blocking = settings.get('non_blocking')

    # Synchronous

    def on_modified(self, view):
        if not _live_mode:
            return None

        if not _non_blocking:
            ViewCollection.add(view)

    def on_clone(self, view):
        if not _non_blocking:
            ViewCollection.add(view)

    def on_post_save(self, view):
        if not _non_blocking:
            ViewCollection.add(view)

    def on_load(self, view):
        if not _non_blocking and not _live_mode:
            ViewCollection.add(view)

    def on_activated(self, view):
        if not _live_mode:
            return None

        ViewCollection.add(view)

    # Asynchronous

    def on_modified_async(self, view):
        if not _live_mode:
            return None
        if _non_blocking:
            ViewCollection.add(view)

    def on_clone_async(self, view):
        if _non_blocking:
            ViewCollection.add(view)

    def on_post_save_async(self, view):
        if _non_blocking:
            ViewCollection.add(view)

    def on_load_async(self, view):
        if _non_blocking and not _live_mode:
            ViewCollection.add(view)

    def on_activated_async(self, view):
        if not _live_mode:
            return None

        if _non_blocking:
            ViewCollection.add(view)
