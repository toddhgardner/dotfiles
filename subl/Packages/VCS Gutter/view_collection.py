import tempfile
import time

import sublime

try:
    from .vcs_helpers import GitHelper, HgHelper, SvnHelper
except ValueError:
    from vcs_helpers import GitHelper, HgHelper, SvnHelper


class ViewCollection:
    views = {}
    vcs_times = {}
    vcs_files = {}
    buf_files = {}

    @staticmethod
    def add(view):
        try:
            from .gutter_handlers import GitGutterHandler, HgGutterHandler, SvnGutterHandler
        except ValueError:
            from gutter_handlers import GitGutterHandler, HgGutterHandler, SvnGutterHandler

        settings = sublime.load_settings('VcsGutter.sublime-settings')
        vcs_paths = settings.get('vcs_paths', {
            'git': 'git',
            'hg': 'hg',
            'svn': 'svn'
        })

        key = None
        if GitHelper.is_git_repository(view):
            key = 'git'
            klass = GitGutterHandler
        elif HgHelper.is_hg_repository(view):
            key = 'hg'
            klass = HgGutterHandler
        elif SvnHelper.is_svn_repository(view):
            key = 'svn'
            klass = SvnGutterHandler

        handler = None
        if key is not None:
            try:
                path = vcs_paths[key]
            except (KeyError, TypeError):
                print('Vcs Gutter: Invalid path for %s executable in settings. Using default.' % key)
                path = key
            handler = klass(view, path)

        # If no handler found then either the view does not represent a
        # file on disk (e.g. not yet saved) or the file is not in a supported
        # VCS repository.
        if handler is not None:
            key = ViewCollection.get_key(view)
            ViewCollection.views[key] = handler
            ViewCollection.views[key].reset()

    @staticmethod
    def vcs_path(view):
        key = ViewCollection.get_key(view)
        if key in ViewCollection.views:
            return ViewCollection.views[key].get_vcs_path()
        else:
            return False

    @staticmethod
    def get_key(view):
        return view.file_name()

    @staticmethod
    def diff(view):
        key = ViewCollection.get_key(view)
        try:
            result = ViewCollection.views[key].diff()
        except KeyError:
            result = ([], [], [])

        return result

    @staticmethod
    def vcs_time(view):
        key = ViewCollection.get_key(view)
        if not key in ViewCollection.vcs_times:
            ViewCollection.vcs_times[key] = 0
        return time.time() - ViewCollection.vcs_times[key]

    @staticmethod
    def update_vcs_time(view):
        key = ViewCollection.get_key(view)
        ViewCollection.vcs_times[key] = time.time()

    @staticmethod
    def vcs_tmp_file(view):
        key = ViewCollection.get_key(view)
        if not key in ViewCollection.vcs_files:
            ViewCollection.vcs_files[key] = tempfile.NamedTemporaryFile()
            ViewCollection.vcs_files[key].close()
        return ViewCollection.vcs_files[key]

    @staticmethod
    def buf_tmp_file(view):
        key = ViewCollection.get_key(view)
        if not key in ViewCollection.buf_files:
            ViewCollection.buf_files[key] = tempfile.NamedTemporaryFile()
            ViewCollection.buf_files[key].close()
        return ViewCollection.buf_files[key]
