class CreatePics < ActiveRecord::Migration
  def change
    create_table :pics do |t|

        t.string :image
        t.text   :ocr_text
        t.timestamps

    end
  end
end
