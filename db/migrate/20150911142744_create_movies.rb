class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.string :plot
      t.string :poster
      t.text :trailer_url
    end
  end
end
