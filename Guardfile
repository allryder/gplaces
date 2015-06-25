# If you want to enable notifications (for instance growl), add
# a ~/.guard.rb file containing at least this line: `ENV.delete "GUARD_NOTIFY`
# to enable/configure notifications.
# See https://github.com/guard/guard/wiki/Shared-configurations
# and https://github.com/guard/guard/wiki/System-notifications
ENV["GUARD_NOTIFY"] = "false"

# Clear the screen before every task
clearing :on

# This group allows to skip running RuboCop when RSpec failed
group :red_green_refactor, halt_on_fail: true do
  guard :rspec, cmd: "bundle exec rspec" do
    require "guard/rspec/dsl"
    dsl = Guard::RSpec::Dsl.new(self)

    # RSpec files
    rspec = dsl.rspec
    watch(rspec.spec_helper) { rspec.spec_dir }
    watch(rspec.spec_support) { rspec.spec_dir }
    watch(rspec.spec_files)

    # Ruby files
    ruby = dsl.ruby
    dsl.watch_spec_files_for(ruby.lib_files)
  end

  guard :rubocop, all_on_start: false, keep_failed: false, cli: "--format simple", notification: false do
    watch(/.+\.rb$/)
    watch("Gemfile")
    watch("Guardfile")
    watch("Rakefile")
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end
end
