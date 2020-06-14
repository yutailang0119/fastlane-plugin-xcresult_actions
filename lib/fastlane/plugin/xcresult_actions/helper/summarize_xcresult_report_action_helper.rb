require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class SummarizeXcresultReportHelper
      def self.xcresult_report_json(file)
        require 'open3'
        require 'json'

        UI.header('xccov view --report')

        UI.command('xcrun xccov view --report #{file} --json')
        stdout, stderr, = Open3.capture3('xcrun', 'xccov', 'view', '--report', file.to_s, '--json')

        UI.command_output("stderr: #{stderr}")

        JSON.parse(stdout)
      end
    end
  end
end
