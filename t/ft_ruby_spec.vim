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

  context 'when no characters in the current line'
    context 'and putting |'
      it 'should put | twice'
        call spec_helper#insert_chars('|ruby')
        Expect getline(1) == '|ruby|'
      end
    end

    context 'and putting /'
      it 'should put / twice'
        call spec_helper#insert_chars('/ruby')
        Expect getline(1) == '/ruby/'
      end
    end
  end

  context 'in a regular expression'
    context 'and in front of NOT /'
      before
        call spec_helper#put_with_cursor('/(|)/')
      end
      context 'and putting |'
        it 'should put | once'
          call spec_helper#insert_chars('|ruby')
          Expect getline(1) == '/(|ruby)/'
        end
      end
    end
    context 'and in front of /'
      before
        call spec_helper#put_with_cursor('/ruby|/')
      end
      context 'and putting |'
        it 'should skip'
          call spec_helper#insert_chars('/ =~')
          Expect getline(1) == '/ruby/ =~'
        end
      end
    end
  end
end
