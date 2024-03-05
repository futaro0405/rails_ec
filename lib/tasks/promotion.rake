namespace :promotion do
  desc 'create promotion code'
  task :create_code do
    records = []
    10.times do
      codes.push(
        {
          code: 7.times.map{ [('A'..'Z'), ('0'..'9')].to_a.sample }.join,
          discount: [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000].sample
        }
      )
    end

    begin
      current = nil
      ApplicationRecord.transaction do
        records.each do |record|
          current = record
          Promotion.create!(
            code: record[:code],
            discount: record[:discount],
          )
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      puts e
      puts current
    end
  end
end
