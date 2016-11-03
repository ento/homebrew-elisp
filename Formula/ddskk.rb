require 'formula'

class Ddskk <Formula
  url 'http://openlab.ring.gr.jp/skk/maintrunk/ddskk-14.3.tar.gz'
  homepage 'http://openlab.ring.gr.jp/skk/index-j.html'
  sha256 '8e8d8b3d3de0dea664bf252b79e3c739b4a48addb57de61ce7c4cb0133694c39'

  depends_on 'apel'

  def caveats
    s = ""
    s += <<-EOS.undent
    Add the following to your .emacs file:

    (add-to-list 'load-path "#{@install_dir}")
    (require 'skk-autoloads)

    EOS

    if !ARGV.include? "--skk-set-jisyo"
      s += <<-EOS.undent
      You choosed not to set skk-large-jisyo automatically.
      Which means you need to connect to a skkserv like below:

      (setq skk-server-host "localhost")
      (setq skk-server-portnum 1178)
      (setq skk-share-private-jisyo t)
      (setq skk-jisyo-code 'utf-8-unix)
      EOS
    end
  end
  
  def options
    [
      ["--skk-set-jisyo", "Automatically set skk-large-jisyo"],
    ]
  end

  def install
    @site_lisp_path = "/share/emacs/site-lisp"
    @install_dir = "#{HOMEBREW_PREFIX}#{@site_lisp_path}/skk"

    open("SKK-CFG", 'a'){|f|
      f.puts(<<DATA
(setq APEL_DIR "#{HOMEBREW_PREFIX}/share/emacs/site-lisp/apel")
(setq EMU_DIR "#{HOMEBREW_PREFIX}/share/emacs/site-lisp/emu")
(setq SKK_DATADIR "#{HOMEBREW_PREFIX}/share/skk")
(setq SKK_INFODIR "#{HOMEBREW_PREFIX}/info")
(setq SKK_LISPDIR "#{HOMEBREW_PREFIX}/share/emacs/site-lisp/skk")
DATA
             )
      f.puts(<<DATA
(setq SKK_SET_JISYO t)
DATA
             ) if ARGV.include? "--skk-set-jisyo"
    }

    system "make"
    system "make install"
  end
end
