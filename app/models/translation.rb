class Translation < ActiveRecord::Base
  has_attached_file :upimg,
                      styles:  { medium: "300x300#", thumb: "100x100#" }
  validates_attachment_content_type :upimg,
                                      content_type: ["image/jpg","image/jpeg","image/png"]
end
