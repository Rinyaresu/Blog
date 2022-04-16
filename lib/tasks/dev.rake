namespace :dev do
  DEFAULT_PASSWORD = 123456

  desc "set development environment"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Deleting BD...") { %x(rails db:drop) }
      show_spinner("Creating BD...") { %x(rails db:create) }
      show_spinner("Migrating BD...") { %x(rails db:migrate) }
      show_spinner("Registering default user...") { %x(rails dev:add_default_user) }
    else
      puts %x'You are not in development environment'
    end
  end

  desc "Add default user"
  task add_default_user: :environment do
    User.create!(
      username: "admin",
      email: "admin@admin.com",
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  private
    def show_spinner(msg_start, msg_end = "Completed!")
      spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
      spinner.auto_spin
      yield
      spinner.success("(#{msg_end})")
    end
end
