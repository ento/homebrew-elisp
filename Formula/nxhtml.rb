require 'formula'

class Nxhtml < Formula
  url 'http://ourcomments.org/Emacs/DL/elisp/nxhtml/zip/nxhtml-2.08-100425.zip'
  homepage 'http://ourcomments.org/Emacs/nXhtml/doc/nxhtml.html'
  md5 '26bfe125c38801246aeb64df00541efa'

  def install
    @nxhtml_path = "share/emacs/nxhtml"
    nxhtml_dir = prefix + @nxhtml_path
    nxhtml_dir.install Dir['*']
  end

  def caveats; <<-EOS.undent
    To activate nXhtml put this in your .emacs:

    (load "#{HOMEBREW_PREFIX}/#{@nxhtml_path}/autostart.el")

    Note 1: If you are using Emacs+EmacsW32 then nXhtml is already
            installed.
    
    Note 2: If you are using Emacs 22 then you need to install nXml
            separately. (It is included in Emacs 23.)
    
    Note 3: You may optionally also byte compile nXhtml from the nXhtml
            menu (recommended).
    EOS
  end
end
