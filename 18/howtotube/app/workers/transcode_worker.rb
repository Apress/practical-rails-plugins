class TranscodeWorker < Workling::Base
  # usage: TranscodeWorker.asynch_convert_video(:video_id => 1)
  def convert_video(options = {})
    video = Video.find_by_id(options[:video_id])
    unless video.nil?
      cmd = "ffmpeg -i #{video.tmp_path} -y -ar 22050 -ab 32 -f flv -s 320x240 #{video.path}"
      system(cmd)

      video.update_attribute(:converted, true)
    end
  end
end
