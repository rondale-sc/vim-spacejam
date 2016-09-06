require 'spec_helper'

shared_context "strips trailing whitespace" do
  it "strips whitespace" do
    write_file(filename, sample_text)

    vim.edit filename
    vim.write

    expect(File.read(filename)).to eql(sample_text.strip + "\n")
  end
end

describe "spacejam.vim" do
  let(:default_filetypes) { 'ruby,javascript,vim,perl,sass,scss,css,coffee,haml' }
  let(:plugin_path) { File.expand_path('../../../',__FILE__) }

  context "overriding defaults" do
    before do
      vim.command "let g:spacejam_filetypes = 'html'"
      vim.add_plugin(plugin_path, 'plugin/spacejam.vim')
    end

    let(:filename) { 'test.html' }
    let(:sample_text) { "<h1>Test</h1>" }

    include_context "strips trailing whitespace"
  end

  context "default filetypes" do
    before do
      vim.add_plugin(plugin_path, 'plugin/spacejam.vim')
    end

    it "sets up a global variable for the list of filetypes" do
      expect(vim.echo "g:spacejam_filetypes").to eql(default_filetypes)
    end

    context "ruby" do
      let(:sample_text) { "blah = 'test'    " }

      context ".rb files" do
        let(:filename)    { 'test.rb' }
        include_context "strips trailing whitespace"
      end

      context ".rake files" do
        let(:filename)    { 'test.rake' }
        include_context "strips trailing whitespace"
      end

      context "Gemfile files" do
        let(:filename)    { 'Gemfile' }
        include_context "strips trailing whitespace"
      end
    end

    context "javascript files" do
      let(:filename) { 'test.js' }
      let(:sample_text) { "var blah = 'test'   " }

      include_context "strips trailing whitespace"
    end

    context "vim files" do
      let(:filename) { 'test.vim' }
      let(:sample_text) { "let l:blah = 'test'   " }

      include_context "strips trailing whitespace"
    end

    context "perl files" do
      let(:filename) { 'test.pl' }
      let(:sample_text) { "$blah='test';    " }

      include_context "strips trailing whitespace"
    end
  end
end
