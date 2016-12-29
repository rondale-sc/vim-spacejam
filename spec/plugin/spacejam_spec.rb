require 'spec_helper'

shared_context 'strips trailing whitespace' do
  it 'strips whitespace' do
    write_file(filename, sample_text)

    vim.edit filename
    vim.write

    expect(File.read(filename)).to eql(sample_text.strip + "\n")
  end
end

describe 'spacejam.vim' do
  let(:default_filetypes) do
    'ruby,javascript,vim,perl,sass,scss,css,coffee,haml,elixir,eelixir'
  end

  let(:plugin_path) { File.expand_path('../../../', __FILE__) }

  context 'overriding defaults' do
    before do
      vim.command "let g:spacejam_filetypes = 'html'"
      vim.add_plugin(plugin_path, 'plugin/spacejam.vim')
    end

    let(:filename) { 'test.html' }
    let(:sample_text) { '<h1>Test</h1>' }

    include_context 'strips trailing whitespace'
  end

  context 'disabling auto trim' do
    before do
      vim.command "let g:spacejam_autocmd = ''"
      vim.add_plugin(plugin_path, 'plugin/spacejam.vim')
    end

    let(:filename) { 'test.rb' }
    let(:sample_text) { "blah = 'test'    \n" }

    it 'does not strip whitespace' do
      write_file(filename, sample_text)

      vim.edit filename
      vim.write

      expect(File.read(filename)).to eql(sample_text)
    end
  end

  context 'default filetypes' do
    before do
      vim.add_plugin(plugin_path, 'plugin/spacejam.vim')
    end

    it 'sets up a global variable for the list of filetypes' do
      expect(vim.echo('g:spacejam_filetypes')).to eql(default_filetypes)
    end

    context 'ruby' do
      let(:sample_text) { "blah = 'test'    " }

      context '.rb files' do
        let(:filename)    { 'test.rb' }
        include_context 'strips trailing whitespace'
      end

      context '.rake files' do
        let(:filename) { 'test.rake' }
        include_context 'strips trailing whitespace'
      end

      context 'Gemfile files' do
        let(:filename) { 'Gemfile' }
        include_context 'strips trailing whitespace'
      end
    end

    context 'javascript files' do
      let(:filename) { 'test.js' }
      let(:sample_text) { "var blah = 'test'   " }

      include_context 'strips trailing whitespace'
    end

    context 'vim files' do
      let(:filename) { 'test.vim' }
      let(:sample_text) { "let l:blah = 'test'   " }

      include_context 'strips trailing whitespace'
    end

    context 'perl files' do
      let(:filename) { 'test.pl' }
      let(:sample_text) { "$blah='test';    " }

      include_context 'strips trailing whitespace'
    end

    context 'elixir files' do
      before do
        # vim doesn't recognize elixir by default
        vim.command "au BufRead *.ex set ft=elixir"
      end
      let(:filename) { 'test.ex' }
      let(:sample_text) { "$blah='test';    " }

      include_context 'strips trailing whitespace'
    end

    context 'eelixir files' do
      before do
        # vim doesn't recognize eelixir by default
        vim.command "au BufRead *.ex set ft=eelixir"
      end
      let(:filename) { 'test.ex' }
      let(:sample_text) { "$blah='test';    " }

      include_context 'strips trailing whitespace'
    end
  end
end
