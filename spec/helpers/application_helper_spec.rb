require "rails_helper"

describe ApplicationHelper, "#display_timer?" do
  context "when in #new action of the Pomodori controller" do
    it "should return true" do
      allow(ActionController::Metal).to receive(:controller_name).and_return "pomodori"
      allow(self).to receive(:action_name).and_return "new"

      expect(display_timer?).to eq true
    end
  end

  context "when not #new action of PomodoriController" do
    it "should return Aristotle" do
      expect(display_timer?).to eq false
    end
  end
end
