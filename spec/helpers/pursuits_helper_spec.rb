require 'rails_helper'

describe PursuitsHelper, '#convert_total_seconds_of' do
  context 'when hours are greater than 10' do
    it 'should convert to the %h:%m:%s format' do
      time = convert_total_seconds_of(90000)
      expect(time).to eq '25:00:00'
    end
  end

  context 'when hours are less than 10' do
    it 'should convert to the %h:%m:%s format' do
      time = convert_total_seconds_of(31768)
      expect(time).to eq '08:49:28'
    end
  end

  context 'when minutes are greater than 10' do
    it 'should convert to the %h:%m:%s format' do
      time = convert_total_seconds_of(900)
      expect(time).to eq('00:15:00')
    end
  end

  context 'when minutes are less than 10' do
    it 'should convert to the %h:%m:%s format' do
      time = convert_total_seconds_of(240)
      expect(time).to eq('00:04:00')
    end
  end

  context 'when seconds are greater than 10' do
    it 'should convert to the %h:%m:%s format' do
      time = convert_total_seconds_of(90560)
      expect(time).to eq '25:09:20'
    end
  end

  context 'when seconds are less than 10' do
    it 'should convert to the %h:%m:%s format' do
      time = convert_total_seconds_of(368)
      expect(time).to eq '00:06:08'
    end
  end
end
