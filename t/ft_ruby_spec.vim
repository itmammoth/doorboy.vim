runtime! plugin/doorboy.vim

source spec_helper.vim

describe 'ftplugin/ruby'
  before
    new
    filetype plugin on
    set filetype=ruby
  end

  after
    close!
  end

  context 'when putting |ruby'
    it 'should put |ruby|'
      call spec_helper#insert_chars('|ruby')
      Expect getline(1) == '|ruby|'
    end
  end
end
