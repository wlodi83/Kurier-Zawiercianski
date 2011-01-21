class Notifier < ActionMailer::ARMailer
  def newsletter(user, newsletter)
    recipients user.email
    from "Gazeta Myszkowska"
    subject newsletter.subject
    body :body => newsletter.body, :user => user
  end

end
