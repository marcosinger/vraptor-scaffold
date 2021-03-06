require 'simplecov'
SimpleCov.start

require File.dirname(__FILE__) + '/../lib/vraptor-scaffold'

def build_attributes
  [Attribute.new("name", "string"), Attribute.new("myFlag", "boolean")]
end

def mock_config_file
  file = YAML.load_file File.join( File.dirname(__FILE__), "resources", "vraptor-scaffold.properties")
  Configuration.stub!(:config).and_return(file)
end

def mock_objectify_config_file
  file = YAML.load_file File.join( File.dirname(__FILE__), "resources", "vraptor-scaffold-objectify.properties")
  Configuration.stub!(:config).and_return(file)
end

def exists_and_identical?(source, created)
  c = File.open(created).read.gsub( /\r/m, "" )
  c2 = File.open(source).read.gsub( /\r/m, "" )
  c.should == c2
end
