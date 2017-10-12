class CreateWeatherRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :weather_requests do |t|
      t.integer :user_id
      t.string :min_temp
      t.string :max_temp
      t.string :precipitation_icon
      t.string :name
      t.string :original_name

      t.timestamps
    end
  end
end
