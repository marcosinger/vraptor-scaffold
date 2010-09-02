class AppGenerator < VraptorScaffold::Base

  argument :project_path
  class_option :template_engine, :default => :jsp

  def self.source_root
    File.join(File.dirname(__FILE__), "templates")
  end

  def initialize(args, opts=[])
    super([args], opts)
    self.destination_root=(project_path)
    @project_name = project_path.split("/").last
  end

  def create_root_folder
    empty_directory "."
  end

  def create_pom
    template("pom.erb", "pom.xml")
  end

  def create_main_java
    empty_directory Configuration::MAIN_SRC
    directory("src", Configuration::MAIN_SRC + "/app")
  end

  def create_main_resources
    directory("resources", Configuration::MAIN_RESOURCES)
  end

  def create_webapp
    directory("webapp", Configuration::WEB_APP)
  end

  def configure_template_engine
    templates = {"jsp" => JspTemplateEngine, "freemarker" => FreemarkerTemplateEngine}
    templates[options[:template_engine].to_s].new(project_path).configure
    #TemplateEngine.new(project_path, options[:template_engine].to_s).configure
  end

  def create_test
    empty_directory Configuration::TEST_SRC
    directory("src-test", Configuration::TEST_SRC + "/app")
    directory("resources-test", Configuration::TEST_RESOURCES)
  end
end
