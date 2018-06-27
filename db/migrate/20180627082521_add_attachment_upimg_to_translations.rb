class AddAttachmentUpimgToTranslations < ActiveRecord::Migration
  def self.up
    change_table :translations do |t|
      t.attachment :upimg
    end
  end

  def self.down
    remove_attachment :translations, :upimg
  end
end
