require 'java'
require_relative '../../../../lib/Panoptes.jar'
# $CLASSPATH << '../../../../lib'

# include_class 'com.omnicrola.panoptes.control.TimeblockSet'

# TimeblockSet = JavaUtilities.get_proxy_class('com.omnicrola.panoptes.Panoptes')

# java_import com.omnicrola.panoptes.control.TimeblockSet

class PanoptesTest < ModelTestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_fail
    factory = TimeblockSet.new()
    assert_not_nil(factory)
    fail('shit didnt work')
  end
end