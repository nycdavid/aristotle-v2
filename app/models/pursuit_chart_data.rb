class PursuitChartData
  def initialize(pursuit)
    @pursuit = pursuit
    @data_report = DataReport.new(@pursuit)
  end

  def count_backward_from_today(n)
    @dates = count_backward(n)
    format
  end

  def within_range(dates)
    @dates = dates
    format
  end

  private

  def format
    {
      labels: @dates,
      datasets: [
        {
          fillColor: "rgba(52,66,90,0.5)",
          strokeColor: "rgba(220,220,220,0.8)",
          highlightFill: "rgba(52,66,90,0.75)",
          highlightStroke: "rgba(220,220,220,1)",
          label: @pursuit.name,
          data: prepare_data
        }
      ]
    }
  end

  def prepare_data
    @dates.map do |date|
      (@data_report.total_time_on(date) / 60.0 / 60.0).round(1)
    end
  end

  def count_backward(n_days)
    [].tap do |arr|
      n_days.downto(0) do |n|
        arr << (@pursuit.user.now - n.days).strftime("%m/%d/%Y")
      end
    end
  end
end
