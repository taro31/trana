class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|

        t.text   :source_text
        t.string :target_la
        t.text   :google_tra
        t.text   :azure_tra
        t.timestamps
      
    end
  end
end
