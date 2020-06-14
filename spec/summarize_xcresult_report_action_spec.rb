describe Fastlane::Actions::SummarizeXcresultReportAction do
  before(:all) do
    require 'scan'
    options = FastlaneCore::Configuration.create(Scan::Options.available_options, {
      project: 'examples/app/app.xcodeproj',
      scheme: 'app',
      derived_data_path: 'examples/app/build',
      output_directory: 'examples/app/fastlane/test_output'
    })
    manager = Scan::Manager.new
    manager.work(options)

    @file = Dir["#{ENV['PWD']}/examples/app/build/**/Logs/Test/*.xcresult"].last
  end

  describe '#summarize_xcresult_report' do
    it 'check type' do
      result = Fastlane::Actions::SummarizeXcresultReportAction.run(
        file: @file
      )
      expect(result).to be_kind_of(Array)
    end

    it 'check row Hash.keys' do
      result = Fastlane::Actions::SummarizeXcresultReportAction.run(
        file: @file
      )
      result.each do |row|
        expect(row.keys).to eq(['target', 'lineCoverage'])
        expect(row['target']).to be_kind_of(String)
        expect(row['lineCoverage']).to be_kind_of(Numeric)
      end
    end
  end

  describe Fastlane::Helper::SummarizeXcresultReportHelper do
    describe '#xcresult_report_json' do
      it 'xccov view --report --json' do
        expect(Fastlane::Helper::SummarizeXcresultReportHelper.xcresult_report_json(@file)).to be_kind_of(Hash)
      end
    end
  end
end
