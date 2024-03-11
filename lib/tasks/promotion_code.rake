# frozen_string_literal: true

namespace :promotion_code do
  desc 'create promotion code'
  task generate: :environment do
    records = []
    chars = ('A'..'Z').to_a + (0..9).to_a

    10.times do
      records.push(
        {
          code: 7.times.map { chars.sample }.join,
          discount: [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000].sample
        }
      )
    end

    begin
      current = nil
      ApplicationRecord.transaction do
        Promotion.destroy_all
        records.each do |record|
          current = record
          Promotion.create!(
            code: record[:code],
            discount: record[:discount]
          )
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      puts e
      puts current
    end
  end
end
