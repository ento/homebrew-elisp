require 'formula'

# References (English):
#   http://howm.sourceforge.jp/index.html

class Howm <Formula
  url 'http://howm.sourceforge.jp/a/howm-1.3.9.1.tar.gz'
  homepage 'http://howm.sourceforge.jp/'
  md5 '61930f92c4ae2a956dc3cf95e60aa91e'

  def install
    @site_lisp_path = "/share/emacs/site-lisp"

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-lispdir=#{prefix}#{@site_lisp_path}"
    system "make install"

    # Get howmdir from Makefile while we're in the sandbox.
    @howm_dir = find_howm_dir
  end

  def caveats; <<-EOS.undent
    Add the following line to your .emacs:

      (require 'howm)

    If you encounter a 'Cannot open load file' error,
    put the following line before the `require` statement:

      (add-to-list 'load-path "#{@howm_dir}")
    EOS
  end

  def find_howm_dir
    dir = find_makefile_variable("howmdir")
    dir.gsub("${lispdir}", "#{HOMEBREW_PREFIX}#{@site_lisp_path}")
  end

  def find_makefile_variable(varname)
    rex = /^#{varname} = (.*)$/
    File.open("Makefile") do |io|
      io.each do |line|
        return $1 if line =~ rex
      end
    end
    nil
  end
end
