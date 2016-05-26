runtime! plugin/doorboy.vim

source spec_helper.vim

describe 'ftplugin/ruby'
  before
    new
    filetype plugin on
    set filetype=ruby
    syntax on
  end

  after
    close!
  end

  describe 'putting |'
    context 'NOT in a regular expression'
      it 'should put ||<LEFT>'
        call spec_helper#insert_chars('|ruby')
        Expect getline(1) == '|ruby|'
      end
    end

    context 'in a regular expression'
      before
        call spec_helper#put_with_cursor('/(|)/')
      end
      it 'should put |'
        call spec_helper#insert_chars('|ruby')
        Expect getline(1) == '/(|ruby)/'
      end
    end
  end
end
