require 'formula'

class Darktable < Formula
  homepage 'http://www.darktable.org/'
  url 'http://downloads.sourceforge.net/project/darktable/darktable/1.0/darktable-1.0.5.tar.gz'
  version '1.0.5'
  sha1 'd007ada0f3fb3af6861de74323577b90eec3996e'
  # --HEAD doesn't actually work atm and I don't feel like fixing it
  # head 'git://github.com/darktable-org/darktable.git'

  depends_on 'cmake' => :build
  depends_on 'atk'
  depends_on 'babl'
  depends_on 'gegl'
  depends_on 'exiv2'
  depends_on 'intltool'
  depends_on 'gettext'
  depends_on 'gtk+'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'sqlite'
  depends_on 'openexr'
  depends_on 'libgphoto2'
  depends_on 'dbus'
  depends_on 'fop'
  depends_on 'librsvg'
  depends_on 'flickcurl'
  depends_on 'lensfun'
  depends_on :x11

  def install
    # The default interpolation results in -D_DARWIN_C_SOURCE being
    # incorrectly prepended with a semicolon
    inreplace "CMakeLists.txt" do |s|
      s.gsub! "${CMAKE_C_FLAGS} -D_DARWIN_C_SOURCE",
        "${CMAKE_C_FLAGS}-D_DARWIN_C_SOURCE"
      s.gsub! "${CMAKE_CXX_FLAGS} -D_DARWIN_C_SOURCE",
        "${CMAKE_C_FLAGS}-D_DARWIN_C_SOURCE"
    end

    Dir.mkdir "build"
    cd "build" do
      # yep, cmake returns non-0 for success here
      system "cmake", "..", *std_cmake_args rescue true
      system "make install"
    end
  end
end
