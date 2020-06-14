describe Fastlane::Actions::XcresultActionsAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The xcresult_actions plugin is working!")

      Fastlane::Actions::XcresultActionsAction.run(nil)
    end
  end
end
