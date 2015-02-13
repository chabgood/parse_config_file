require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../app/parser.rb'

describe Parser do
  
  it "will error if there is no file " do
    expect { Parser.new() }.to raise_error(RuntimeError, 'A file must be supplied')
  end

  it 'should upload a file' do
    Parser.new(:file => '/home/chabgood/projects/parse_config_file/spec/test_file.txt')
  end

  context "#parse" do
    describe "valid file" do
      let(:new_parser) {Parser.new(:file => '/home/chabgood/projects/parse_config_file/spec/test_file.txt')}
      let(:parsed_file) {new_parser.parse}

      it "should have a result count of 9" do
        expect(parsed_file.results.length).to eq(9)
      end

      it "should ignore comments" do
        size = File.foreach('/home/chabgood/projects/parse_config_file/spec/test_file.txt').inject(0) {|c, line| c+1}
        expect(size).to eq(12)
      end

      it "should have no errors" do
        expect(parsed_file.errors.length).to eq(0)
      end

      it "should match the results" do
        expect(parsed_file.results).to eq(['test.com','55331','2.5','user',true,true,false,'/tmp/logfile.log',true])
      end
    end
  end

  context "#parse" do
    describe "invalid file" do
      let(:new_parser) {Parser.new(:file => '/home/chabgood/projects/parse_config_file/spec/invalid_file.txt')}
      let(:parsed_file) {new_parser.parse}

      it "should have a result count of 7" do
        expect(parsed_file.results.length).to eq(7)
      end

      it "should have 2 errors" do
        expect(parsed_file.errors.length).to eq(2)
      end
    end
  end

end
