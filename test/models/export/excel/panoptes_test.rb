include Java

require_relative '../../../../test/models/model_test_case'
require_relative '../../../../lib/panoptes-xls.jar'

java_import com.omnicrola.panoptes.export.XlsWriterFactory

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
    factory = XlsWriterFactory.build()
  end
end