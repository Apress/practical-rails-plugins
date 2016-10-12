class Video < ActiveRecord::Base
  UPLOAD_DIR = "#{RAILS_ROOT}/public/tmp"
  VIDEO_DIR  = "#{RAILS_ROOT}/public/videos"

  validates_presence_of :name, :file_name, :file_ext
  attr_protected :converted
  before_create :save_uploaded_file

  def data=(file)
    @tmp_file = file

    timestr = Time.now.strftime('%Y%m%d%H%M%S')
    self.file_name = "#{timestr}-#{file.original_filename.sub(/.\w+$/, '')}"
    self.file_ext = file.original_filename.split('.').last

    # optional: check file.content_type
  end

  def tmp_path
    "#{UPLOAD_DIR}/#{file_name}.#{file_ext}"
  end

  def path
    "#{VIDEO_DIR}/#{file_name}.flv"
  end

  def public_filename
    "/videos/#{file_name}.flv"
  end

  private

    def save_uploaded_file
      Dir.mkdir(UPLOAD_DIR) unless File.exist?(UPLOAD_DIR)
      Dir.mkdir(VIDEO_DIR) unless File.exist?(VIDEO_DIR)

      File.open(tmp_path, "wb") do |f|
        f.write(@tmp_file.read)
      end
    end
end
