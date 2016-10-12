class ConferenceMailer < ActionMailer::Base
  def proposed(conference_talk)
    status_update(conference_talk, 'Thanks for your submission')
  end

  def rejected(conference_talk)
    status_update(conference_talk)
  end

  def accepted(conference_talk)
    status_update(conference_talk, 'Your proposal has been accepted!')
  end

  def scheduled(conference_talk)
    status_update(conference_talk, 'Your talk has been scheduled!')
  end

  private

    def status_update(conference_talk, subject = 'Proposal status updated')
      recipients conference_talk.speaker_email  
      from       'noreply@mcetc-conference.com'
      sent_on    Time.now
      subject    "[MCETC] #{subject}"
      body       render_message('status', :conference_talk => conference_talk)
    end
end

