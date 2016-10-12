class Document < ActiveRecord::Base
  has_attachment :storage => :file_system,
                 :path_prefix => 'public/documents',
                 :content_type => :image,
                 :size => 0..5.megabytes,
                 :resize_to => "800x1100",
                 :thumbnails => {:small=>"80x110",
                                 :medium=> "400x550"}
  validates_as_attachment
  def zip_filename
    filename =~ /\.([^.]*)$/
    extension = $1.downcase
    "#{id}.#{extension}"
  end
end

