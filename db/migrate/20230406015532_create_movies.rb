class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :gender
      t.string :release_year
      t.string :country
      t.string :director
      t.string :duration
      t.string :rating
      t.date   :date_added
      t.text   :description
      t.text   :listed_in
      t.text   :cast

      t.timestamps
    end
  end
end