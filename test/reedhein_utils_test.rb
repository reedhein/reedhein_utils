require 'test_helper'
require 'pry'

class ReedheinUtilsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ReedheinUtils::VERSION
  end

  def test_it_does_something_useful
    assert false
  end

  def test_instantiation
    refute_nil defined? Utils
    refute_nil defined? Utils::Box
    refute_nil defined? Utils::SalesForce
    refute_nil defined? Utils::SMB
    refute_nil defined? Utils::Zoho
    refute_nil defined? VirtualProxy
    refute_nil defined? WorkerPool
    refute_nil defined? BrowserTool
    refute_nil defined? DB
    refute_nil defined? BPImage
  end
end
