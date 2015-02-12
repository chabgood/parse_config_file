require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../app/parser.rb'

describe Parser do
  
  it "will error if there is no file " do
    expect { Parser.new() }.to raise_error(RuntimeError, 'A file must be supplied')
  end

  it 'should upload a file' do
    Parser.new(:file => 'test_file.txt')
  end

  context "Parse config file" do

    before(:all) do
      parser = Parser.new(:file => 'test_file.txt')
      parser.parse
    end

    it "should ignore comments" do
      
    end
  end

end
