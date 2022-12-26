class EnableIntArrayExtension < ActiveRecord::Migration[7.0]
  def change
    enable_extension "intarray"
  end
end
