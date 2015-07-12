require "rails_helper"

describe ApplicationHelper, "#timer_display" do
  context "when in #new action of the Pomodori controller" do
    it "should return {{ time }}" do
      allow(ActionController::Metal).to receive(:controller_name).and_return "pomodori"
      allow(self).to receive(:action_name).and_return "new"

      expect(timer_display).to eq "{{ time }}"
    end
  end

  context "when not #new action of PomodoriController" do
    it "should return Aristotle" do
      expect(timer_display).to eq "Aristotle"
    end
  end
end
