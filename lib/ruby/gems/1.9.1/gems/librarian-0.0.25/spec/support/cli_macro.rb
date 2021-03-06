require "json"
require "pathname"
require "securerandom"
require "stringio"
require "thor"

require "librarian/helpers"

module CliMacro

  class FakeShell < Thor::Shell::Basic
    def stdout
      @stdout ||= StringIO.new
    end
    def stderr
      @stderr ||= StringIO.new
    end
    def stdin
      raise "unsupported"
    end
  end

  class FileMatcher
    attr_accessor :rel_path, :content, :type, :base_path
    def initialize(rel_path, content, options = { })
      self.rel_path = rel_path
      self.content = content
      self.type = options[:type]
    end
    def full_path
      @full_path ||= base_path + rel_path
    end
    def actual_content
      @actual_content ||= begin
        s = full_path.read
        s = JSON.parse(s) if type == :json
        s
      end
    end
    def matches?(base_path)
      base_path = Pathname(base_path) unless Pathname === base_path
      self.base_path = base_path

      full_path.file? && (!content || actual_content == content)
    end
  end

  def self.included(base)
    base.instance_exec do
      let(:project_path) do
        project_path = Pathname.new(__FILE__).expand_path
        project_path = project_path.dirname until project_path.join("Rakefile").exist?
        project_path
      end
      let(:tmp) { project_path.join("tmp/spec/cli") }
      let(:pwd) { tmp + SecureRandom.hex(8) }

      before { tmp.mkpath }
      before { pwd.mkpath }

      after  { tmp.rmtree }
    end
  end

  def cli!(*args)
    Dir.chdir(pwd) do
      described_class.with_environment do |environment|
        begin
          @shell = FakeShell.new
          @exit_status = nil
          described_class.start args, :shell => @shell
          @exit_status = 0
        rescue Librarian::Error => e
          environment.ui.error e.message
          environment.ui.debug e.backtrace.join("\n")
          @exit_status = e.respond_to?(:status_code) ? e.status_code : 1
        rescue Exception => e
          @exit_status = 1
        end
      end
    end
  end

  def write_file!(path, content)
    path = pwd.join(path)
    path.dirname.mkpath
    path.open("wb"){|f| f.write(content)}
  end

  def write_json_file!(path, content)
    write_file! path, JSON.dump(content)
  end

  def strip_heredoc(text)
    Librarian::Helpers.strip_heredoc(text)
  end

  def shell
    @shell
  end

  def stdout
    shell.stdout.string
  end

  def stderr
    shell.stderr.string
  end

  def exit_status
    @exit_status
  end

  def have_file(rel_path, content = nil)
    FileMatcher.new(rel_path, content)
  end

  def have_json_file(rel_path, content)
    FileMatcher.new(rel_path, content, :type => :json)
  end

end
