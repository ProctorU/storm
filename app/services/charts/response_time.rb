# frozen_string_literal: true

module Charts
  # ResponseTime
  class ResponseTime
    attr_reader(:pings)

    def initialize(pings)
      @pings = pings
    end

    def aggregate
      (response_times + structure).uniq { |h| h[:time] }
    end

    private

    def response_times
      @response_times ||= pings.order(
        :response_time
      ).group_by(
        &:response_time
      ).map do |time, pings|
        [time, pings.size]
      end.group_by do |time, _pings|
        time / 20
      end.map do |time, pings|
        {
          time: (20 * time),
          value: pings.size
        }
      end
    end

    def structure
      Array.new(60) do |n|
        n * 20
      end.map do |int|
        { time: int, value: 0 }
      end
    end
  end
end
