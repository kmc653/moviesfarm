class AddTimestampsToMovies < ActiveRecord::Migration
  def change
    add_timestamps(:movies)
  end
end
