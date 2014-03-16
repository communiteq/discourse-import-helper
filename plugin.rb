# name: Discourse Import Helper Plugin
# about: Offers a few functions to help the importer task
# version: 1.0
# author: michael@discoursehosting.com

# a rake task cannot specify gems, this works around having to manually edit Gemfile

gem 'mysql2', '0.3.15'
gem 'ruby-bbcode-to-md', '0.0.15'

# offer functions to disable activation emails

after_initialize do

  User.class_eval do
    alias_method :old_create_email_token, :create_email_token
    alias_method :old_email_confirmed?, :email_confirmed?

    def active?
      if SiteSetting.importhelper_disable_activationmails?
        true
      else
        self.active
      end
    end
  
    def email_confirmed?
      if SiteSetting.importhelper_disable_activationmails?
        true
      else
        old_email_confirmed?
      end
    end

    def create_email_token
      if SiteSetting.importhelper_disable_activationmails?
        true
      else
        old_create_email_token
      end
    end
  end

end

