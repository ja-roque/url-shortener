class AddDetailsToUrls < ActiveRecord::Migration[5.2]
  def change
    add_column :urls, :title, :string
    add_column :urls, :hits, :integer
  end
end
